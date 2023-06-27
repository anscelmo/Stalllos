unit uServerMethodsEndereco;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, System.Json, REST.Json, uEndereco, uEnderecoService,
  REST.Client, System.JSON.Utils, REST.Json.Types, REST.Utils;

type
{$METHODINFO ON}
  TServerMethodsEndereco = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    function GetEndereco(IDEndereco: integer): TJSONObject;
    function PostEndereco(AEndereco: TEndereco): TJSONObject;
    function PutEndereco(AEndereco: TEndereco): TJSONObject;
    function DeleteEndereco(AEndereco: TEndereco): Boolean;
    function BuscarCep(ACep: String): String;
  end;

{$METHODINFO OFF}

implementation

{ TServerMethodsEndereco }

function TServerMethodsEndereco.GetEndereco(IDEndereco: integer): TJSONObject;
var
  AEndereco: TEndereco;
  AEnderecoService: TEnderecoService;
begin
  AEndereco := TEndereco.Create;
  AEnderecoService := TEnderecoService.Create;
  try
    AEnderecoService.Load(IDEndereco, AEndereco);
    Result := TJson.ObjectToJsonObject(AEndereco);
  finally
    FreeAndNil(AEnderecoService);
    FreeAndNil(AEndereco);
  end;
end;

function TServerMethodsEndereco.PostEndereco(AEndereco: TEndereco): TJSONObject;
var
  AEnderecoService: TEnderecoService;
begin
  AEnderecoService := TEnderecoService.Create;
  try
    AEnderecoService.Insert(AEndereco);
    Result := TJson.ObjectToJsonObject(AEndereco);
  finally
    FreeAndNil(AEnderecoService);
  end;
end;

function TServerMethodsEndereco.PutEndereco(AEndereco: TEndereco): TJSONObject;
var
  AEnderecoService: TEnderecoService;
begin
  AEnderecoService := TEnderecoService.Create;
  try
    AEnderecoService.Save(AEndereco);
    Result := TJson.ObjectToJsonObject(AEndereco);
  finally
    FreeAndNil(AEnderecoService);
  end;
end;

function TServerMethodsEndereco.DeleteEndereco(AEndereco: TEndereco): Boolean;
var
  AEnderecoService: TEnderecoService;
begin
  AEnderecoService := TEnderecoService.Create;
  try
    Result := AEnderecoService.Delete(AEndereco);
  finally
    FreeAndNil(AEnderecoService);
  end;
end;

function TServerMethodsEndereco.BuscarCep(ACep: String): String;
var
  URLCep: String;
  RESTRequest: TRESTRequest;
  RESTClient: TRESTClient;
  RESTResponse: TRESTResponse;
begin
  URLCep := Format('https://viacep.com.br/ws/%s/json/', [ACep]);

  RESTClient := TRESTClient.Create(RESTClient);
  RESTRequest := TRESTRequest.Create(RESTRequest);
  RESTResponse := TRESTResponse.Create(RestResponse);

  RESTRequest.Client := RESTClient;
  RESTRequest.Response := RESTResponse;
  RESTClient.BaseURL := URLCep;
  RESTRequest.Execute;
  Result := RESTRequest.Response.JSONText;

  RESTResponse.Free;
  RESTRequest.Free;
  RESTClient.Free;
end;

end.

