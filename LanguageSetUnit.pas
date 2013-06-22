unit LanguageSetUnit;

interface

uses
  Classes,
  SysUtils,
  fgl,
  StringMapUnit,
  LanguageUnit;

type

  { TLanguageSet }

  TLanguageSet = class
  protected
    type TLanguages = specialize TFPGList<TLanguage>;
    var FLanguages: TLanguages;
    var FLanguageIds: TStringList;
  public
    property Languages: TLanguages read FLanguages;
    property LanguageIds: TStringList read FLanguageIds;
    constructor Create;
    function ToDebugText: string;
    function InconsistenciesToDebugText: string;
    destructor Destroy; override;
  end;

implementation

{ TLanguageSet }

constructor TLanguageSet.Create;
begin
  FLanguages := TLanguages.Create;
  FLanguageIds := TStringList.Create;
end;

function TLanguageSet.ToDebugText: string;
var
  i: Integer;
begin
  result :=
    'Languages: '
    + '(ids: ' + IntToStr(LanguageIds.Count) + ',  langs: ' + IntToStr(Languages.Count) + ')'
    + LineEnding;
  for i := 0 to Languages.Count - 1 do
    result += '[' + LanguageIds[i] + ']' + LineEnding + Languages[i].ToDebugText;
end;

function TLanguageSet.InconsistenciesToDebugText: string;
var
  r: string;

  procedure checkItBack(const aIterator: TStringMap.TIterator);
  var
    key, value: string;
  begin
    repeat
      key := aIterator.Key;
      value := aIterator.Value;
      if not Languages[0].ItemExists[key] then
        r += 'No such entry in the default language: "' + key + '"';
    until not aIterator.Next;
  end;

  procedure checkBack(const aIndex: integer);
  var
    languageIterator: TStringMap.TIterator;
  begin
    languageIterator := Languages[aIndex].Min;
    if
      languageIterator <> nil
    then
    begin
      checkItBack(languageIterator);
      languageIterator.Free;
    end;
  end;

  procedure checkItForward(const aKey: string);
  var
    i: Integer;
  begin
    for i := 0 to Languages.Count - 1 do
    begin
      if not Languages[i].ItemExists[aKey] then
        r += LanguageIds[i] + ' does not contain "' + aKey + '"' + LineEnding;
    end;
  end;

  procedure checkForward;
  var
    key: string;
    languageIterator: TStringMap.TIterator;
  begin
    languageIterator := Languages[0].Min;
    if
      languageIterator <> nil
    then
    begin
      repeat
        key := languageIterator.Key;
        checkItForward(key);
      until not languageIterator.Next;
      languageIterator.Free;
    end;
  end;

var
  i: Integer;
begin
  if
    Languages.Count = 1
  then
    r :=
      'There is only one language;'
      + ' it is impossible to search for inconsistencies.'
  else
  begin
    r := '';
    for i := 1 to Languages.Count - 1 do
      checkBack(i);
    if
      r = ''
    then
      r := 'No reversed inconsistencies found.' + LineEnding;
    checkForward;
  end;
end;

destructor TLanguageSet.Destroy;
begin
  FLanguageIds.Free;
  FLanguages.Free;
  inherited Destroy;
end;

end.

