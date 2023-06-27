unit uEnderecoIntegracaoList;

interface

uses
  Contnrs, uEnderecoIntegracao;

type
  TEnderecoIntegracaoList = class(TObjectList)
  private
    function GetEnderecoIntegracao(Index: Integer): TEnderecoIntegracao;
  public
    constructor Create;
    destructor Destroy; override;
    function Add: TEnderecoIntegracao;
    function Find(Id: Integer): TEnderecoIntegracao;
    property Items[Index: Integer]: TEnderecoIntegracao read GetEnderecoIntegracao;
  end;

implementation

uses Classes;

{ TEnderecoIntegracaoList }

function TEnderecoIntegracaoList.Add: TEnderecoIntegracao;
begin
  Result := TEnderecoIntegracao.Create;
  inherited Add(Result);
end;

constructor TEnderecoIntegracaoList.Create;
begin
  OwnsObjects := True;
end;

destructor TEnderecoIntegracaoList.Destroy;
begin
  inherited Destroy;
end;

function TEnderecoIntegracaoList.Find(Id: Integer): TEnderecoIntegracao;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count-1 do
  begin
    if Items[i].idendereco = Id then
    begin
      Result := Items[i];
      Break;
    end;
  end;
end;

function TEnderecoIntegracaoList.GetEnderecoIntegracao(Index: Integer): TEnderecoIntegracao;
begin
  Result := TEnderecoIntegracao(inherited Items[Index]);
end;

end.

