unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  ctypes,
  SysUtils,
  CSFMLConfig,
  CSFMLGraphics,
  CSFMLSystem;

type
  TRunText = class(TObject)
  private
    FTextObj: PsfText;
    FSpriteObj: PsfSprite;
    FFontObj: PsfFont;
    FFontSize: sfUint32;
    FRenderTex: PsfRenderTexture;
  public
    constructor Create(xPos, yPos: cfloat; AWidth, AHeight: sfUint32; AText: string; ASize: sfUint32);
    destructor Destroy; override;

    procedure Draw(const Wnd: PsfRenderWindow);
  end;

implementation

constructor TRunText.Create(xPos, yPos: cfloat; AWidth, AHeight: sfUint32; AText: string; ASize: sfUint32);
var pos: sfVector2f;
//tex: PsfTexture;
str: UTF8String;
pstr: PWideChar;
temp: UCS4String;
begin
  inherited Create;
  FTextObj := sfText_Create();
  FSpriteObj := sfSprite_create();
  FFontObj := sfFont_createFromFile('resources/arial.ttf');
  FFontSize := ASize;
  FRenderTex := sfRenderTexture_create(AWidth, AHeight, sfFalse);

  if not(Assigned(FTextObj) and Assigned(FSpriteObj) and Assigned(FFontObj)) then Exception.Create('Create field exception');

  //tex := sfFont_getTexture(FFontObj, FFontSize);
  //sfTexture_setSmooth(tex, sfTrue);

  sfText_setFont(FTextObj, FFontObj);
  sfText_setCharacterSize(FTextObj, FFontSize);
  sfText_setStyle(FTextObj, ord(sfTextRegular));
  sfText_setFillColor(FTextObj, sfWhite);
  pos.x := 0;
  pos.y := 0;
  sfText_setPosition(FTextObj, pos);
  //str := AText;
  //pstr := PWideChar(str);
  //sfText_setUnicodeString(FTextObj, PsfUint32(pstr));
  temp := UnicodeStringToUCS4String(UnicodeString(AText));
  sfText_setUnicodeString(FTextObj, PsfUint32(temp));
  //sfText_setString(FTextObj, (AText));

  sfRenderTexture_clear(FRenderTex, sfMagenta);
  sfRenderTexture_drawText(FRenderTex, FTextObj, nil);
  sfRenderTexture_display(FRenderTex);

  sfSprite_setTexture(FSpriteObj, sfRenderTexture_getTexture(FRenderTex), sfTrue);
  pos.x := xPos;
  pos.y := yPos;
  sfSprite_setPosition(FSpriteObj, pos);
end;

destructor TRunText.Destroy;
begin
  if Assigned(FTextObj) then
    sfText_Destroy(FTextObj);

  if Assigned(FSpriteObj) then
    sfSprite_destroy(FSpriteObj);

  if Assigned(FFontObj) then
    sfFont_Destroy(FFontObj);

  if Assigned(FRenderTex) then
    sfRenderTexture_destroy(FRenderTex);

  inherited;
end;

procedure TRunText.Draw(const Wnd: PsfRenderWindow);
begin
  sfRenderWindow_drawSprite(Wnd, FSpriteObj, nil);
end;

end.

