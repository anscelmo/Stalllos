program Stalllos;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uPrincipalServer in 'uPrincipalServer.pas' {Form1},
  uServerMethodsPessoa in 'uServerMethodsPessoa.pas',
  uServerContainer in 'uServerContainer.pas' {ServerContainer1: TDataModule},
  uWebModule in 'uWebModule.pas' {WebModule1: TWebModule},
  uConexaoFireDac in '..\Classes\ConexaoBD\uConexaoFireDac.pas',
  uPessoa in '..\Classes\Pessoa\uPessoa.pas',
  uPessoaList in '..\Classes\Pessoa\uPessoaList.pas',
  uPessoaService in '..\Classes\Pessoa\uPessoaService.pas',
  uPessoaDAO in '..\Classes\Pessoa\uPessoaDAO.pas',
  uEndereco in '..\Classes\Endereco\uEndereco.pas',
  uEnderecoDAO in '..\Classes\Endereco\uEnderecoDAO.pas',
  uEnderecoList in '..\Classes\Endereco\uEnderecoList.pas',
  uEnderecoService in '..\Classes\Endereco\uEnderecoService.pas',
  uEnderecoIntegracao in '..\Classes\EnderecoIntegracao\uEnderecoIntegracao.pas',
  uEnderecoIntegracaoDAO in '..\Classes\EnderecoIntegracao\uEnderecoIntegracaoDAO.pas',
  uEnderecoIntegracaoList in '..\Classes\EnderecoIntegracao\uEnderecoIntegracaoList.pas',
  uEnderecoIntegracaoService in '..\Classes\EnderecoIntegracao\uEnderecoIntegracaoService.pas',
  uServerMethodsEndereco in 'uServerMethodsEndereco.pas',
  uServerMethodsEnderecoIntegracao in 'uServerMethodsEnderecoIntegracao.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
