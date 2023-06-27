unit uServerMethodsPessoa;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, System.Json, REST.Json, uPessoa, uPessoaService;

type
{$METHODINFO ON}
  TServerMethodsPessoa = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    function GetPessoa(IDpessoa: integer): TJSONObject;
    function PostPessoa(Apessoa: Tpessoa): TJSONObject;
    function PutPessoa(Apessoa: Tpessoa): TJSONObject;
    function DeletePessoa(Apessoa: Tpessoa): Boolean;
  end;

{$METHODINFO OFF}

implementation

{ TServerMethodsPessoa }

function TServerMethodsPessoa.GetPessoa(IDpessoa: integer): TJSONObject;
var
  APessoa: TPessoa;
  APessoaService: TPessoaService;
begin
  APessoa := TPessoa.Create;
  APessoaService := TPessoaService.Create;
  try
    APessoaService.Load(IDpessoa, APessoa);
    Result := TJson.ObjectToJsonObject(APessoa);
  finally
    FreeAndNil(APessoaService);
    FreeAndNil(APessoa);
  end;
end;

function TServerMethodsPessoa.PostPessoa(Apessoa: Tpessoa): TJSONObject;
var
  APessoaService: TPessoaService;
begin
  APessoaService := TPessoaService.Create;
  try
    APessoaService.Insert(APessoa);
    Result := TJson.ObjectToJsonObject(APessoa);
  finally
    FreeAndNil(APessoaService);
  end;
end;

function TServerMethodsPessoa.PutPessoa(Apessoa: Tpessoa): TJSONObject;
var
  APessoaService: TPessoaService;
begin
  APessoaService := TPessoaService.Create;
  try
    APessoaService.Save(APessoa);
    Result := TJson.ObjectToJsonObject(APessoa);
  finally
    FreeAndNil(APessoaService);
  end;
end;

function TServerMethodsPessoa.DeletePessoa(Apessoa: Tpessoa): Boolean;
var
  APessoaService: TPessoaService;
begin
  APessoaService := TPessoaService.Create;
  try
    Result := APessoaService.Delete(APessoa);
  finally
    FreeAndNil(APessoaService);
  end;
end;

end.

