unit uprinc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Contnrs;

type
  TPessoa = class(TPersistent)
  private
    Fnome: string;
    procedure Setnome(const Value: string);
  public
    property nome: string read Fnome write Setnome;
  end;

  TSocios = class(TObjectList)
  private
    function GetItem(Index: Integer): TPessoa;
    procedure SetItem(Index: Integer; const Value: TPessoa);
  public
    function Add(APessoa: TPessoa): integer;
    property Items[Index: Integer]: TPessoa read GetItem write SetItem; default;
  end;

  TCoopera = class(TPersistent)
  private
    Fgerente: string;
    FSocios: TSocios;
    procedure Setgerente(const Value: string);
    procedure Setsocios(const Value: TSocios);
  public
    constructor create;
    destructor destroy; override;
    property gerente: string read Fgerente write Setgerente;
    property socios: TSocios read Fsocios write Setsocios;
  end;

  TForm1 = class(TForm)
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ACoopera: TCoopera;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
var
  APessoa: TPessoa;
begin
  APessoa := TPessoa.Create;
  APessoa.nome := 'joao ' + IntToStr(ACoopera.socios.count);

  ACoopera.socios.Add(APessoa);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ACoopera := TCoopera.Create;
  ACoopera.gerente := 'pedro';
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if Assigned(ACoopera) then
    FreeAndNil(ACoopera);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ACoopera);
end;

{ Tpessoa }

procedure Tpessoa.Setnome(const Value: string);
begin
  Fnome := Value;
end;

{ TCoopera }

constructor TCoopera.create;
begin
  inherited create;
  FSocios := TSocios.create(True);
end;

destructor TCoopera.destroy;
begin
  FreeAndNil(Fsocios);
  inherited;
end;

procedure TCoopera.Setgerente(const Value: string);
begin
  Fgerente := Value;
end;

procedure TCoopera.Setsocios(const Value: TSocios);
begin
  Fsocios := Value;
end;

{ TSocios }

function TSocios.Add(APessoa: TPessoa): integer;
begin
  Result := inherited Add(APessoa);
end;

function TSocios.GetItem(Index: Integer): TPessoa;
begin
  Result := TPessoa(inherited Items[Index]);
end;

procedure TSocios.SetItem(Index: Integer; const Value: TPessoa);
begin
  inherited Items[Index] := Value;
end;


end.

