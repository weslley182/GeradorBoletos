unit uDadosComplementares;

interface

uses
  Classes, LCBase;

type
  TDadosComplementares = class(TPersistent)
  private
    FValorAbatimento: Currency;
    FValorDesconto: Currency;
    FValorIOF: Currency;
    FValorMulta: Currency;
    FValorJuros: Currency;
    FDiasBaixa: Integer;
    FDiasProtesto: Integer;
    FDataDesconto: TDateTime;
    FEspecieDocumento: TEspecieDocumento;
    FAceite: TTipoAceite;
    FBaixa: TTipoBaixa;
    FTipoDesconto: TTipoDesconto;
    FEmissaoBoleto: TTipoEmissao;
    FTipoJuros: TTipoJuros;
    FTipoMulta: TTipoMulta;
    FProtesto: TTipoProtesto;
    FTipoOcorrencia: TTipoRemessa;
    FMoeda: string;
    procedure SetAceite(const Value: TTipoAceite);
    procedure SetBaixa(const Value: TTipoBaixa);
    procedure SetDataDesconto(const Value: TDateTime);
    procedure SetDiasBaixa(const Value: Integer);
    procedure SetDiasProtesto(const Value: Integer);
    procedure SetEmissaoBoleto(const Value: TTipoEmissao);
    procedure SetEspecieDocumento(const Value: TEspecieDocumento);
    procedure SetProtesto(const Value: TTipoProtesto);
    procedure SetTipoDesconto(const Value: TTipoDesconto);
    procedure SetTipoJuros(const Value: TTipoJuros);
    procedure SetTipoMulta(const Value: TTipoMulta);
    procedure SetTipoOcorrencia(const Value: TTipoRemessa);
    procedure SetValorAbatimento(const Value: Currency);
    procedure SetValorDesconto(const Value: Currency);
    procedure SetValorIOF(const Value: Currency);
    procedure SetValorJuros(const Value: Currency);
    procedure SetValorMulta(const Value: Currency);
    function getEspecieAbrev: string;
    procedure SetMoeda(const Value: string);
  public
    constructor Create;
  published
    property TipoOcorrencia: TTipoRemessa read FTipoOcorrencia write SetTipoOcorrencia default trEntradaTitulos;
    property EmissaoBoleto: TTipoEmissao read FEmissaoBoleto write SetEmissaoBoleto default teClienteEmite;
    property EspecieDocumento: TEspecieDocumento read FEspecieDocumento write SetEspecieDocumento default edDuplicataMercantil;
    property EspecieAbrev: string read getEspecieAbrev;
    property Moeda: string read FMoeda write SetMoeda;
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
  FEmissaoBoleto    := teClienteEmite;
  FEspecieDocumento := edDuplicataMercantil;
  FAceite           := taNao;
  FTipoJuros        := tjNaoInformado;
  FTipoDesconto     := tdNaoInformado;
  FProtesto         := tpNaoProtestar;
  FBaixa            := tbNaoBaixar;
  FTipoMulta        := tmNaoInformado;
end;

function TDadosComplementares.getEspecieAbrev: string;
begin
  case FEspecieDocumento of
    edCheque                          : Result := 'CHQ';
    edDuplicataMercantil              : Result := 'DM';
    edDuplicataMercantilPorIndicacao  : Result := 'DMI';
    edDuplicataDeServico              : Result := 'DS';
    edDuplicataDeServicoPorIndicacao  : Result := 'DSI';
    edDuplicataRural                  : Result := 'DR';
    edLetraDeCambio                   : Result := 'LC';
    edNotaDeCreditoComercial          : Result := 'NC';
    edNotaDeCreditoAExportacao        : Result := 'NC';
    edNotaDeCreditoIndustrial         : Result := 'NC';
    edNotaDeCreditoRural              : Result := 'NC';
    edNotaPromissoria                 : Result := 'NP';
    edNotaPromissoriaRural            : Result := 'NPR';
    edTriplicataMercantil             : Result := 'TM';
    edTriplicataDeServico             : Result := 'TS';
    edNotaDeSeguro                    : Result := 'NS';
    edRecibo                          : Result := 'RC';
    edFatura                          : Result := 'FT';
    edNotaDeDebito                    : Result := 'ND';
    edApoliceDeSeguro                 : Result := 'AS';
    edMensalidadeEscolar              : Result := 'ME';
    edParcelaDeConsorcio              : Result := 'PC';
    edCobrancaSeriada                 : Result := 'CS';
  else
    Result := 'DM';
  end;
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

procedure TDadosComplementares.SetEspecieDocumento(
  const Value: TEspecieDocumento);
begin
  FEspecieDocumento := Value;
end;

procedure TDadosComplementares.SetMoeda(const Value: string);
begin
  FMoeda := Value;
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

procedure TDadosComplementares.SetTipoMulta(const Value: TTipoMulta);
begin
  FTipoMulta := Value;
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
