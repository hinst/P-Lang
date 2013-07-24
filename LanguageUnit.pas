unit LanguageUnit;

interface

uses
  LanguageStringMapUnit;

type

  { TLanguage }

  TLanguage = class
  protected
    FStorage: TStringMap;
    function GetItem(const aKey: string): string; inline;
    function GetItemExists(const aKey: string): Boolean; inline;
  public
    property Storage: TStringMap read FStorage;
    property Items[const aKey: string]: string read GetItem; default;
    property ItemExists[const aKey: string]: Boolean read GetItemExists;
    constructor Create(const aStorage: TStringMap);
    function ToDebugText: string;
    destructor Destroy; override;
  end;

implementation

{ TLanguage }

function TLanguage.GetItem(const aKey: string): string;
begin
  if
    Storage.contains(aKey)
  then
    result := Storage[aKey]
  else
    result := '';
end;

function TLanguage.GetItemExists(const aKey: string): Boolean;
begin
  result := Storage.contains(aKey);
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
  i := Storage.Iterator;
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
  Storage.Free;
  inherited Destroy;
end;

end.

