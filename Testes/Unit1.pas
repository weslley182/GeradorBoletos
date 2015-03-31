unit Unit1;

interface

uses        
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Titulo, StdCtrls, LCBase, Boletos;

type
  TfrmPrincipal = class(TForm)
    Button1: TButton;
    GroupBox1: TGroupBox;
    edNumBanco: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edAgencia: TEdit;
    edDigitoAgencia: TEdit;
    Label3: TLabel;
    edCarteira: TEdit;
    Label4: TLabel;
    edNumeroConta: TEdit;
    edDigitoConta: TEdit;
    edSeqNossoNumero: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    edConvenio: TEdit;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    edCampoLivre: TEdit;
    Label9: TLabel;
    edCodigoBarras: TEdit;
    Label10: TLabel;
    edLinhaDigitavel: TEdit;
    Label11: TLabel;
    edNomeBanco: TEdit;
    edNossoNumero: TEdit;
    Label12: TLabel;
    edVencimento: TEdit;
    Label13: TLabel;
    edValor: TEdit;
    Label14: TLabel;
    edCodCedente: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Boletos1: TLCBoletos;
    titTeste: TLCTitulo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
    procedure PegaTitulo(AIndex: Integer);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  Cedente;

{$R *.dfm}

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  with titTeste.Cedente.DadosBanco do
  begin
    //pegando dados
    Agencia     := edAgencia.Text;
    Carteira    := edCarteira.Text;
    Conta       := edNumeroConta.Text;
    CodCedente  := edCodCedente.Text;
    Convenio    := edConvenio.Text;
    NumeroBanco := edNumBanco.Text;
    SeqNossoNum := StrToInt(edSeqNossoNumero.text);

    titTeste.Vencimento := StrToDate(edVencimento.Text);
    titTeste.Valor      := StrToCurr(edValor.Text);

    //formatando dados do banco
    titTeste.FormatarDadosBanco;

    //mostrar dados formatados
    edNomeBanco.Text      := NomeBanco;
    edNossoNumero.text    := NossoNumero;
    edCampoLivre.text     := CampoLivre;
//    edCodigoBarras.text   := titTeste.CodigoBarras;
    edLinhaDigitavel.Text := titTeste.LinhaDigitavel;
  end;
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
var
  ATitulo: TLCTitulo;
begin
  ATitulo := TLCTitulo.Create(self);
  ATitulo.Assign(titTeste);
  Boletos1.ListaTitulos.add(ATitulo);
end;

procedure TfrmPrincipal.Button3Click(Sender: TObject);
begin
  Boletos1.ListaTitulos.Clear;
end;

procedure TfrmPrincipal.Button4Click(Sender: TObject);
begin
  if Boletos1.ListaTitulos.Count = 0 then
    raise Exception.Create('Nenhum boleto adicionado!');

  PegaTitulo(0);
end;

procedure TfrmPrincipal.PegaTitulo(AIndex: Integer);
begin
  with Boletos1.ListaTitulos.Items[AIndex] do
  begin
    with Cedente.DadosBanco do
    begin
      edAgencia.Text        := Agencia;
      edCarteira.Text       := Carteira;
      edNumeroConta.Text    := Conta;
      edCodCedente.Text     := CodCedente;
      edConvenio.Text       := Convenio;
      edNumBanco.Text       := NumeroBanco;
      edSeqNossoNumero.Text := IntToStr(SeqNossoNum);
      edNomeBanco.Text      := NomeBanco;
      edNossoNumero.Text    := NossoNumero;
      edCampoLivre.Text     := CampoLivre;
    end;

    edLinhaDigitavel.Text   := LinhaDigitavel;
    edVencimento.text       := DateToStr(Vencimento);
    edValor.Text            := CurrToStr(Valor);
  end;
end;

procedure TfrmPrincipal.Button5Click(Sender: TObject);
begin
  if Boletos1.ListaTitulos.Count = 0 then
    raise Exception.Create('Nenhum boleto adicionado!');

  PegaTitulo(1);
end;

procedure TfrmPrincipal.Button6Click(Sender: TObject);
begin
  boletos1.TipoArquivo := taCnab240;
end;

end.

