{******************************************************************************}
{ Projeto: Curso Criando Componente Boleto                                     }
{                                                                              }
{ Copyright (C) 2011 Luiz Carlos                                               }
{                                                                              }
{ Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la  }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation;                                                    }
{                                                                              }
{ Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM    }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT)                             }
{                                                                              }
{                                                                              }
{ Luiz Carlos Alves                                                            }
{ luiz_sistemas@hotmail.com                                                    }
{ http://www.luizsistemas.com.br                                               }
{ Balsas-MA                                                                    }
{                                                                              }
{******************************************************************************}
unit Titulo;

interface

uses
  SysUtils, Classes, Cedente, Pessoa, Banco, uDadosComplementares, ExtCtrls;

type
  TLCTitulo = class(TComponent)
  private
    FValor: Currency;
    FNumDocumento: string;
    FVencimento: TDateTime;
    FData: TDateTime;
    FCedente: TCedente;
    FSacado: TPessoa;
    FCodigoBarras: string;
    FLinhaDigitavel: string;
    FDadosComplementares: TDadosComplementares;
    FInstrucao: TStringList;
    procedure SetData(const Value: TDateTime);
    procedure SetNumDocumento(const Value: string);
    procedure SetValor(const Value: Currency);
    procedure SetVencimento(const Value: TDateTime);
    procedure SetCedente(const Value: TCedente);
    procedure SetSacado(const Value: TPessoa);
    procedure GetCodigoBarras;
    procedure GetLinhaDigitavel;
    procedure SetDadosComplementares(const Value: TDadosComplementares);
    procedure SetInstrucao(Value: TStringList);
    function getCodBarrasImagem: TImage;
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor destroy; override;

    procedure Assign(Source: TLCTitulo); reintroduce;
    procedure FormatarDadosBanco;

    property CodBarrasImagem: TImage read getCodBarrasImagem;
  published
    { Published declarations }
    property Cedente: TCedente read FCedente write SetCedente;
    property Sacado: TPessoa read FSacado write SetSacado;
    property NumDocumento: string read FNumDocumento write SetNumDocumento;
    property Data: TDateTime read FData write SetData;
    property Vencimento: TDateTime read FVencimento write SetVencimento;
    property Valor: Currency read FValor write SetValor;
    property LinhaDigitavel: string read FLinhaDigitavel;
    property DadosComplementares: TDadosComplementares read FDadosComplementares
      write SetDadosComplementares;
    property Instrucao: TStringList read FInstrucao write SetInstrucao;
  end;

procedure Register;

implementation

uses
  FactoryBanco, LCBase, uFuncoes, Graphics;

procedure Register;
begin
  RegisterComponents('Boletos', [TLCTitulo]);
end;

{ TLCTitulo }

procedure TLCTitulo.Assign(Source: TLCTitulo);
begin
  CopyObject(Source, Self);
  Self.Instrucao.Assign(Source.Instrucao);
  FormatarDadosBanco;
end;

constructor TLCTitulo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCedente := TCedente.create;
  FSacado := TPessoa.create;
  FDadosComplementares := TDadosComplementares.create;
  FInstrucao := TStringList.Create;
end;

destructor TLCTitulo.destroy;
begin
  FreeAndNil(FDadosComplementares);
  FreeAndNil(FCedente);
  FreeAndNil(FSacado);
  FreeAndNil(FInstrucao);
  inherited;
end;

procedure TLCTitulo.FormatarDadosBanco;
var
  ABanco: TBanco;
begin
  ABanco := TFactoryBanco.GetBanco(Cedente.DadosBanco.NumeroBanco);
  try
    // gravamos os dados do componente em Abanco
    ABanco.Assign(Cedente.DadosBanco);
    // formatamos os dados de acordo com o banco selecionado
    ABanco.Formatar;
    // e devolvemos os dados formatos para o nosso componente
    Cedente.DadosBanco.Assign(ABanco);
    // gerar o código de barras
    GetCodigoBarras;
    // formatar linha digitável
    GetLinhaDigitavel;
  finally
    FreeAndNil(ABanco);
  end;
end;

function TLCTitulo.getCodBarrasImagem: TImage;
begin
  Result := TImage.Create(nil);
  Result.Height := 50;
  Result.Width  := 0;
  GerarImagemCodBarras(FCodigoBarras, Result);
end;

procedure TLCTitulo.GetCodigoBarras;
var
  ACodigoBarras,
    AFatorVencimento,
    AValorDocumento,
    ADigitoCodBarra: string;
begin
  AFatorVencimento := FatorVencimento(Vencimento);
  AValorDocumento := FormatCurr('0000000000', Valor * 100);
  ACodigoBarras := Cedente.DadosBanco.NumeroBanco +
    CODIGO_MOEDA + AFatorVencimento +
    AValorDocumento +
    Cedente.DadosBanco.CampoLivre;
  ADigitoCodBarra := DVBarras(ACodigoBarras);

  //inserindo o digito do código de barras
  Insert(ADigitoCodBarra, ACodigoBarras, 5);

  FCodigoBarras := ACodigoBarras;
end;

procedure TLCTitulo.GetLinhaDigitavel;
var
  ACampo1, ACampo2, ACampo3, ACampo4, ACampo5: string;
  ADVCampo1, ADVCampo2, ADVCampo3: string;
begin
  //formatando campo 1
  ACampo1 := Copy(FCodigoBarras, 1, 4) + Copy(FCodigoBarras, 20, 5);
  ADVCampo1 := Modulo10(ACampo1);
  ACampo1 := ACampo1 + ADVCampo1;
  Insert('.', ACampo1, 6);

  // formatando campo 2
  ACampo2 := Copy(FCodigoBarras, 25, 10); //posições 25 a 34 do codigobarras
  ADVCampo2 := Modulo10(ACampo2);
  ACampo2 := ACampo2 + ADVCampo2;
  Insert('.', ACampo2, 6);

  // formatando campo 3
  ACampo3 := Copy(FCodigoBarras, 35, 10); // pocições 35 à 44 do codigo barras
  ADVCampo3 := Modulo10(ACampo3);
  ACampo3 := ACampo3 + ADVCampo3;
  Insert('.', ACampo3, 6);

  // formatando o campo 4
  ACampo4 := FCodigoBarras[5];

  // formatando o campo 5
  ACampo5 := Copy(FCodigoBarras, 6, 14);

  FLinhaDigitavel := ACampo1 + ' ' + ACampo2 + ' ' + ACampo3 + ' ' + ACampo4 +
    ' ' + ACampo5;
end;

procedure TLCTitulo.SetCedente(const Value: TCedente);
begin
  FCedente := Value;
end;

procedure TLCTitulo.SetDadosComplementares(
  const Value: TDadosComplementares);
begin
  FDadosComplementares := Value;
end;

procedure TLCTitulo.SetData(const Value: TDateTime);
begin
  FData := Value;
end;

procedure TLCTitulo.SetInstrucao(Value: TStringList);
begin
  FInstrucao.Assign(Value);
end;

procedure TLCTitulo.SetNumDocumento(const Value: string);
begin
  FNumDocumento := Value;
end;

procedure TLCTitulo.SetSacado(const Value: TPessoa);
begin
  FSacado := Value;
end;

procedure TLCTitulo.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

procedure TLCTitulo.SetVencimento(const Value: TDateTime);
begin
  FVencimento := Value;
end;

end.
 
