program Test_001;

uses
  LanguageSetUnit, LanguageSetLoaderUnit, LanguageSetLoaderJsonUnit;

var
  l: TLanguageSet;

procedure ListLanguageIds;
var
  i: Integer;
begin
  for i := 0 to l.LanguageIds.Count - 1 do
    Write(l.LanguageIds[i], ' ');
end;

begin
  l := TLanguageSetLoader.LoadFromFile(TLanguageSetLoaderJson, '../Data/sampleLanguage.json');
  ListLanguageIds;
  WriteLN;
  WriteLN(l.ToDebugText);
  l.Free;
end.

