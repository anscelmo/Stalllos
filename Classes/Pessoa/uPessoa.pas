unit uPessoa;

interface

type
  TPessoa = class
  private
    Fnmprimeiro: string;
    Fdtregistro: string;
    Fnmsegundo: string;
    Fdsdocumento: string;
    Fidpessoa: integer;
    Fflnatureza: integer;
    procedure Setdsdocumento(const Value: string);
    procedure Setdtregistro(const Value: string);
    procedure Setflnatureza(const Value: integer);
    procedure Setidpessoa(const Value: integer);
    procedure Setnmprimeiro(const Value: string);
    procedure Setnmsegundo(const Value: string);

  public
    property idpessoa: integer read Fidpessoa write Setidpessoa;
    property flnatureza: integer read Fflnatureza write Setflnatureza;
    property dsdocumento: string read Fdsdocumento write Setdsdocumento;
    property nmprimeiro: string read Fnmprimeiro write Setnmprimeiro;
    property nmsegundo: string read Fnmsegundo write Setnmsegundo;
    property dtregistro: string read Fdtregistro write Setdtregistro;
  end;

implementation

{ TPessoa }

procedure TPessoa.Setdsdocumento(const Value: string);
begin
  Fdsdocumento := Value;
end;

procedure TPessoa.Setdtregistro(const Value: string);
begin
  Fdtregistro := Value;
end;

procedure TPessoa.Setflnatureza(const Value: integer);
begin
  Fflnatureza := Value;
end;

procedure TPessoa.Setidpessoa(const Value: integer);
begin
  Fidpessoa := Value;
end;

procedure TPessoa.Setnmprimeiro(const Value: string);
begin
  Fnmprimeiro := Value;
end;

procedure TPessoa.Setnmsegundo(const Value: string);
begin
  Fnmsegundo := Value;
end;

end.
