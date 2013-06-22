unit LanguageLoaderUnit;

interface

uses
  Classes,
  LanguageUnit;

type

  { TLanguageLoader }

  TLanguageLoader = class
  protected
    FStream: TStream;
    FLanguage: TLanguage;
    property Stream: TStream read FStream;
  public
    property Language: TLanguage read FLanguage;
    procedure Load; virtual; abstract;
    constructor Create(const aStream: TStream);
  end;

implementation

{ TLanguageLoader }

constructor TLanguageLoader.Create(const aStream: TStream);
begin
  inherited Create;
  FStream := aStream;
end;

end.

