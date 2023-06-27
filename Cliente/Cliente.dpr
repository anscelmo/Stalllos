program Cliente;

uses
  Vcl.Forms,
  uPrincipalCliente in 'uPrincipalCliente.pas' {Form1},
  uConexaoFireDac in '..\Classes\ConexaoBD\uConexaoFireDac.pas',
  uPessoa in '..\Classes\Pessoa\uPessoa.pas',
  uPessoaList in '..\Classes\Pessoa\uPessoaList.pas',
  uPessoaService in '..\Classes\Pessoa\uPessoaService.pas',
  uPessoaDAO in '..\Classes\Pessoa\uPessoaDAO.pas',
  uEndereco in '..\Classes\Endereco\uEndereco.pas',
  uEnderecoList in '..\Classes\Endereco\uEnderecoList.pas',
  uEnderecoService in '..\Classes\Endereco\uEnderecoService.pas',
  uEnderecoDAO in '..\Classes\Endereco\uEnderecoDAO.pas',
  uEnderecoIntegracao in '..\Classes\EnderecoIntegracao\uEnderecoIntegracao.pas',
  uEnderecoIntegracaoList in '..\Classes\EnderecoIntegracao\uEnderecoIntegracaoList.pas',
  uEnderecoIntegracaoService in '..\Classes\EnderecoIntegracao\uEnderecoIntegracaoService.pas',
  uEnderecoIntegracaoDAO in '..\Classes\EnderecoIntegracao\uEnderecoIntegracaoDAO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
