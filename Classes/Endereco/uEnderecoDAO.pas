unit uEnderecoDAO;

interface

uses
  Classes, SysUtils, DB, uEndereco, uEnderecoList, uConexaoFireDac;

type
  TEnderecoDAO = class
  private
    FConexao: TConexaoFireDac;
    ConexaoFireDac: TConexaoFireDac;
  public
    constructor Create;
    destructor Destroy; override;
    function Load(idEndereco: Integer; var AEndereco: TEndereco): Boolean;
    function Save(AEndereco: TEndereco): Boolean;
    function Delete(AEndereco: TEndereco):Boolean;
    function Insert(AEndereco: TEndereco):Boolean;
    function LoadList(var AEnderecoList: TEnderecoList): Boolean;
    function LoadLast(var AEndereco: TEndereco): Boolean;
  end;

implementation

{ TEnderecoDAO }

constructor TEnderecoDAO.Create;
begin
  FConexao := TConexaoFireDac.Create;
  inherited Create;
end;

destructor TEnderecoDAO.Destroy;
begin
  FConexao.Free;
  inherited Destroy;
end;

function TEnderecoDAO.Load(idEndereco: Integer; var AEndereco: TEndereco): Boolean;
var
  comandoSQL: String;
begin
  Result := False;

  comandoSQL := 'select idendereco, idpessoa, dscep ' +
                'from endereco ' +
                'where idendereco = ' + IntToStr(idEndereco);

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

  AEndereco.idendereco := ConexaoFireDac.FDQuery.Fields.Fields[0].AsInteger;
  AEndereco.idpessoa := ConexaoFireDac.FDQuery.Fields.Fields[1].AsInteger;
  AEndereco.dscep := ConexaoFireDac.FDQuery.Fields.Fields[2].AsString;

  ConexaoFireDac.Desconectar;

  Result := True;
end;

function TEnderecoDAO.LoadLast(var AEndereco: TEndereco): Boolean;
var
  comandoSQL: String;
begin
  Result := False;

  comandoSQL := 'select idendereco, idpessoa, dscep ' +
                'from endereco ' +
                'order by idendereco ';

  ConexaoFireDac := TConexaoFireDac.Create;
  ConexaoFireDac.Conectar;
  ConexaoFireDac.FDQuery.SQL.Clear;
  ConexaoFireDac.FDQuery.SQL.Add(comandoSQL);
  try
    ConexaoFireDac.FDQuery.Open;
    ConexaoFireDac.FDQuery.Last;
    Result := True;
  except
    Result := False;
  end;

  AEndereco.idendereco := ConexaoFireDac.FDQuery.Fields.Fields[0].AsInteger;;
  AEndereco.idpessoa := ConexaoFireDac.FDQuery.Fields.Fields[1].AsInteger;;
  AEndereco.dscep := ConexaoFireDac.FDQuery.Fields.Fields[2].AsString;

  ConexaoFireDac.Desconectar;

  Result := True;
end;

function TEnderecoDAO.Save(AEndereco: TEndereco): Boolean;
var
  comandoSQL: String;
  RegistroExiste: Boolean;
begin
  Result := False;

  comandoSQL := 'select idendereco from endereco  ' +
                'where idendereco = ' + IntToStr(AEndereco.idEndereco);

  ConexaoFireDac := TConexaoFireDac.Create;
  ConexaoFireDac.Conectar;
  ConexaoFireDac.FDQuery.SQL.Clear;
  ConexaoFireDac.FDQuery.SQL.Add(comandoSQL);
  ConexaoFireDac.FDQuery.Open;
  RegistroExiste := (ConexaoFireDac.FDQuery.Fields.Fields[0].AsInteger > 0);

  if not RegistroExiste then
  begin
    Result := Insert(AEndereco);
  end
  else
  begin
    comandoSQL := 'update endereco  ' +
                  'set idpessoa = ' + IntToStr(AEndereco.idPessoa) + ', ' +
                  'dscep = ' + QuotedStr(AEndereco.dscep) + ', ' +
                  'where idendereco = ' + IntToStr(AEndereco.idEndereco);

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

function TEnderecoDAO.Delete(AEndereco: TEndereco): Boolean;
var
  comandoSQL: String;
begin
  Result := False;

  comandoSQL := 'delete from endereco ' +
                'where idendereco = ' + IntToStr(AEndereco.idEndereco);

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

function TEnderecoDAO.Insert(AEndereco: TEndereco): Boolean;
var
  comandoSQL: String;
begin
  Result := False;

  comandoSQL := 'insert into pessoa (idendereco, idpessoa, dscep) ' +
                'values (' + IntToStr(AEndereco.idendereco) + ', ' +
                IntToStr(AEndereco.idpessoa) + ', ' +
                QuotedStr(AEndereco.dscep) + ')';

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

function TEnderecoDAO.LoadList(var AEnderecoList: TEnderecoList): Boolean;
var
  iCont: integer;
  comandoSQL: String;
begin
  Result := False;

  comandoSQL := 'select idendereco, idpessoa, dscep ' +
                'from endereco ';

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
  AEnderecoList.Clear;
  ConexaoFireDac.FDQuery.First;
  while not ConexaoFireDac.FDQuery.Eof do
  begin
    AEnderecoList.Add;
    AEnderecoList.Items[iCont].idendereco := ConexaoFireDac.FDQuery.Fields.Fields[0].AsInteger;
    AEnderecoList.Items[iCont].idpessoa := ConexaoFireDac.FDQuery.Fields.Fields[1].AsInteger;
    AEnderecoList.Items[iCont].dscep := ConexaoFireDac.FDQuery.Fields.Fields[2].AsString;

    inc(iCont);
    ConexaoFireDac.FDQuery.Next;
  end;

  ConexaoFireDac.Desconectar;

  Result := True;
end;

end.

