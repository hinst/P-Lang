unit LanguageSetLoaderUnit;

interface

uses
  Classes, SysUtils,
  LanguageSetUnit;

type

  TLanguageSetLoaderClass = class of TLanguageSetLoader;

  { TLanguageSetLoader }

  TLanguageSetLoader = class
  protected
    FStream: TStream;
    FLanguageSet: TLanguageSet;
    property Stream: TStream read FStream;
  public
    property LanguageSet: TLanguageSet read FLanguageSet;
    constructor Create(const aStream: TStream); virtual;
    procedure Load; virtual; abstract;
    class function LoadFromStream(const aStream: TStream): TLanguageSet;
    class function LoadFromResource(const aName: string; const aType: PChar): TLanguageSet;
    class function LoadFromFile(const aFileName: string)
      : TLanguageSet;
  end;

  TLanguageSetLoaderException = class(Exception);

implementation

{ TLanguageSetLoader }

constructor TLanguageSetLoader.Create(const aStream: TStream);
begin
  inherited Create;
  FStream := aStream;
end;

class function TLanguageSetLoader.LoadFromStream(const aStream: TStream): TLanguageSet;
var
  l: TLanguageSetLoader;
begin
  try
    l := self.Create(aStream);
    l.Load;
    result := l.LanguageSet;
  finally
    l.Free;
  end;
end;

class function TLanguageSetLoader.LoadFromResource(const aName: string; const aType: PChar)
  : TLanguageSet;
var
  s: TResourceStream;
begin
  s := nil;
  try
    s := TResourceStream.Create(HINSTANCE, aName, aType);
    result := LoadFromStream(s);
  finally
    s.Free;
  end;
end;

class function TLanguageSetLoader.LoadFromFile(const aFileName: string): TLanguageSet;
var
  s: TStream;
begin
  s := nil;
  try
    s := TFileStream.Create(aFileName, fmOpenRead);
    result := LoadFromStream(s);
  finally
    s.Free;
  end;
end;

end.

