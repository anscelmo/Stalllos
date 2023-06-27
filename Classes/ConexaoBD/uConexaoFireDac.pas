unit uConexaoFireDac;

interface

uses
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.DApt;

type
{$METHODINFO ON}
  TConexaoFireDac = class
  private
    { Private declarations }
    FDConnection1: TFDConnection;
  public
    { Public declarations }
    FDQuery: TFDQuery;
    procedure Conectar;
    procedure Desconectar;
    procedure SetParametros;
  end;

{$METHODINFO OFF}

implementation

{ TConexaoFireDac }

procedure TConexaoFireDac.Conectar;
begin
  FDConnection1 := TFDConnection.Create(FDConnection1);
  SetParametros;
  FDConnection1.Connected := True;

  FDQuery := TFDQuery.Create(FDQuery);
  FDQuery.Connection := FDConnection1;
end;

procedure TConexaoFireDac.Desconectar;
begin
  FDQuery.Free;
  FDConnection1.Connected := False;
  FDConnection1.Free;
end;

procedure TConexaoFireDac.SetParametros;
begin
  FDConnection1.Name := 'FDConnection';
  FDConnection1.DriverName := 'MSSQL';
  FDConnection1.Params.Text := ''
    + #13 + 'SERVER=localhost'
    + #13 + 'OSAuthent=Yes'
    + #13 + 'ApplicationName=Enterprise/Architect/Ultimate'
    + #13 + 'Workstation=LAPTOP-C7ETR0PJ'
    + #13 + 'MARS=yes'
    + #13 + 'ODBCAdvanced=ServerSPN=localhost'
    + #13 + 'DriverID=MSSQL'
    + #13 + 'Database=dbTeste';
  FDConnection1.LoginPrompt := False;
end;

end.
