unit uPrincipalCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IPPeerClient, REST.Client,
  Data.Bind.ObjectScope, Data.Bind.Components, System.JSON, REST.Types, REST.Json, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, Vcl.Buttons, Vcl.ExtCtrls,
  uPessoa, uPessoaList, uPessoaService,
  uEndereco, uEnderecoList, uEnderecoService,
  uEnderecoIntegracao, uEnderecoIntegracaoList, uEnderecoIntegracaoService;

type
  TForm1 = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    edtID: TLabeledEdit;
    edtNatureza: TLabeledEdit;
    edtDocumento: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtSobrenome: TLabeledEdit;
    edtDataRegistro: TLabeledEdit;
    edtCep: TLabeledEdit;
    btNovo: TBitBtn;
    btGravar: TBitBtn;
    btCancelar: TBitBtn;
    btExcluir: TBitBtn;
    dsDados: TDataSource;
    cdsDados: TClientDataSet;
    DBGrid1: TDBGrid;
    cdsDadosID: TIntegerField;
    cdsDadosDocumento: TStringField;
    cdsDadosNome: TStringField;
    cdsDadosSobrenome: TStringField;
    cdsDadosDataRegistro: TStringField;
    cdsDadosCep: TStringField;
    cdsDadosNatureza: TIntegerField;
    btAtualizaEndereco: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btAtualizaEnderecoClick(Sender: TObject);
    procedure cdsDadosAfterScroll(DataSet: TDataSet);
  private
    procedure CarregarRestPessoa;
    procedure LimpaTela;
    procedure CarregaDados;
    procedure CarregaCampos;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.CarregarRestPessoa;
begin
  RestClient1.ResetToDefaults;
  RestRequest1.ResetToDefaults;
  RestResponse1.ResetToDefaults;
  RestClient1.BaseURL := 'http://localhost:8080/datasnap/rest/TServerMethodsPessoa';
end;

procedure TForm1.cdsDadosAfterScroll(DataSet: TDataSet);
begin
  CarregaCampos;
end;

procedure TForm1.LimpaTela;
begin
  edtID.Clear;
  edtNatureza.Clear;
  edtDocumento.Clear;
  edtNome.Clear;
  edtSobrenome.Clear;
  edtDataRegistro.Clear;
  edtCep.Clear;
end;

procedure TForm1.CarregaCampos;
begin
  edtID.Text := cdsDadosID.AsString;
  edtNatureza.Text := cdsDadosNatureza.AsString;
  edtDocumento.Text := cdsDadosDocumento.AsString;
  edtNome.Text := cdsDadosNome.AsString;
  edtSobrenome.Text := cdsDadosSobrenome.AsString;
  edtDataRegistro.Text := cdsDadosDataRegistro.AsString;
  edtCep.Text := cdsDadosCep.AsString;
end;

procedure TForm1.CarregaDados;
var
  i, Id: Integer;
  APessoaList: TPessoaList;
  APessoaService: TPessoaService;
  AEndereco: TEndereco;
  AEnderecoList: TEnderecoList;
  AEnderecoService: TEnderecoService;
begin
  cdsDados.EmptyDataSet;

  APessoaList := TPessoaList.Create;
  APessoaService := TPessoaService.Create;

  AEndereco := TEndereco.Create;
  AEnderecoList := TEnderecoList.Create;
  AEnderecoService := TEnderecoService.Create;

  APessoaService.LoadList(APessoaList);
  AEnderecoService.LoadList(AEnderecoList);

  for i := 0 to APessoaList.Count - 1 do
  begin
    Id := APessoaList.Items[i].idpessoa;

    cdsDados.Append;
    cdsDadosID.AsInteger := APessoaList.Items[i].idpessoa;
    cdsDadosNatureza.AsInteger := APessoaList.Items[i].flnatureza;
    cdsDadosDocumento.AsString := APessoaList.Items[i].dsdocumento;
    cdsDadosNome.AsString := APessoaList.Items[i].nmprimeiro;
    cdsDadosSobrenome.AsString := APessoaList.Items[i].nmsegundo;
    //cdsDadosDataRegistro.AsString := FormatDateTime('dd/mm/yyyy', StrToDateTime(APessoaList.Items[0].dtregistro));

    AEndereco := AEnderecoList.Find(Id);
    if Assigned(AEndereco) then
      cdsDadosCep.AsString := AEndereco.dscep;
    cdsDados.Post;
  end;

  FreeAndNil(APessoaService);
//  FreeAndNil(APessoaList);

  FreeAndNil(AEnderecoService);
//  FreeAndNil(AEnderecoList);
  FreeAndNil(AEndereco);

  cdsDados.First;
  CarregaCampos;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if not cdsDados.Active then
    cdsDados.CreateDataSet;
  cdsDados.EmptyDataSet;
  cdsDados.LogChanges := False;
  cdsDados.IndexFieldNames := 'ID';

  CarregaDados;
end;

procedure TForm1.btAtualizaEnderecoClick(Sender: TObject);
var
  i, Id: Integer;
  EnderecoExiste: Boolean;
  JSonValue: TJSonValue;
  DadosCep: String;
  AEnderecoList: TEnderecoList;
  AEnderecoService: TEnderecoService;
  AEnderecoIntegracao: TEnderecoIntegracao;
  AEnderecoIntegracaoList: TEnderecoIntegracaoList;
  AEnderecoIntegracaoService: TEnderecoIntegracaoService;
