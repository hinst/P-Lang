unit LanguageUnit;

interface

uses
  StringMapUnit;

type

  { TLanguage }

  TLanguage = class
  protected
    FStorage: TStringMap;
  public
    function GetString(const aString: string): String;
  end;

implementation

{ TLanguage }

function TLanguage.GetString(const aString: string): String;
var
  i: TStringMap.TIterator;
begin
  i := FStorage.Find(aString);
  if
    i = nil
  then
    result := ''
  else
  begin
    result := i.Value;
    i.Free;
  end;
end;

end.

