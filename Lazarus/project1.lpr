program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  //Classes
  { you can add units after this }
  LazUTF8,
  SysUtils,
  {$ifdef LINUX}
  math,
  {$endif}
  ctypes,
  CSFMLConfig,
  CSFMLGraphics,
  CSFMLNetwork,
  CSFMLSystem,
  CSFMLWindow, Unit1;

var
  Mode: sfVideoMode;
  Window: PsfRenderWindow;
  Title: string;
  Event: sfEvent;
  WndPos: sfVector2i;

  Field: TRunText;
  MainClock: PsfClock;
  Elapsed: sfTime;
  TimeElapsed: cfloat;
  DrawCalls: sfUint32;
begin
{$ifdef LINUX}
  SetExceptionMask([exInvalidOp, exDenormalized, exZeroDivide, exOverflow, exUnderflow, exPrecision]);
{$endif}

  Mode.Width := 800;
  Mode.Height := 600;
  Mode.BitsPerPixel := 32;
  WndPos.x := 0;
  WndPos.y := 0;

  //window
  Title := 'SFML Window - ' + lowerCase({$I %FPCTARGETCPU%}) + '-' + lowerCase({$I %FPCTARGETOS%});
  Window := sfRenderWindow_Create(Mode, PChar(Title), sfUint32(sfNone){sfUint32(sfResize) or sfUint32(sfClose)}, nil);
  if not Assigned(Window) then
    raise Exception.Create('Window error');
  sfRenderWindow_setVerticalSyncEnabled(Window, sfFalse);
  sfRenderWindow_setPosition(Window, WndPos);

  //field
  Field := TRunText.Create(300, 300, 210, 50, 'Test text 123 Руский текст', 20);

  //clock
  MainClock := sfClock_create;

  //initialization
  TimeElapsed := 0;
  DrawCalls := 0;

  while (sfRenderWindow_IsOpen(Window) = sfTrue) do
  begin
    while (sfRenderWindow_PollEvent(Window, @Event) = sfTrue) do
    begin
      if (Event.type_ = sfEvtClosed) then
        sfRenderWindow_Close(Window);
      if (Event.type_ = sfEvtKeyPressed) then
        if Event.key.code = sfKeyEscape then
          sfRenderWindow_Close(Window);
    end;
    Elapsed := sfClock_restart(MainClock);
    TimeElapsed := TimeElapsed + (Elapsed.microseconds / 1000000);

    sfRenderWindow_clear(Window, sfBlack);
    Field.Draw(Window);
    sfRenderWindow_display(Window);
    inc(DrawCalls);

    if (TimeElapsed > 1.0) then
    begin
      TimeElapsed := TimeElapsed - 1;
      writeln(DrawCalls);
      DrawCalls := 0;
    end;

  end;

  // Cleanup resources
  sfRenderWindow_Destroy(Window);
end.

