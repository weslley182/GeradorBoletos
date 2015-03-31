unit TituloComplemento;

interface

uses
  Classes, LcaBase;

type
  TDadosComplementares = class (TPersistent)
  private
    FValorJuros: Currency;
    FEspeciaDocumento: TEspecieDocumento;
    FAceite: TTipoAceite;
    FEmissaoBoleto: TTipoEmissao;
    FTipoJuros: TTipoJuros;
    FTipoOcorrencia: TTipoRemessa;
    FTipoDesconto: TTipoDesconto;
    FValorDesconto: Currency;
    FDataDesconto: TDateTime;
    FValorAbatimento: Currency;
    FValorIOF: Currency;
    FDiasProtesto: Integer;
    FProtesto: TTipoProtesto;
    FDiasBaixa: Integer;
    FBaixa: TTipoBaixa;
    FValorMulta: Currency;
    FTipoMulta: TTipoMulta;
    procedure SetAceite(const Value: TTipoAceite);
    procedure SetEmissaoBoleto(const Value: TTipoEmissao);
    procedure SetEspeciaDocumento(const Value: TEspecieDocumento);
    procedure SetTipoJuros(const Value: TTipoJuros);
    procedure SetTipoOcorrencia(const Value: TTipoRemessa);
    procedure SetValorJuros(const Value: Currency);
    procedure SetTipoDesconto(const Value: TTipoDesconto);
    procedure SetValorDesconto(const Value: Currency);
    procedure SetDataDesconto(const Value: TDateTime);
    procedure SetValorAbatimento(const Value: Currency);
    procedure SetValorIOF(const Value: Currency);
    procedure SetDiasProtesto(const Value: Integer);
    procedure SetProtesto(const Value: TTipoProtesto);
    procedure SetBaixa(const Value: TTipoBaixa);
    procedure SetDiasBaixa(const Value: Integer);
    procedure SetTipoMulta(const Value: TTipoMulta);
    procedure SetValorMulta(const Value: Currency);
  public
    constructor Create;
  published
    property TipoOcorrencia: TTipoRemessa read FTipoOcorrencia write SetTipoOcorrencia default trEntradaTitulos;
    property EmissaoBoleto: TTipoEmissao read FEmissaoBoleto write SetEmissaoBoleto default teClienteEmite;
    property EspeciaDocumento: TEspecieDocumento read FEspeciaDocumento write SetEspeciaDocumento default edDuplicataMercantil;
    property Aceite: TTipoAceite read FAceite write SetAceite default taNao;
    property TipoJuros: TTipoJuros read FTipoJuros write SetTipoJuros default tjNaoInformado;
    property ValorJuros: Currency read FValorJuros write SetValorJuros;
    property TipoDesconto: TTipoDesconto read FTipoDesconto write SetTipoDesconto default tdNaoInformado;
    property DataDesconto: TDateTime read FDataDesconto write SetDataDesconto;
    property ValorDesconto: Currency read FValorDesconto write SetValorDesconto;
    property ValorIOF: Currency read FValorIOF write SetValorIOF;
    property ValorAbatimento: Currency read FValorAbatimento write SetValorAbatimento;
    property Protesto: TTipoProtesto read FProtesto write SetProtesto default tpNaoProtestar;
    property DiasProtesto: Integer read FDiasProtesto write SetDiasProtesto default 0;
    property Baixa: TTipoBaixa read FBaixa write SetBaixa default tbNaoBaixar;
    property DiasBaixa: Integer read FDiasBaixa write SetDiasBaixa default 0;
    property TipoMulta: TTipoMulta read FTipoMulta write SetTipoMulta default tmNaoInformado;
    property ValorMulta: Currency read FValorMulta write SetValorMulta;
  end;

implementation

{ TDadosComplementares }

constructor TDadosComplementares.Create;
begin
  inherited;
  FAceite           := taNao;
  FBaixa            := tbNaoBaixar;
  FEmissaoBoleto    := teClienteEmite;
  FEspeciaDocumento := edDuplicataMercantil;
  FProtesto         := tpNaoProtestar;
  FTipoDesconto     := tdNaoInformado;
end;

procedure TDadosComplementares.SetAceite(const Value: TTipoAceite);
begin
  FAceite := Value;
end;

procedure TDadosComplementares.SetBaixa(const Value: TTipoBaixa);
begin
  FBaixa := Value;
end;

procedure TDadosComplementares.SetDataDesconto(const Value: TDateTime);
begin
  FDataDesconto := Value;
end;

procedure TDadosComplementares.SetDiasBaixa(const Value: Integer);
begin
  FDiasBaixa := Value;
end;

procedure TDadosComplementares.SetDiasProtesto(const Value: Integer);
begin
  FDiasProtesto := Value;
end;

procedure TDadosComplementares.SetEmissaoBoleto(const Value: TTipoEmissao);
begin
  FEmissaoBoleto := Value;
end;

procedure TDadosComplementares.SetEspeciaDocumento(
  const Value: TEspecieDocumento);
begin
  FEspeciaDocumento := Value;
end;

procedure TDadosComplementares.SetTipoMulta(const Value: TTipoMulta);
begin
  FTipoMulta := Value;
end;

procedure TDadosComplementares.SetProtesto(const Value: TTipoProtesto);
begin
  FProtesto := Value;
end;

procedure TDadosComplementares.SetTipoDesconto(const Value: TTipoDesconto);
begin
  FTipoDesconto := Value;
end;

procedure TDadosComplementares.SetTipoJuros(const Value: TTipoJuros);
begin
  FTipoJuros := Value;
end;

procedure TDadosComplementares.SetTipoOcorrencia(
  const Value: TTipoRemessa);
begin
  FTipoOcorrencia := Value;
end;

procedure TDadosComplementares.SetValorAbatimento(const Value: Currency);
begin
  FValorAbatimento := Value;
end;

procedure TDadosComplementares.SetValorDesconto(const Value: Currency);
begin
  FValorDesconto := Value;
end;

procedure TDadosComplementares.SetValorIOF(const Value: Currency);
begin
  FValorIOF := Value;
end;

procedure TDadosComplementares.SetValorJuros(const Value: Currency);
begin
  FValorJuros := Value;
end;

procedure TDadosComplementares.SetValorMulta(const Value: Currency);
begin
  FValorMulta := Value;
end;

end.
