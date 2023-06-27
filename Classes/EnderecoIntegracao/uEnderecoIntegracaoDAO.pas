unit uEnderecoIntegracaoDAO;

interface

uses
  Classes, SysUtils, DB, uEnderecoIntegracao, uEnderecoIntegracaoList, uConexaoFireDac;

type
  TEnderecoIntegracaoDAO = class
  private
    FConexao: TConexaoFireDac;
    ConexaoFireDac: TConexaoFireDac;
  public
    constructor Create;
    destructor Destroy; override;
    function Load(idEnderecoIntegracao: Integer; var AEnderecoIntegracao: TEnderecoIntegracao): Boolean;
    function Save(AEnderecoIntegracao: TEnderecoIntegracao): Boolean;
    function Delete(AEnderecoIntegracao: TEnderecoIntegracao):Boolean;
    function Insert(AEnderecoIntegracao: TEnderecoIntegracao):Boolean;
    function LoadList(var AEnderecoIntegracaoList: TEnderecoIntegracaoList): Boolean;
  end;

implementation

{ TEnderecoIntegracaoDAO }

constructor TEnderecoIntegracaoDAO.Create;
begin
  FConexao := TConexaoFireDac.Create;
  inherited Create;
end;

destructor TEnderecoIntegracaoDAO.Destroy;
begin
  FConexao.Free;
  inherited Destroy;
end;

function TEnderecoIntegracaoDAO.Load(idEnderecoIntegracao: Integer; var AEnderecoIntegracao: TEnderecoIntegracao): Boolean;
var
  comandoSQL: String;
begin
  Result := False;

  comandoSQL := 'select idendereco, dsuf ,nmcidade ,nmbairro ,nmlogradouro ,dscomplemento ' +
                'from endereco_integracao ' +
                'where idendereco = ' + IntToStr(idEnderecoIntegracao);

  ConexaoFireDac := TConexaoFireDac.Create;
  ConexaoFireDac.Conectar;
  ConexaoFireDac.FDQuery.SQL.Clear;
  ConexaoFireDac.FDQuery.SQL.Add(comandoSQL);
  try
    ConexaoFireDac.FDQuery.Open;
    Result := True;
  except
    Result := False;
  end;

  AEnderecoIntegracao.idendereco := ConexaoFireDac.FDQuery.Fields.Fields[0].AsInteger;
  AEnderecoIntegracao.dsuf := ConexaoFireDac.FDQuery.Fields.Fields[1].AsString;
  AEnderecoIntegracao.nmcidade := ConexaoFireDac.FDQuery.Fields.Fields[2].AsString;
  AEnderecoIntegracao.nmbairro := ConexaoFireDac.FDQuery.Fields.Fields[3].AsString;
  AEnderecoIntegracao.nmlogradouro := ConexaoFireDac.FDQuery.Fields.Fields[4].AsString;
  AEnderecoIntegracao.dscomplemento := ConexaoFireDac.FDQuery.Fields.Fields[5].AsString;

  ConexaoFireDac.Desconectar;

  Result := True;
end;

function TEnderecoIntegracaoDAO.Save(AEnderecoIntegracao: TEnderecoIntegracao): Boolean;
var
  comandoSQL: String;
  RegistroExiste: Boolean;
begin
  Result := False;

  comandoSQL := 'select idendereco from endereco_integracao ' +
                'where idendereco = ' + IntToStr(AEnderecoIntegracao.idendereco);

  ConexaoFireDac := TConexaoFireDac.Create;
  ConexaoFireDac.Conectar;
  ConexaoFireDac.FDQuery.SQL.Clear;
  ConexaoFireDac.FDQuery.SQL.Add(comandoSQL);
  ConexaoFireDac.FDQuery.Open;
  RegistroExiste := (ConexaoFireDac.FDQuery.Fields.Fields[0].AsInteger > 0);

  if not RegistroExiste then
  begin
    Result := Insert(AEnderecoIntegracao);
  end
  else
  begin
    comandoSQL := 'update endereco_integracao  ' +
                  'set dsuf = ' + QuotedStr(AEnderecoIntegracao.dsuf) + ', ' +
                  'nmcidade = ' + QuotedStr(AEnderecoIntegracao.nmcidade) + ', ' +
                  'nmbairro = ' + QuotedStr(AEnderecoIntegracao.nmbairro) + ', ' +
                  'nmlogradouro = ' + QuotedStr(AEnderecoIntegracao.nmlogradouro) + ' ' +
                  'dscomplemento = ' + QuotedStr(AEnderecoIntegracao.dscomplemento) + ' ' +
                  'where idendereco = ' + IntToStr(AEnderecoIntegracao.idEndereco);

    ConexaoFireDac.FDQuery.SQL.Clear;
    ConexaoFireDac.FDQuery.SQL.Add(comandoSQL);
    try
      ConexaoFireDac.FDQuery.ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  end;

  ConexaoFireDac.Desconectar;
