unit LanguageUnit;

interface

uses
  StringMapUnit;

type

  { TLanguage }

  TLanguage = class
  protected
    FStorage: TStringMap;
    function GetItem(const aKey: string): string; inline;
    function GetItemExists(const aKey: string): Boolean; inline;
    function GetMin: TStringMap.TIterator;
  public
    property Items[const aKey: string]: string read GetItem;
    property ItemExists[const aKey: string]: Boolean read GetItemExists;
    property Min: TStringMap.TIterator read GetMin;
    constructor Create(const aStorage: TStringMap);
    function ToDebugText: string;
    destructor Destroy; override;
  end;

implementation

{ TLanguage }

function TLanguage.GetItem(const aKey: string): string;
var
  i: TStringMap.TIterator;
begin
  i := FStorage.Find(aKey);
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

function TLanguage.GetItemExists(const aKey: string): Boolean;
var
  i: TStringMap.TIterator;
begin
  i := FStorage.Find(aKey);
  i.Free;
  result := i <> nil;
end;

function TLanguage.GetMin: TStringMap.TIterator;
begin
  result := FStorage.Min;
end;

constructor TLanguage.Create(const aStorage: TStringMap);
begin
  inherited Create;
  FStorage := aStorage;
end;

function TLanguage.ToDebugText: string;
var
  i: TStringMap.TIterator;
begin
  i := FStorage.Min;
  if
    i <> nil
  then
  begin
    result := '';
    repeat
      result += '"' + i.Key + '": "' + i.Value + '"' + LineEnding;
    until not i.Next;
    i.Free;
  end
  else
    result := 'no items' + LineEnding;
end;

destructor TLanguage.Destroy;
begin
  FStorage.Free;
  inherited Destroy;
end;

end.

