unit uEnderecoService;

interface

uses
  SysUtils, UEndereco, UEnderecoList, uEnderecoDAO;

type
  TEnderecoService = class
  private
    FEnderecoDAO: TEnderecoDAO;
  public
    constructor Create;
    destructor Destroy; override;
    function Load(idEndereco: Integer; AEndereco: TEndereco): Boolean;
    function Save(AEndereco: TEndereco): Boolean;
    function Delete(AEndereco: TEndereco): Boolean;
    function Insert(AEndereco: TEndereco): Boolean;
    function LoadList(AEnderecoList: TEnderecoList): Boolean;
    function LoadLast(AEndereco: TEndereco): Boolean;
  published
    property EnderecoDAO: TEnderecoDAO read FEnderecoDAO write FEnderecoDAO;
  end;

implementation

constructor TEnderecoService.Create;
begin
  FEnderecoDAO := TEnderecoDAO.Create;
end;

destructor TEnderecoService.Destroy;
begin
  FreeAndNil(FEnderecoDAO);
  inherited;
end;

function TEnderecoService.Load(idEndereco: Integer; AEndereco: TEndereco): Boolean;
begin
  Result := EnderecoDAO.Load(idEndereco, AEndereco);
end;

function TEnderecoService.LoadLast(AEndereco: TEndereco): Boolean;
begin
  Result := EnderecoDAO.LoadLast(AEndereco);
end;

function TEnderecoService.Save(AEndereco: TEndereco): Boolean;
begin
  Result := FEnderecoDAO.Save(AEndereco);
end;

function TEnderecoService.Delete(AEndereco: TEndereco): Boolean;
begin
  Result := FEnderecoDAO.Delete(AEndereco);
end;

function TEnderecoService.Insert(AEndereco: TEndereco): Boolean;
begin
  Result := FEnderecoDAO.Insert(AEndereco);
end;

function TEnderecoService.LoadList(AEnderecoList: TEnderecoList): Boolean;
begin
  Result := FEnderecoDAO.LoadList(AEnderecoList);
end;

end.

