unit uPessoaDAO;

interface

uses
  Classes, SysUtils, DB, uPessoa, uPessoaList, uConexaoFireDac;

type
  TPessoaDAO = class
  private
    FConexao: TConexaoFireDac;
    ConexaoFireDac: TConexaoFireDac;
  public
    constructor Create;
    destructor Destroy; override;
    function Load(idPessoa: Integer; var APessoa: TPessoa): Boolean;
    function Save(APessoa: TPessoa): Boolean;
    function Delete(APessoa: TPessoa):Boolean;
    function Insert(APessoa: TPessoa):Boolean;
    function LoadList(var APessoaList: TPessoaList): Boolean;
    function LoadLast(var APessoa: TPessoa): Boolean;
  end;

implementation

{ TPessoaDAO }

constructor TPessoaDAO.Create;
begin
  FConexao := TConexaoFireDac.Create;
  inherited Create;
end;

destructor TPessoaDAO.Destroy;
begin
  FConexao.Free;
  inherited Destroy;
end;

function TPessoaDAO.Load(idPessoa: Integer; var APessoa: TPessoa): Boolean;
var
  comandoSQL: String;
begin
  Result := False;

  comandoSQL := 'select idpessoa, flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtregistro ' +
                'from pessoa ' +
                'where idpessoa = ' + IntToStr(idPessoa);

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

  APessoa.idpessoa := ConexaoFireDac.FDQuery.Fields.Fields[0].AsInteger;
  APessoa.flnatureza := ConexaoFireDac.FDQuery.Fields.Fields[1].AsInteger;
  APessoa.dsdocumento := ConexaoFireDac.FDQuery.Fields.Fields[2].AsString;
  APessoa.nmprimeiro := ConexaoFireDac.FDQuery.Fields.Fields[3].AsString;
  APessoa.nmsegundo := ConexaoFireDac.FDQuery.Fields.Fields[4].AsString;
  APessoa.dtregistro := ConexaoFireDac.FDQuery.Fields.Fields[5].AsString;

  ConexaoFireDac.Desconectar;

  Result := True;
end;

function TPessoaDAO.LoadLast(var APessoa: TPessoa): Boolean;
var
  comandoSQL: String;
begin
  Result := False;

  comandoSQL := 'select idpessoa, flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtregistro ' +
                'from pessoa ' +
                'order by idpessoa ';

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

  APessoa.idpessoa := ConexaoFireDac.FDQuery.Fields.Fields[0].AsInteger;
  APessoa.flnatureza := ConexaoFireDac.FDQuery.Fields.Fields[1].AsInteger;
  APessoa.dsdocumento := ConexaoFireDac.FDQuery.Fields.Fields[2].AsString;
  APessoa.nmprimeiro := ConexaoFireDac.FDQuery.Fields.Fields[3].AsString;
  APessoa.nmsegundo := ConexaoFireDac.FDQuery.Fields.Fields[4].AsString;
  APessoa.dtregistro := ConexaoFireDac.FDQuery.Fields.Fields[5].AsString;

  ConexaoFireDac.Desconectar;

  Result := True;
end;

function TPessoaDAO.Save(APessoa: TPessoa): Boolean;
var
  comandoSQL: String;
  RegistroExiste: Boolean;
begin
  Result := False;

  comandoSQL := 'select idPessoa from pessoa  ' +
                'where idPessoa = ' + IntToStr(APessoa.idpessoa);

  ConexaoFireDac := TConexaoFireDac.Create;
  ConexaoFireDac.Conectar;
  ConexaoFireDac.FDQuery.SQL.Clear;
  ConexaoFireDac.FDQuery.SQL.Add(comandoSQL);
  ConexaoFireDac.FDQuery.Open;
  RegistroExiste := (ConexaoFireDac.FDQuery.Fields.Fields[0].AsInteger > 0);

  if not RegistroExiste then
  begin
    Result := Insert(APessoa);
  end
  else
  begin
    comandoSQL := 'update pessoa  ' +
                  'set flnatureza = ' + IntToStr(APessoa.flnatureza) + ', ' +
                  'dsdocumento = ' + QuotedStr(APessoa.dsdocumento) + ', ' +
                  'nmprimeiro = ' + QuotedStr(APessoa.nmprimeiro) + ', ' +
                  'nmsegundo = ' + QuotedStr(APessoa.nmsegundo) + ', ' +
                  'dtregistro = ' + QuotedStr(APessoa.dtregistro) + ' ' +
                  'where idPessoa = ' + IntToStr(APessoa.idpessoa);

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

function TPessoaDAO.Delete(APessoa: TPessoa): Boolean;
var
  comandoSQL: String;
begin
  Result := False;

  comandoSQL := 'delete from pessoa  ' +
                'where idPessoa = ' + IntToStr(APessoa.idpessoa);

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

function TPessoaDAO.Insert(APessoa: TPessoa): Boolean;
var
  comandoSQL: String;
begin
  Result := False;

  comandoSQL := 'insert into pessoa (flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtregistro) ' +
                'values (' + IntToStr(APessoa.flnatureza) + ', ' +
                QuotedStr(APessoa.dsdocumento) + ', ' + QuotedStr(APessoa.nmprimeiro) + ', ' +
                QuotedStr(APessoa.nmsegundo) + ', ' + QuotedStr(APessoa.dtregistro) + ')';

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

function TPessoaDAO.LoadList(var APessoaList: TPessoaList): Boolean;
var
  iCont: Integer;
  comandoSQL: String;
begin
  Result := False;

  comandoSQL := 'select idpessoa, flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtregistro ' +
                'from pessoa ';

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
  APessoaList.Clear;
  ConexaoFireDac.FDQuery.First;
  while not ConexaoFireDac.FDQuery.Eof do
  begin
    APessoaList.Add;
    APessoaList.Items[iCont].idpessoa := ConexaoFireDac.FDQuery.Fields.Fields[0].AsInteger;
    APessoaList.Items[iCont].flnatureza := ConexaoFireDac.FDQuery.Fields.Fields[1].AsInteger;
    APessoaList.Items[iCont].dsdocumento := ConexaoFireDac.FDQuery.Fields.Fields[2].AsString;
    APessoaList.Items[iCont].nmprimeiro := ConexaoFireDac.FDQuery.Fields.Fields[3].AsString;
    APessoaList.Items[iCont].nmsegundo := ConexaoFireDac.FDQuery.Fields.Fields[4].AsString;
    //APessoaList.Items[iCont].dtregistro := ConexaoFireDac.FDQuery.Fields.Fields[5].AsString;

    inc(iCont);
    ConexaoFireDac.FDQuery.Next;
  end;

  ConexaoFireDac.Desconectar;

  Result := True;
end;

end.