begin
  AEnderecoList := TEnderecoList.Create;
  AEnderecoService := TEnderecoService.Create;

  AEnderecoIntegracao := TEnderecoIntegracao.Create;
  AEnderecoIntegracaoList := TEnderecoIntegracaoList.Create;
  AEnderecoIntegracaoService := TEnderecoIntegracaoService.Create;

  AEnderecoIntegracaoService.LoadList(AEnderecoIntegracaoList);
  AEnderecoService.LoadList(AEnderecoList);
  for i := 0 to AEnderecoList.Count - 1 do
  begin
    // realizar a chamada do ServerMethodsEndereco.BuscarCep
    // DadosCep := ServerMethodsEndereco.BuscarCep(AEnderecoList.Items[i].dscep);

    Id := AEnderecoList.Items[0].idendereco;
    AEnderecoIntegracao := AEnderecoIntegracaoList.Find(Id);
    EnderecoExiste := (AEnderecoIntegracao.idendereco > 0);

    JsonValue := TJSonObject.ParseJSONValue(DadosCep);
    AEnderecoIntegracao.dsuf := JsonValue.GetValue<string>('data.results[0].uf');
    AEnderecoIntegracao.nmcidade := JsonValue.GetValue<string>('data.results[0].localidade');
    AEnderecoIntegracao.nmbairro := JsonValue.GetValue<string>('data.results[0].bairro');
    AEnderecoIntegracao.nmlogradouro := JsonValue.GetValue<string>('data.results[0].logradouro');
    AEnderecoIntegracao.dscomplemento := JsonValue.GetValue<string>('data.results[0].complemento');

    if EnderecoExiste then
    begin
      // novo registro
      // realizar chamada do ServerMethodsEnderecoIntegracao->PutEnderecoIntegracao(AEnderecoIntegracao)

    end
    else
    begin
      // editar registro
      // realizar chamada do ServerMethodsEnderecoIntegracao->PostEnderecoIntegracao(AEnderecoIntegracao)

    end;

  end;

  FreeAndNil(AEnderecoService);
//  FreeAndNil(AEnderecoList);

  FreeAndNil(AEnderecoIntegracaoService);
//  FreeAndNil(AEnderecoIntegracaoList);
  FreeAndNil(AEnderecoIntegracao);
end;

procedure TForm1.btCancelarClick(Sender: TObject);
begin
  cdsDados.Cancel;
  LimpaTela;
end;

procedure TForm1.btExcluirClick(Sender: TObject);
var
  Id: integer;
begin
  if cdsDados.IsEmpty then
    Exit;

  if Application.MessageBox(pchar('Confirma exclusão do registro?'), pchar('Confirmação'), MB_ICONQUESTION + MB_YESNOCANCEL) = idYes then
  begin
    Id := StrToInt(edtID.Text);

    // realizar chamada do ServerMethodsPessoa->DeletePessoa(Id)

    cdsDados.Delete;
    LimpaTela;
    ShowMessage('Registro Excluído');
  end;
end;

procedure TForm1.btGravarClick(Sender: TObject);
var
  Id: Integer;
  APessoa: TPessoa;
  APessoaService: TPessoaService;
  AEndereco: TEndereco;
  AEnderecoService: TEnderecoService;
begin

  APessoa := TPessoa.Create;
  APessoaService := TPessoaService.Create;

  AEndereco := TEndereco.Create;
  AEnderecoService := TEnderecoService.Create;

  Id := StrToIntDef(edtID.Text,0);
  if Id = 0 then
  begin
    // inclusão
    // realizar chamada do ServerMethodsPessoa->PutPessoa

    APessoaService.LoadLast(APessoa);
    AEnderecoService.LoadLast(AEndereco);
    Id := APessoa.idpessoa;

    cdsDados.Append;
  end
  else
  begin
    // alteração
    // realizar chamada do ServerMethodsPessoa->PostPessoa(Id)

    APessoaService.Load(Id, APessoa);
    AEnderecoService.Load(Id, AEndereco);

    cdsDados.FindKey([Id]);
    cdsDados.Edit;
  end;

  cdsDadosID.AsInteger := APessoa.idpessoa;
  cdsDadosNatureza.AsInteger := APessoa.flnatureza;
  cdsDadosDocumento.AsString := APessoa.dsdocumento;
  cdsDadosNome.AsString := APessoa.nmprimeiro;
  cdsDadosSobrenome.AsString := APessoa.nmsegundo;
  cdsDadosDataRegistro.AsString := APessoa.dtregistro;
  cdsDadosCep.AsString := AEndereco.dscep;
  cdsDados.Post;

  FreeAndNil(APessoaService);
  FreeAndNil(APessoa);

  FreeAndNil(AEnderecoService);
  FreeAndNil(AEndereco);

  CarregaCampos;
end;

procedure TForm1.btNovoClick(Sender: TObject);
begin
  LimpaTela;
  cdsDados.Append;
  edtNatureza.SetFocus;
end;

end.
