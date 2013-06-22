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
    class function LoadFromFile(const aLoader: TLanguageSetLoaderClass; const aFileName: string)
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

class function TLanguageSetLoader.LoadFromFile(
  const aLoader: TLanguageSetLoaderClass;
  const aFileName: string
  )
  : TLanguageSet;
var
  l: TLanguageSetLoader;
  s: TStream;
begin
  try
    s := TFileStream.Create(aFileName, fmOpenRead);
    try
      l := aLoader.Create(s);
      l.Load;
    finally
      l.Free;
    end;
    result := l.LanguageSet;
  finally
    s.Free;
  end;
end;

end.

