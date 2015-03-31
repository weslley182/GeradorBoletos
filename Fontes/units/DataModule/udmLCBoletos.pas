unit udmLCBoletos;

interface

uses
  SysUtils, Classes, DB, DBClient, FR_BarC, FR_DSet, FR_DBSet, FR_Class,
  LCBase, Boletos, Forms, Windows, ExtCtrls;

type
  TdmLCBoletos = class(TDataModule)
    cdsBoletos: TClientDataSet;
    frPadrao: TfrReport;
    frDBBoletos: TfrDBDataSet;
    cdsBoletosNomeBanco: TStringField;
    cdsBoletosNumBanco: TStringField;
    cdsBoletosDigitoNumBanco: TStringField;
    cdsBoletosLinhaDigitavel: TStringField;
    cdsBoletosLocalPagamento: TStringField;
    cdsBoletosNomeCedente: TStringField;
    cdsBoletosCNPJCedente: TStringField;
    cdsBoletosEmissao: TDateField;
    cdsBoletosVencimento: TDateField;
    cdsBoletosNumeroDocumento: TStringField;
    cdsBoletosEspecieDoc: TStringField;
    cdsBoletosAceite: TStringField;
    cdsBoletosAgenciaCodigoCedente: TStringField;
    cdsBoletosNossoNumero: TStringField;
    cdsBoletosValor: TCurrencyField;
    cdsBoletosCarteira: TStringField;
    cdsBoletosMoeda: TStringField;
    cdsBoletosNomeSacado: TStringField;
    cdsBoletosEnderecoSacado: TStringField;
    cdsBoletosCepSacado: TStringField;
    cdsBoletosBairroSacado: TStringField;
    cdsBoletosCidadeSacado: TStringField;
    cdsBoletosUFSacado: TStringField;
    cdsBoletosCNPJCPFSacado: TStringField;
    cdsBoletosInstrucao: TMemoField;
    cdsBoletosCodBarrasImage: TBlobField;
    frReport1: TfrReport;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure PreencheCds (ABoletos: TLCBoletos);
  public
    { Public declarations }
    procedure GeraBoletos (ABoletos: TLCBoletos);
  end;

var
  dmLCBoletos: TdmLCBoletos;

implementation

uses Banco, Pessoa, Titulo, Endereco, uDadosComplementares, uFuncoes;

{$R *.dfm}

procedure TdmLCBoletos.DataModuleCreate(Sender: TObject);
begin
  cdsBoletos.CreateDataSet;
end;

procedure TdmLCBoletos.GeraBoletos(ABoletos: TLCBoletos);
begin
  if ABoletos.ListaTitulos.Count = 0 then
    raise Exception.Create('Selecione um ou mais boletos para impressão!');

  PreencheCds(ABoletos);

  case ABoletos.TipoBoleto of
    tbPadrao:
    begin
      frPadrao.PrepareReport;
      frPadrao.ShowPreparedReport;
    end;
    tbCarne:
    begin
      Application.MessageBox('Modelo Carnê ainda não implementado!', 'Atenção',
        MB_OK + MB_ICONEXCLAMATION);
    end;
  end;
end;

procedure TdmLCBoletos.PreencheCds(ABoletos: TLCBoletos);
var
  i: integer;
  b: TMemoryStream;
  ACodBarras: TImage;
begin
  cdsBoletos.EmptyDataSet;
  with ABoletos.ListaTitulos do
  begin
    for i:= 0 to Count - 1 do
    begin
      cdsBoletos.Append;
      
      cdsBoletosNomeBanco.AsString            := Items[i].Cedente.DadosBanco.NomeBanco;
      cdsBoletosNumBanco.AsString             := Items[i].Cedente.DadosBanco.NumeroBanco;
      cdsBoletosDigitoNumBanco.AsString       := Items[i].Cedente.DadosBanco.DigitoBanco;
      cdsBoletosLinhaDigitavel.AsString       := Items[i].LinhaDigitavel;
      cdsBoletosLocalPagamento.AsString       := Items[i].Cedente.DadosBanco.LocalPagamento;
      cdsBoletosNomeCedente.AsString          := Items[i].Cedente.Nome;
      cdsBoletosCNPJCedente.AsString          := Items[i].Cedente.Cpf_Cnpj;
      cdsBoletosEmissao.AsDateTime            := Items[i].Data;
      cdsBoletosVencimento.AsDateTime         := Items[i].Vencimento;
      cdsBoletosNumeroDocumento.AsString      := Items[i].NumDocumento;
      cdsBoletosEspecieDoc.AsString           := Items[i].DadosComplementares.EspecieAbrev;
      cdsBoletosAceite.AsString               := IfElse(Items[i].DadosComplementares.Aceite=taSim,'S','N');
      cdsBoletosAgenciaCodigoCedente.AsString := Items[i].Cedente.DadosBanco.DadosFormatados.ImpContaAgencia;
      cdsBoletosNossoNumero.AsString          := Items[i].cedente.DadosBanco.DadosFormatados.ImpNossoNumero;
      cdsBoletosValor.AsCurrency              := Items[i].Valor;
      cdsBoletosCarteira.AsString             := Items[i].Cedente.DadosBanco.DadosFormatados.ImpCarteira;
      cdsBoletosMoeda.AsString                := Items[i].DadosComplementares.Moeda;
      cdsBoletosNomeSacado.AsString           := Items[i].Sacado.Nome;
      cdsBoletosEnderecoSacado.AsString       := Items[i].Sacado.Endereco.Logradouro +' '+ items[i].Sacado.Endereco.Numero;
      cdsBoletosCepSacado.AsString            := Items[i].Sacado.Endereco.Cep;
      cdsBoletosBairroSacado.AsString         := Items[i].Sacado.Endereco.Bairro;
      cdsBoletosCidadeSacado.AsString         := Items[i].Sacado.Endereco.Cidade;
      cdsBoletosUFSacado.AsString             := Items[i].Sacado.Endereco.Estado;
      cdsBoletosCNPJCPFSacado.AsString        := Items[i].Sacado.Cpf_Cnpj;
      cdsBoletosInstrucao.AsString            := Items[i].Instrucao.Text;

      // configurando o codigo barras
      b := TMemoryStream.Create;
      ACodBarras := items[i].CodBarrasImagem;
      try
        ACodBarras.Picture.Graphic.SaveToStream(b);
        cdsBoletosCodBarrasImage.LoadFromStream(b);
      finally
        FreeAndNil(b);
        FreeAndNil(ACodBarras);
      end;

      cdsBoletos.Post;
    end;
  end;
end;

end.
