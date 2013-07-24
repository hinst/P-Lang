unit LanguageListUnit;

{$mode objfpc}{$H+}

interface

uses
  fgl,
  LanguageUnit;

type
  TCustomLanguageList = specialize TFPGList<TLanguage>;

  { TLanguageList }

  TLanguageList = class(TCustomLanguageList)
  public
    procedure ReleaseContent;
  end;

implementation

{ TLanguageList }

procedure TLanguageList.ReleaseContent;
var
  language: TLanguage;
begin
  for language in self do
  begin
    language.Free;
  end;
end;

end.

