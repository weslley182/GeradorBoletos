unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Titulo, Boletos, StdCtrls, LCBase;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label22: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label34: TLabel;
    edSeqNossoNumero: TEdit;
    edVencimento: TEdit;
    edValor: TEdit;
    edDocumento: TEdit;
    cbTipoJuros: TComboBox;
    cbTipoMulta: TComboBox;
    edValorJuros: TEdit;
    edValorMulta: TEdit;
    edEmissao: TEdit;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edCampoLivre: TEdit;
    edCodigoBarras: TEdit;
    edLinhaDigitavel: TEdit;
    edNomeBanco: TEdit;
    edNossoNumero: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    GroupBox3: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label14: TLabel;
    Label17: TLabel;
    Label33: TLabel;
    edNomeCedente: TEdit;
    edCnpjCedente: TEdit;
    edNumBanco: TEdit;
    edAgencia: TEdit;
    edDigitoAgencia: TEdit;
    edCarteira: TEdit;
    edNumeroConta: TEdit;
    edDigitoConta: TEdit;
    edConvenio: TEdit;
    edCodigoCedente: TEdit;
    edContrato: TEdit;
    cbTipoRemessa: TComboBox;
    GroupBox4: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    edNomeSacado: TEdit;
    edCnpjSacado: TEdit;
    edEnderecoSacado: TEdit;
    edCidadeSacado: TEdit;
    edUFSacado: TEdit;
    edNumeroSacado: TEdit;
    cbTipoSacado: TComboBox;
    edBairroSacado: TEdit;
    edCepSacado: TEdit;
    edComplementoSacado: TEdit;
    Button6: TButton;
    titTeste: TLCTitulo;
    Button7: TButton;
    Boletos1: TLCBoletos;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    procedure PegaTitulo(AIndex: Integer = 0);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  ExtCtrls;

{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  with titTeste do
  begin
    //dados cedente
    with Cedente do
    begin
      Nome := edNomeCedente.Text;
      Tipo := tpJuridica;
      Cpf_Cnpj := edCnpjCedente.text;
      with DadosBanco do
      begin
        Agencia       := edAgencia.Text;
        DigitoAgencia := edDigitoAgencia.Text;
        Carteira      := edCarteira.Text;
        Conta         := edNumeroConta.Text;
        DigitoConta   := edDigitoConta.text;
        CodCedente    := edCodigoCedente.Text;
        Contrato      := edContrato.Text;
        Convenio      := edConvenio.Text;
        NumeroBanco   := edNumBanco.Text;
        SeqNossoNum   := StrToInt(edSeqNossoNumero.text);
      end;
    end;

    //dados sacado
    with Sacado do
    begin
      Nome := edNomeSacado.Text;
      if cbTipoSacado.ItemIndex = 0 then
        Tipo := tpFisica
      else
        Tipo := tpJuridica;
      Cpf_Cnpj := edCnpjSacado.text;
      with Endereco do
      begin
        Logradouro := edEnderecoSacado.Text;
        Numero := edNumeroSacado.Text;
        Bairro := edBairroSacado.text;
        Complemento := edComplementoSacado.text;
        Cidade := edCidadeSacado.Text;
        Estado := edUFSacado.Text;
        Cep := edCepSacado.text;
      end;
    end;

    //dados do título
    NumDocumento := edDocumento.Text;
    Data         := StrToDate(edEmissao.text);
    Vencimento   := StrToDate(edVencimento.Text);
    Valor        := StrToCurr(edValor.Text);

    //Observações no boleto
    Instrucao.Add('Juros de R$...');
    Instrucao.Add('Multa de R$...');
    Instrucao.Add('Não efetuar depósito...');
    Instrucao.Add('Outras Observações...');

    with DadosComplementares do
    begin
      case cbTipoJuros.ItemIndex of
        0: TipoJuros := tjValorPorDia;
        1: TipoJuros := tjPercentual;
        2: TipoJuros := tjIsento;
      else
        TipoJuros := tjNaoInformado;
      end;
      case cbTipoMulta.ItemIndex of
        0: TipoMulta := tmValorFixo;
        1: TipoMulta := tmPercentual;
      else
        TipoMulta := tmNaoInformado;
      end;
      ValorJuros := StrToCurr(edValorJuros.text);
      ValorMulta := StrToCurr(edValorMulta.text);
    end;

    //formatando dados do banco
    titTeste.FormatarDadosBanco;

    //mostrar dados formatados
    edNomeBanco.Text   := Cedente.DadosBanco.NomeBanco;
    edNossoNumero.text := Cedente.DadosBanco.NossoNumero;
    edCampoLivre.text  := Cedente.DadosBanco.CampoLivre;
    
    //    edCodigoBarras.text   := titTeste.CodigoBarras;
    edLinhaDigitavel.Text := titTeste.LinhaDigitavel;
  end;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
var
  _Titulo: TLCTitulo;
begin
  if titTeste.Cedente.DadosBanco.NomeBanco = '' then
    raise Exception.Create('Gere o Título primeiro!');

  _Titulo := TLCTitulo.Create(Self);
  _Titulo.Assign(titTeste);

  Boletos1.ListaTitulos.Add(_Titulo);
end;

procedure TfrmMain.PegaTitulo(AIndex: Integer);
begin
  with Boletos1.ListaTitulos.Items[AIndex] do
  begin
    with Cedente.DadosBanco do
    begin
      edAgencia.Text := Agencia;
      edCarteira.Text := Carteira;
      edNumeroConta.Text := Conta;
      edCodigoCedente.Text := CodCedente;
      edConvenio.Text := Convenio;
      edNumBanco.Text := NumeroBanco;
      edSeqNossoNumero.text := IntToStr(SeqNossoNum);
      edNomeBanco.Text := NomeBanco;
      edNossoNumero.text := NossoNumero;
      edCampoLivre.text := CampoLivre;
    end;

    edLinhaDigitavel.Text := LinhaDigitavel;
    edVencimento.Text := DateToStr(Vencimento);
    edValor.Text := CurrToStr(Valor);
  end;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  Boletos1.ListaTitulos.Clear;
end;

procedure TfrmMain.Button4Click(Sender: TObject);
begin
  if Boletos1.ListaTitulos.Count = 0 then
    raise Exception.Create('Nenhum Boleto Adicionado!');

  PegaTitulo();
end;

procedure TfrmMain.Button5Click(Sender: TObject);
begin
  if Boletos1.ListaTitulos.Count <= 1 then
    raise Exception.Create('Boleto não existe!');

  PegaTitulo(1);
end;

procedure TfrmMain.Button6Click(Sender: TObject);
begin
  if cbTipoRemessa.ItemIndex = 0 then
    Boletos1.TipoArquivo := taCnab240
  else
    Boletos1.TipoArquivo := taCnab400;

  Boletos1.DirRemessa := ExtractFilePath(ParamStr(0));
  
  if Boletos1.GerarArquivo then
    ShowMessage('Arquivo Gerado com Sucesso!');
end;

procedure TfrmMain.Button7Click(Sender: TObject);
begin
  Boletos1.ImprimirBoletos;  
end;

end.
