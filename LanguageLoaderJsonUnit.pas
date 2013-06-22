unit LanguageLoaderJsonUnit;

interface

uses
  LanguageLoaderUnit,
  jsonparser;

type

  { TLanguageLoaderJson }

  TLanguageLoaderJson = class(TLanguageLoader)
  public
    procedure Load; override;
  end;

implementation

{ TLanguageLoaderJson }

procedure TLanguageLoaderJson.Load;
var
  parser: TJSONParser;
begin
end;

end.

