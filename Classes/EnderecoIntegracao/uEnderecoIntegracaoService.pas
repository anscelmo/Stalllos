unit uEnderecoIntegracaoService;

interface

uses
  SysUtils, UEnderecoIntegracao, UEnderecoIntegracaoList, uEnderecoIntegracaoDAO;

type
  TEnderecoIntegracaoService = class
  private
    FEnderecoIntegracaoDAO: TEnderecoIntegracaoDAO;
  public
    constructor Create;
    destructor Destroy; override;

    function Load(idEnderecoIntegracao: Integer; AEnderecoIntegracao: TEnderecoIntegracao): Boolean;
    function Save(AEnderecoIntegracao: TEnderecoIntegracao): Boolean;
    function Delete(AEnderecoIntegracao: TEnderecoIntegracao): Boolean;
    function Insert(AEnderecoIntegracao: TEnderecoIntegracao): Boolean;
    function LoadList(var AEnderecoIntegracaoList: TEnderecoIntegracaoList): Boolean;
  published
    property EnderecoIntegracaoDAO: TEnderecoIntegracaoDAO read FEnderecoIntegracaoDAO write FEnderecoIntegracaoDAO;
  end;

implementation

constructor TEnderecoIntegracaoService.Create;
begin
  FEnderecoIntegracaoDAO := TEnderecoIntegracaoDAO.Create;
end;

destructor TEnderecoIntegracaoService.Destroy;
begin
  FreeAndNil(FEnderecoIntegracaoDAO);
  inherited;
end;

function TEnderecoIntegracaoService.Load(idEnderecoIntegracao: Integer; AEnderecoIntegracao: TEnderecoIntegracao): Boolean;
begin
  Result := EnderecoIntegracaoDAO.Load(idEnderecoIntegracao, AEnderecoIntegracao);
end;

function TEnderecoIntegracaoService.Save(AEnderecoIntegracao: TEnderecoIntegracao): Boolean;
begin
  Result := FEnderecoIntegracaoDAO.Save(AEnderecoIntegracao);
end;

function TEnderecoIntegracaoService.Delete(AEnderecoIntegracao: TEnderecoIntegracao): Boolean;
begin
  Result := FEnderecoIntegracaoDAO.Delete(AEnderecoIntegracao);
end;

function TEnderecoIntegracaoService.Insert(AEnderecoIntegracao: TEnderecoIntegracao): Boolean;
begin
  Result := FEnderecoIntegracaoDAO.Insert(AEnderecoIntegracao);
end;

function TEnderecoIntegracaoService.LoadList(var AEnderecoIntegracaoList: TEnderecoIntegracaoList): Boolean;
begin
  Result := FEnderecoIntegracaoDAO.LoadList(AEnderecoIntegracaoList);
end;

end.

