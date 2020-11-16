program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  //Classes
  { you can add units after this }
  SysUtils,
  CSFMLConfig,
  CSFMLGraphics,
  CSFMLNetwork,
  CSFMLSystem,
  CSFMLWindow;

var
  Mode: sfVideoMode;
  Window: PsfRenderWindow;
  Title: string;
  Font: PsfFont;
  Text: PsfText;
  Event: sfEvent;
  TextPos: sfVector2f;
begin
{$ifdef LINUX}
  SetExceptionMask([exInvalidOp, exDenormalized, exZeroDivide, exOverflow, exUnderflow, exPrecision]);

{$endif}
  Mode.Width := 800;
  Mode.Height := 600;
  Mode.BitsPerPixel := 32;

  Title := 'SFML Window - ' + lowerCase({$I %FPCTARGETCPU%}) + '-' + lowerCase({$I %FPCTARGETOS%});
  Window := sfRenderWindow_Create(Mode, PChar(Title), sfUint32(sfResize) or sfUint32(sfClose), nil);
  if not Assigned(Window) then
    raise Exception.Create('Window error');

  // Create a graphical text to display
  Font := sfFont_createFromFile('resources/arial.ttf');
  if not Assigned(Font) then
    raise Exception.Create('Font error');
  Text := sfText_Create();

  sfText_SetString(Text, 'Hello World');
  sfText_SetFont(Text, Font);
  sfText_SetCharacterSize(Text, 50);
  sfText_SetColor(Text, sfWhite);
  TextPos.X := 300;
  TextPos.Y := 20;
  sfText_SetPosition(Text, TextPos);

  // Start the game loop
  while (sfRenderWindow_IsOpen(Window) = sfTrue) do
  begin
    // Process events
    while (sfRenderWindow_PollEvent(Window, @Event) = sfTrue) do
    begin
      // Close window : exit
      if (Event.type_ = sfEvtClosed) then
        sfRenderWindow_Close(Window);
    end;

    // Clear the screen
    sfRenderWindow_clear(Window, sfBlack);

    // Draw the text
    sfRenderWindow_drawText(Window, Text, nil);

    // Update the window
    sfRenderWindow_display(Window);
  end;

  // Cleanup resources
  sfText_Destroy(Text);
  sfFont_Destroy(Font);
  sfRenderWindow_Destroy(Window);
end.

