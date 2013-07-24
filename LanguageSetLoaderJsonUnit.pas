unit LanguageSetLoaderJsonUnit;

interface

uses
  Classes,
  jsonparser, fpjson,
  LanguageStringMapUnit,
  LanguageUnit, LanguageSetUnit, LanguageSetLoaderUnit;

type

  { TLanguageSetLoaderJson }

  TLanguageSetLoaderJson = class(TLanguageSetLoader)
  protected
    procedure LoadFromData(const aData: TJSONData);
    procedure LoadLanguage(const aKey: string; const aData: TJsonData);
    function LoadTexts(const aData: TJsonObject): TStringMap;
    function LoadLanguageFromObject(const aData: TJsonObject): TLanguage;
    procedure RaiseException(const aMessage: string);
  public
    constructor Create(const aStream: TStream); override;
    procedure Load; override;
  end;

  TLanguageSetLoaderJsonException = class(TLanguageSetLoaderException);

implementation

{ TLanguageSetLoaderJson }

procedure TLanguageSetLoaderJson.LoadFromData(const aData: TJSONData);
var
  i: Integer;
begin
  if aData.JSONType <> jtObject then
    RaiseException('Root element is not an object');
  for i := 0 to aData.Count - 1 do
    LoadLanguage(TJsonObject(aData).Names[i], aData.Items[i]);
end;

procedure TLanguageSetLoaderJson.LoadLanguage(const aKey: string; const aData: TJsonData);
begin
  if aData.JSONType <> jtObject then
    RaiseException('Language is not an object: "' + aKey + '"');
  FLanguageSet.LanguageIds.Add(aKey);
  FLanguageSet.Languages.Add(LoadLanguageFromObject(TJsonObject(aData)));
end;

function TLanguageSetLoaderJson.LoadTexts(const aData: TJsonObject): TStringMap;
var
  o: TJsonObject;
  currentKey: string;
  currentValue: TJsonData;
  i: Integer;
begin
  result := TStringMap.Create;
  o := TJsonObject(aData);
  for i := 0 to o.Count - 1 do
  begin
    currentKey := o.Names[i];
    currentValue := o.Items[i];
    if
      currentValue.JSONType <> jtString
    then
      RaiseException('Item is not a string: "' + currentKey + '"');
    result.Insert(currentKey, currentValue.AsString);
  end;
end;

function TLanguageSetLoaderJson.LoadLanguageFromObject(const aData: TJsonObject): TLanguage;
begin
  result := TLanguage.Create(LoadTexts(aData));
end;

procedure TLanguageSetLoaderJson.RaiseException(const aMessage: string);
begin
  raise TLanguageSetLoaderJsonException.Create(aMessage);
end;

constructor TLanguageSetLoaderJson.Create(const aStream: TStream);
begin
  inherited Create(aStream);
end;

procedure TLanguageSetLoaderJson.Load;
var
  parser: TJSONParser;
  data: TJSONData;
begin
  FLanguageSet := TLanguageSet.Create;
  parser := TJSONParser.Create(Stream);
  data := parser.Parse;
  LoadFromData(data);
  data.Free;
  parser.Free;
end;

end.