end;

function TEnderecoIntegracaoDAO.Delete(AEnderecoIntegracao: TEnderecoIntegracao): Boolean;
var
  comandoSQL: String;
begin
  Result := False;

  comandoSQL := 'delete from endereco_integracao ' +
                'where idendereco = ' + IntToStr(AEnderecoIntegracao.idendereco);

  ConexaoFireDac := TConexaoFireDac.Create;
  ConexaoFireDac.Conectar;
  ConexaoFireDac.FDQuery.SQL.Clear;
  ConexaoFireDac.FDQuery.SQL.Add(comandoSQL);
  try
    ConexaoFireDac.FDQuery.ExecSQL;
    Result := True;
  except
    Result := False;
  end;

  ConexaoFireDac.Desconectar;
end;

function TEnderecoIntegracaoDAO.Insert(AEnderecoIntegracao: TEnderecoIntegracao): Boolean;
var
  comandoSQL: String;
begin
  Result := False;

  comandoSQL := 'insert into endereco_integracao(idendereco, dsuf, nmcidade, nmbairro, nmlogradouro, dscomplemento) ' +
                'values (' + QuotedStr(AEnderecoIntegracao.dsuf) + ', ' +
                QuotedStr(AEnderecoIntegracao.nmcidade) + ', ' +
                QuotedStr(AEnderecoIntegracao.nmbairro) + ', ' +
                QuotedStr(AEnderecoIntegracao.nmlogradouro) + ', ' +
                QuotedStr(AEnderecoIntegracao.dscomplemento) + ')';

  ConexaoFireDac := TConexaoFireDac.Create;
  ConexaoFireDac.Conectar;
  ConexaoFireDac.FDQuery.SQL.Clear;
  ConexaoFireDac.FDQuery.SQL.Add(comandoSQL);
  try
    ConexaoFireDac.FDQuery.ExecSQL;
    Result := True;
  except
    Result := False;
  end;

  ConexaoFireDac.Desconectar;
end;

function TEnderecoIntegracaoDAO.LoadList(var AEnderecoIntegracaoList: TEnderecoIntegracaoList): Boolean;
var
  iCont: Integer;
  comandoSQL: String;
begin
  Result := False;

  comandoSQL := 'select idendereco, dsuf ,nmcidade ,nmbairro ,nmlogradouro ,dscomplemento ' +
                'from endereco_integracao ';

  ConexaoFireDac := TConexaoFireDac.Create;
  ConexaoFireDac.Conectar;
  ConexaoFireDac.FDQuery.SQL.Clear;
  ConexaoFireDac.FDQuery.SQL.Add(comandoSQL);
  try
    ConexaoFireDac.FDQuery.Open;
    Result := True;
  except
    Result := False;
  end;

  iCont := 0;
  AEnderecoIntegracaoList.Clear;
  ConexaoFireDac.FDQuery.First;
  while not ConexaoFireDac.FDQuery.Eof do
  begin
    AEnderecoIntegracaoList.Add;
    AEnderecoIntegracaoList.items[0].idendereco := ConexaoFireDac.FDQuery.Fields.Fields[0].AsInteger;
    AEnderecoIntegracaoList.items[0].dsuf := ConexaoFireDac.FDQuery.Fields.Fields[1].AsString;
    AEnderecoIntegracaoList.items[0].nmcidade := ConexaoFireDac.FDQuery.Fields.Fields[2].AsString;
    AEnderecoIntegracaoList.items[0].nmbairro := ConexaoFireDac.FDQuery.Fields.Fields[3].AsString;
    AEnderecoIntegracaoList.items[0].nmlogradouro := ConexaoFireDac.FDQuery.Fields.Fields[4].AsString;
    AEnderecoIntegracaoList.items[0].dscomplemento := ConexaoFireDac.FDQuery.Fields.Fields[5].AsString;

    inc(iCont);
    ConexaoFireDac.FDQuery.Next;
  end;

  ConexaoFireDac.Desconectar;

  Result := True;
end;

end.

