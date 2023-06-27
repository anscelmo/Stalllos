unit uPessoaList;

interface

uses
  Contnrs, uPessoa;

type
  TPessoaList = class(TObjectList)
  private
    function GetPessoa(Index: Integer): TPessoa;
  public
    constructor Create;
    destructor Destroy; override;
    function Add: TPessoa;
    function Find(Id: Integer): TPessoa;
    property Items[Index: Integer]: TPessoa read GetPessoa;
  end;

implementation

uses Classes;

{ TPessoaList }

function TPessoaList.Add: TPessoa;
begin
  Result := TPessoa.Create;
  inherited Add(Result);
end;

constructor TPessoaList.Create;
begin
  OwnsObjects := True;
end;

destructor TPessoaList.Destroy;
begin
  inherited Destroy;
end;

function TPessoaList.Find(Id: Integer): TPessoa;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count-1 do
  begin
    if Items[i].idpessoa = Id then
    begin
      Result := Items[i];
      Break;
    end;
  end;
end;

function TPessoaList.GetPessoa(Index: Integer): TPessoa;
begin
  Result := TPessoa(inherited Items[Index]);
end;

end.

