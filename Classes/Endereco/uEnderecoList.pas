unit uEnderecoList;

interface

uses
  Contnrs, uEndereco;

type
  TEnderecoList = class(TObjectList)
  private
    function GetEndereco(Index: Integer): TEndereco;
  public
    constructor Create;
    destructor Destroy; override;
    function Add: TEndereco;
    function Find(Id: Integer): TEndereco;
    property Items[Index: Integer]: TEndereco read GetEndereco;
  end;

implementation

uses Classes;

{ TEnderecoList }

function TEnderecoList.Add: TEndereco;
begin
  Result := TEndereco.Create;
  inherited Add(Result);
end;

constructor TEnderecoList.Create;
begin
  OwnsObjects := True;
end;

destructor TEnderecoList.Destroy;
begin
  inherited Destroy;
end;

function TEnderecoList.Find(Id: Integer): TEndereco;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count-1 do
  begin
    if Items[i].idEndereco = Id then
    begin
      Result := Items[i];
      Break;
    end;
  end;
end;

function TEnderecoList.GetEndereco(Index: Integer): TEndereco;
begin
  Result := TEndereco(inherited Items[Index]);
end;

end.

