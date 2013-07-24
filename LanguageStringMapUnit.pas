unit LanguageStringMapUnit;

interface

uses
  gutil,
  ghashmap;

type

  { TStringHash }

  TStringHash = class
  public
    class function hash(const s: string; const n: SizeUInt): SizeUInt;
  end;

  TStringMap = specialize THashmap<string, string, TStringHash>;

implementation

{ TStringHash }

class function TStringHash.hash(const s: string; const n: SizeUInt): SizeUInt;
var
  p: PChar;
begin
  result := 0;
  p := PChar(s);
  while
    p^ <> #0
  do
  begin
    Inc(result, Byte(p^));
    Inc(p);
  end;
  result := result mod n;
end;

end.
