unit uServerMethodsEnderecoIntegracao;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, System.Json, REST.Json, uEnderecoIntegracao, uEnderecoIntegracaoService;

type
{$METHODINFO ON}
  TServerMethodsEnderecoIntegracao = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    function GetEnderecoIntegracao(IDEnderecoIntegracao: integer): TJSONObject;
    function PostEnderecoIntegracao(AEnderecoIntegracao: TEnderecoIntegracao): TJSONObject;
    function PutEnderecoIntegracao(AEnderecoIntegracao: TEnderecoIntegracao): TJSONObject;
    function DeleteEnderecoIntegracao(AEnderecoIntegracao: TEnderecoIntegracao): Boolean;
  end;

{$METHODINFO OFF}

implementation

{ TServerMethodsEnderecoIntegracao }

function TServerMethodsEnderecoIntegracao.GetEnderecoIntegracao(IDEnderecoIntegracao: integer): TJSONObject;
var
  AEnderecoIntegracao: TEnderecoIntegracao;
  AEnderecoIntegracaoService: TEnderecoIntegracaoService;
begin
  AEnderecoIntegracao := TEnderecoIntegracao.Create;
  AEnderecoIntegracaoService := TEnderecoIntegracaoService.Create;
  try
    AEnderecoIntegracaoService.Load(IDEnderecoIntegracao, AEnderecoIntegracao);
    Result := TJson.ObjectToJsonObject(AEnderecoIntegracao);
  finally
    FreeAndNil(AEnderecoIntegracaoService);
    FreeAndNil(AEnderecoIntegracao);
  end;
end;

function TServerMethodsEnderecoIntegracao.PostEnderecoIntegracao(AEnderecoIntegracao: TEnderecoIntegracao): TJSONObject;
var
  AEnderecoIntegracaoService: TEnderecoIntegracaoService;
begin
  AEnderecoIntegracaoService := TEnderecoIntegracaoService.Create;
  try
    AEnderecoIntegracaoService.Insert(AEnderecoIntegracao);
    Result := TJson.ObjectToJsonObject(AEnderecoIntegracao);
  finally
    FreeAndNil(AEnderecoIntegracaoService);
  end;
end;

function TServerMethodsEnderecoIntegracao.PutEnderecoIntegracao(AEnderecoIntegracao: TEnderecoIntegracao): TJSONObject;
var
  AEnderecoIntegracaoService: TEnderecoIntegracaoService;
begin
  AEnderecoIntegracaoService := TEnderecoIntegracaoService.Create;
  try
    AEnderecoIntegracaoService.Save(AEnderecoIntegracao);
    Result := TJson.ObjectToJsonObject(AEnderecoIntegracao);
  finally
    FreeAndNil(AEnderecoIntegracaoService);
  end;
end;

function TServerMethodsEnderecoIntegracao.DeleteEnderecoIntegracao(AEnderecoIntegracao: TEnderecoIntegracao): Boolean;
var
  AEnderecoIntegracaoService: TEnderecoIntegracaoService;
begin
  AEnderecoIntegracaoService := TEnderecoIntegracaoService.Create;
  try
    Result := AEnderecoIntegracaoService.Delete(AEnderecoIntegracao);
  finally
    FreeAndNil(AEnderecoIntegracaoService);
  end;
end;

end.

