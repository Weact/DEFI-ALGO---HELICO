program helico;

uses crt, SDL2, SDL2_image;
const
        sdlWw1 = 1280;
        sdlWh1 = 960;
        sdlWw2 = 500;
        sdlWh2 = 500;
var
        sdlWindow1 : PSDL_Window;
        sdlWindow2 : PSDL_Window;
        sdlRenderer : PSDL_Renderer;
        sdlRenderer2 : PSDL_Renderer;
        sdlSurface1 : PSDL_Surface;
        sdlSurface2 : PSDL_Surface;
        sdlSurfaceRect : PSDL_Surface;
        sdlTexture1 : PSDL_Texture;
        sdlTexture2 : PSDL_Texture;
        sdlTextureRect : PSDL_Texture;
        sdlHelicArea : TSDL_Rect;
        sdlRiderArea : TSDL_Rect;
        sdlRect : TSDL_Rect;
        sdlView : TSDL_Rect;
        sdlView2 : TSDL_Rect;
        sdlEvent : PSDL_Event;
        programState : boolean;
        sdlKeyboardStateEvent: PUInt8;
        i : INTEGER;


procedure sColor(color : STRING); //Procedure personnalisee pour le changement de couleur texte console
begin
        case color of
                'blue': TextColor(blue);
                'red': TextColor(red);
                'white': TextColor(white);
                'yellow': TextColor(yellow);
                'black': TextColor(black);
                'green': TextColor(green);
                'magenta': TextColor(magenta);
                'cyan': TextColor(cyan);
        end;
end;

procedure rColor(); //Procedure personnalisee pour la reinitialisation de couleur texte console (blanc)
begin
        TextColor(white);
end;

