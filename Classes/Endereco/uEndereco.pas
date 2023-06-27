unit uEndereco;

interface

type
  TEndereco = class
  private
    Fidendereco: integer;
    Fidpessoa: integer;
    Fdscep: string;
    procedure Setidendereco(const Value: integer);
    procedure Setidpessoa(const Value: integer);
    procedure Setdscep(const Value: string);
  public
    property idendereco: integer read Fidendereco write Setidendereco;
    property idpessoa: integer read Fidpessoa write Setidpessoa;
    property dscep: string read Fdscep write Setdscep;
  end;

implementation

{ TEndereco }

procedure TEndereco.Setidendereco(const Value: integer);
begin
  Fidendereco := Value;
end;

procedure TEndereco.Setidpessoa(const Value: integer);
begin
  Fidpessoa := Value;
end;

procedure TEndereco.Setdscep(const Value: string);
begin
  Fdscep := Value;
end;

end.
