unit LukasLib;

interface

uses
  SysUtils, Classes, uFuncoes, uLukasEmp;

type
  TLukasLib = class(TComponent)
  private
    FAEmpresa: TLukasLibEmp;
    procedure SetAEmpresa(const Value: TLukasLibEmp);
    procedure getConection;
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure Verifica;
    constructor Create(AOwner: TComponent); override;
    destructor destroy; override;
  published
    { Published declarations }
    property AEmpresa: TLukasLibEmp read FAEmpresa write SetAEmpresa;
  end;

procedure Register;

implementation

uses
  uMyThread, uConnexao;

procedure Register;
begin
  RegisterComponents('Lukas', [TLukasLib]);
end;

{ TLukasLib }

constructor TLukasLib.Create(AOwner: TComponent);
begin
  inherited;
  FAEmpresa := TLukasLibEmp.Create;
end;

destructor TLukasLib.destroy;
begin
  FreeAndNil(FAEmpresa);
  inherited;
end;

procedure TLukasLib.SetAEmpresa(const Value: TLukasLibEmp);
begin
  FAEmpresa := Value;
end;

procedure TLukasLib.Verifica;
begin
  getConection;
//  if not TConexao.get.Conecta then exit;
end;

procedure TLukasLib.getConection;
var
  tred: TMyThread;
begin
//  Empresa.Situacao := True;
  tred := TMyThread.Create(false,AEmpresa);
end;

end.
