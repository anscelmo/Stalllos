 unit uEnderecoIntegracao;

interface

type
  TEnderecoIntegracao = class
  private
    Fidendereco: integer;
  	Fdsuf: string;
	  Fnmcidade: string;
  	Fnmbairro: string;
	  Fnmlogradouro: string;
  	Fdscomplemento: string;
    procedure Setidendereco(const Value: integer);
  	procedure Setdsuf(const Value: string);
  	procedure Setnmcidade(const Value: string);
  	procedure Setnmbairro(const Value: string);
  	procedure Setnmlogradouro(const Value: string);
  	procedure Setdscomplemento(const Value: string);
  public
    property idendereco: integer read Fidendereco write Setidendereco;
  	property dsuf: string read Fdsuf write Setdsuf;
  	property nmcidade: string read Fnmcidade write Setnmcidade;
	  property nmbairro: string read Fnmbairro write Setnmbairro;
  	property nmlogradouro: string read Fnmlogradouro write Setnmlogradouro;
	  property dscomplemento: string read Fdscomplemento write Setdscomplemento;
  end;

implementation

{ TEnderecoIntegracao }

procedure TEnderecoIntegracao.Setidendereco(const Value: integer);
begin
  Fidendereco := Value;
end;

procedure TEnderecoIntegracao.Setdsuf(const Value: string);
begin
  Fdsuf := Value;
end;

procedure TEnderecoIntegracao.Setnmcidade(const Value: string);
begin
  Fnmcidade := Value;
end;

procedure TEnderecoIntegracao.Setnmbairro(const Value: string);
begin
  Fnmbairro := Value;
end;

procedure TEnderecoIntegracao.Setnmlogradouro(const Value: string);
begin
  Fnmlogradouro := Value;
end;

procedure TEnderecoIntegracao.Setdscomplemento(const Value: string);
begin
  Fdscomplemento := Value;
end;

end.
