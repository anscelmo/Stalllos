unit uPessoaService;

interface

uses
  SysUtils, UPessoa, UPessoaList, uPessoaDAO;

type
  TPessoaService = class
  private
    FPessoaDAO: TPessoaDAO;
  public
    constructor Create;
    destructor Destroy; override;

    function Load(var idPessoa: Integer; APessoa: TPessoa): Boolean;
    function Save(APessoa: TPessoa): Boolean;
    function Delete(APessoa: TPessoa): Boolean;
    function Insert(APessoa: TPessoa): Boolean;
    function LoadList(var APessoaList: TPessoaList): Boolean;
    function LoadLast(var APessoa: TPessoa): Boolean;
  published
    property PessoaDAO: TPessoaDAO read FPessoaDAO write FPessoaDAO;
  end;

implementation

constructor TPessoaService.Create;
begin
  FPessoaDAO := TPessoaDAO.Create;
end;

destructor TPessoaService.Destroy;
begin
  FreeAndNil(FPessoaDAO);
  inherited;
end;

function TPessoaService.Load(var idPessoa: Integer; APessoa: TPessoa): Boolean;
begin
  Result := PessoaDAO.Load(idPessoa, APessoa);
end;

function TPessoaService.LoadLast(var APessoa: TPessoa): Boolean;
begin
  Result := PessoaDAO.LoadLast(APessoa);
end;

function TPessoaService.Save(APessoa: TPessoa): Boolean;
begin
  Result := FPessoaDAO.Save(APessoa);
end;

function TPessoaService.Delete(APessoa: TPessoa): Boolean;
begin
  Result := FPessoaDAO.Delete(APessoa);
end;

function TPessoaService.Insert(APessoa: TPessoa): Boolean;
begin
  Result := FPessoaDAO.Insert(APessoa);
end;

function TPessoaService.LoadList(var APessoaList: TPessoaList): Boolean;
begin
  Result := FPessoaDAO.LoadList(APessoaList);
end;

end.