procedure introduction(); //procedure introduction difference sdl sdl2
begin
        sColor('red');//Rouge
        writeln('SDL2 Introduction');
        writeln('/*/*/*/ Simple DirectMedia Layer /*/*/*/ ');
        rColor();//Reset -> Blanc.
        writeln('-----------------------------------------------');
        Delay(500);
        sColor('green');//Vert
        writeln('Diff'#233'rence entre SDL et SDL2'); rColor();
        Delay(500);

        sColor('cyan');//Bleu cyan
        writeln('1. Performance : SDL2 > SDL');
        Delay(250);
        writeln('2. >SDL< 1998-2001 Developpement par Sam Lantinga. Entreprise "Loki Games".');
        Delay(250);
        writeln('3. >SDL2< 2013: D'#233'veloppement de la SDL2.');
        Delay(250);
        writeln('4. >SDL2< Inclus: Nouvelles fonctionalit'#233'es, permettant le d'#233'veloppement plus performant/large.');
        Delay(250);
        writeln('5. >SDL2< Biblioth'#232'ques traduites en Pascal. Ce qui fait de se language un puissant outil pour les D'#233'veloppeurs Pascal.');
        rColor();
end;

procedure sdlErrorInit();
begin
        sColor('red');
        writeln('--------------------------');
        writeln('D'#233'sol'#233', une erreur est survenue.');
        writeln('--------------------------');
        rColor();
        Delay(2000);
end;

BEGIN
clrscr;

introduction(); //Messages d'introduction, differences SDL/SDL2

readln();//readln qui s'affiche dans la console par clique droit (???)

    if SDL_Init(SDL_INIT_VIDEO) < 0 then HALT(1);
    SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_INFORMATION,'Ouverture','WELCOME',nil);

    sdlWindow1 := SDL_CreateWindow('SDL',50,50,sdlWw1,sdlWh1,SDL_WINDOW_SHOWN);
    sdlRenderer := SDL_CreateRenderer(sdlWindow1,-1,SDL_RENDERER_SOFTWARE);
    sdlWindow2 := SDL_CreateWindow('BitmapSDL',50,50,sdlWw2,sdlWh2,SDL_WINDOW_SHOWN);
    sdlRenderer2 := SDL_CreateRenderer(sdlWindow2,-1,SDL_RENDERER_SOFTWARE);

    sdlRect.x := 12;
    sdlRect.y := 25;
    sdlRect.w := 178;
    sdlRect.h := 116;

    new(sdlEvent);

    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY,'nearest');



    sdlHelicArea.x := 25;
    sdlHelicArea.y := 50;
    sdlHelicArea.w := 250;
    sdlHelicArea.h := 100;

    sdlRiderArea.x := 0;
    sdlRiderArea.y := 0;
    sdlHelicArea.w := 123;
    sdlHelicArea.h := 87;

    sdlSurface1 := IMG_Load('helicopter.png');
    if sdlSurface1 = nil then;

    sdlSurface2 := SDL_LoadBMP('rider.bmp');
    if sdlSurface1 = nil then Halt;

    sdlSurfaceRect := SDL_LoadBMP('fpsdl.bmp');
    if sdlSurfaceRect = nil then HALT;

    sdlTexture1 := SDL_CreateTextureFromSurface(sdlRenderer,sdlSurface1);
    if sdlTexture1 = nil then Halt;

    sdlTexture2 := SDL_CreateTextureFromSurface(sdlRenderer2, sdlSurface2);
    if sdlTexture2 = nil then Halt;

    sdlTextureRect := SDL_CreateTextureFromSurface(sdlRenderer,sdlSurfaceRect);
    if sdlTextureRect = nil then Halt;

    sdlView.x := 0;
    sdlView.y := 0;
    sdlView.w := 128;
    sdlView.h := 55;

    sdlView2.x := 0;
    sdlView2.y := 0;
    sdlView2.w := 123;
    sdlView2.h := 87;


    SDL_RenderPresent(sdlRenderer);
    SDL_RenderPresent(sdlRenderer2);

    //SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_INFORMATION,'D‚marrage du programme.','SDL HELICO - PROJET LUDUS ACADEMIE.',nil);
    writeln;
    while programState = false do
    begin
       SDL_PumpEvents;
       sdlKeyboardStateEvent := SDL_GetKeyboardState(nil);

       if sdlKeyboardStateEvent[SDL_SCANCODE_ESCAPE] = 1 then
       programState := true;

       if sdlKeyboardStateEvent[SDL_SCANCODE_W] = 1 then
        sdlHelicArea.y :=sdlHelicArea.y-10;
       if sdlKeyboardStateEvent[SDL_SCANCODE_A] = 1 then
        sdlHelicArea.x := sdlHelicArea.x -10;
       if sdlKeyboardStateEvent[SDL_SCANCODE_S] = 1 then
        sdlHelicArea.y := sdlHelicArea.y + 10;
       if sdlKeyboardStateEvent[SDL_SCANCODE_D] = 1 then
        sdlHelicArea.x := sdlHelicArea.x + 10;
       if sdlKeyboardStateEvent[SDL_SCANCODE_F] = 1 then
       begin
        writeln('Coordonn‚e X de l''helico : ', sdlHelicArea.x);
        writeln('Coordonn‚e Y de l''helico : ', sdlHelicArea.y);
       end;

        if sdlHelicArea.x > (sdlWw1 - sdlHelicArea.w) then
                sdlHelicArea.x := (sdlWw1 - sdlHelicArea.w);
        if sdlHelicArea.x < 0 then
                sdlHelicArea.x := 0;
        if sdlHelicArea.y > (sdlWh1 - sdlHelicArea.h) then
                sdlHelicArea.y := (sdlWh1 - sdlHelicArea.h);
        if sdlHelicArea.y < 0 then
                sdlHelicArea.y := 0;

       sdlView.x := sdlView.x + 128;
       if sdlView.x > 512 then
       begin
        sdlView.x := 0;
       end;

       SDL_RenderCopy(sdlRenderer,sdlTextureRect,@sdlRect,@sdlRect);
       SDL_RenderCopy(sdlRenderer,sdlTexture1,@sdlView, @sdlHelicArea);
       SDL_RenderCopy(sdlRenderer2,sdlTexture2,nil,nil);


       SDL_RenderPresent(sdlRenderer);
       SDL_RenderPresent(sdlRenderer2);
       SDL_Delay(20);
       SDL_RenderClear(sdlRenderer);
       SDL_RenderClear(sdlRenderer2);
    end;

    SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_INFORMATION,'Quitter','Fin du programme.',nil);

    dispose(sdlEvent);
    SDL_DestroyTexture(sdlTexture1);
    SDL_DestroyTexture(sdlTexture2);
    SDL_DestroyTexture(sdlTextureRect);
    SDL_FreeSurface(sdlSurface1);
    SDL_FreeSurface(sdlSurface2);
    SDL_FreeSurface(sdlSurfaceRect);
    SDL_DestroyRenderer(sdlRenderer);
    SDL_DestroyRenderer(sdlRenderer2);
    SDL_DestroyWindow(sdlWindow1);
    SDL_DestroyWindow(sdlWindow2);

    SDL_Quit;

END.

