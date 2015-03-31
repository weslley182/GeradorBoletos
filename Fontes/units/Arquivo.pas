unit Arquivo;

interface

uses LCBase, ListaTitulos, Classes, SysUtils;

type
  TArquivo = class
  private
    FNumeroLote: Integer;
    FNumArquivo: integer;
    FNomeCompletoArquivo: string;
    FTitulos: TListaTitulos;
    FRemessa: TTipoRemessa;
    FDirRemessa: string;
    procedure SetNomeCompletoArquivo(const Value: string);
    procedure SetNumArquivo(const Value: integer);
    procedure SetNumeroLote(const Value: Integer);
    procedure SetRemessa(const Value: TTipoRemessa);
    procedure SetTitulos(const Value: TListaTitulos);
    procedure SetDirRemessa(const Value: string);
  protected
    FArquivoTexto: TStringList;
    FLinha: string;
    function GetOcorrencia: string; virtual;
    function GetEmissao(ATipo: TTipoEmissao): string; virtual;
    function GetEspecieDoc(ATipo: TEspecieDocumento): string; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    function GerarRemessa: Boolean; virtual; abstract;

    property Titulos: TListaTitulos read FTitulos write SetTitulos;
    property DirRemessa: string read FDirRemessa write SetDirRemessa;
    property NomeCompletoArquivo: string read FNomeCompletoArquivo write SetNomeCompletoArquivo;
    property NumArquivo: integer read FNumArquivo write SetNumArquivo;
    property Remessa: TTipoRemessa read FRemessa write SetRemessa;
    property NumeroLote: Integer read FNumeroLote write SetNumeroLote;
  end;

implementation

uses TypInfo;

{ TArquivo }

constructor TArquivo.Create;
begin
  inherited;
  FArquivoTexto := TStringList.Create;
  FNumeroLote := 1;
end;

destructor TArquivo.Destroy;
begin
  FreeAndNil(FArquivoTexto);
  inherited;
end;

procedure TArquivo.SetNomeCompletoArquivo(const Value: string);
begin
  FNomeCompletoArquivo := Value;
end;

procedure TArquivo.SetNumArquivo(const Value: integer);
begin
  FNumArquivo := Value;
end;

procedure TArquivo.SetNumeroLote(const Value: Integer);
begin
  FNumeroLote := Value;
end;

procedure TArquivo.SetRemessa(const Value: TTipoRemessa);
begin
  FRemessa := Value;
end;

procedure TArquivo.SetTitulos(const Value: TListaTitulos);
begin
  FTitulos := Value;
end;

function TArquivo.GetOcorrencia: string;
begin
  case Remessa of //16 a 17 - Código de movimento
    trEntradaTitulos: Result := '01';
    trPedidoBaixa: Result := '02';
    trConcessaoAbatimento: Result := '04';
    trCancelamentoAbatimento: Result := '05';
    trAlteracaoVencimento: Result := '06';
    trConcessaoDesconto: Result := '07';
    trCancelamentoDesconto: Result := '08';
    trProtestar: Result := '09';
    trCancelaSustacaoInstrucaoProtesto: Result := '10';
    trRecusaAlegacaoSacado: Result := '30';
    trAlteracaoOutrosDados: Result := '31';
  else
    Result := '01';
  end;
end;

function TArquivo.GetEmissao(ATipo: TTipoEmissao): string;
begin
  case ATipo of
    teBancoEmite: Result := '11';
    teClienteEmite: Result := '22';
    teBancoReemite: Result := '41';
    teBancoNaoReemite: Result := '52';
  else
    Result := '22';
  end;
end;

function TArquivo.GetEspecieDoc(ATipo: TEspecieDocumento): string;
begin
  case ATipo of
    edCheque: Result := '01';
    edDuplicataMercantil: Result := '02';
    edDuplicataMercantilPorIndicacao: Result := '03';
    edDuplicataDeServico: Result := '04';
    edDuplicataDeServicoPorIndicacao: Result := '05';
    edDuplicataRural: Result := '06';
    edLetraDeCambio: Result := '07';
    edNotaDeCreditoComercial: Result := '08';
    edNotaDeCreditoAExportacao: Result := '09';
    edNotaDeCreditoIndustrial: Result := '10';
    edNotaDeCreditoRural: Result := '11';
    edNotaPromissoria: Result := '12';
    edNotaPromissoriaRural: Result := '13';
    edTriplicataMercantil: Result := '14';
    edTriplicataDeServico: Result := '15';
    edNotaDeSeguro: Result := '16';
    edRecibo: Result := '17';
    edFatura: Result := '18';
    edNotaDeDebito: Result := '19';
    edApoliceDeSeguro: Result := '20';
    edMensalidadeEscolar: Result := '21';
    edParcelaDeConsorcio: Result := '22';
  else
    Result := '99';
  end;
end;

procedure TArquivo.SetDirRemessa(const Value: string);
begin
  FDirRemessa := Value;
end;

end.
