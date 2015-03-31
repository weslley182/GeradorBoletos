unit CaixaCnab400;

interface

uses Cnab400;

type
  TCaixaCnab400 = class(TCnab400)
  protected
    procedure HeaderArquivo; override;
    procedure Registros; override;
  public
  end;

implementation

{ TCaixaCnab400 }

procedure TCaixaCnab400.Registros;
begin
  inherited;

end;

procedure TCaixaCnab400.RegistroHeader;
begin
  FCodigoEmpresa := Titulos.Items[0].

  inherited;

end;

end.
