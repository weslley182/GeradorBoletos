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
unit Banco;

interface

uses Classes, uFuncoes, DB, SysUtils, LCBase, DadoFormatado;

type
  { Classe abstrata que serve de base para as classes
   específicas de  cada banco. }
  TBanco = class(TPersistent)
  private
    FContrato: string;
    FConta: string;
    FNumeroBanco: string;
    FConvenio: string;
    FAgencia: string;
    FSeqNossoNum: Integer;
    FCarteira: string;
    FNomeBanco: string;
    FNossoNumero: string;
    FCampoLivre: string;
    FCodCedente: string;
    FDigitoAgencia: string;
    FDigitoConta: string;
    FDadosFormatados: TDadoFormatado;
    FLocalPagamento: string;
    procedure SetAgencia(const Value: string);
    procedure SetConta(const Value: string);
    procedure SetContrato(const Value: string);
    procedure SetConvenio(const Value: string);
    procedure SetNumeroBanco(const Value: string);
    procedure SetCampoLivre(const Value: string);
    procedure SetCarteira(const Value: string);
    procedure SetNomeBanco(const Value: string);
    procedure SetNossoNumero(const Value: string);
    procedure SetSeqNossoNum(const Value: Integer);
    procedure SetCodCedente(const Value: string);
    procedure SetDigitoAgencia(const Value: string);
    procedure SetDigitoConta(const Value: string);
    procedure SetDadosFormatados(const Value: TDadoFormatado);
    function getDigitoBanco: string;
    procedure SetLocalPagamento(const Value: string);
    procedure setDigitoNossoNumero(const Value: string);
  protected
    FDigitoNossoNumero : string;
    function getDigitoNossoNumero: string; virtual; abstract;
    function formataNossoNumero: string; virtual; abstract;
    function getCampoLivre: string; virtual; abstract;
  public
    constructor Create;
    destructor destroy; override;

    procedure Formatar; virtual;
    procedure Assign(Source: TBanco); reintroduce;
  published
    property NumeroBanco: string read FNumeroBanco write SetNumeroBanco;
    property LocalPagamento: string read FLocalPagamento write SetLocalPagamento;
    property DigitoBanco: string read getDigitoBanco;
    property Agencia: string read FAgencia write SetAgencia;
    property DigitoAgencia: string read FDigitoAgencia write SetDigitoAgencia;
    property Conta: string read FConta write SetConta;
    property DigitoConta: string read FDigitoConta write SetDigitoConta;
    property CodCedente: string read FCodCedente write SetCodCedente;
    property Convenio: string read FConvenio write SetConvenio;
    property Contrato: string read FContrato write SetContrato;
    property SeqNossoNum: Integer read FSeqNossoNum write SetSeqNossoNum;
    property Carteira: string read FCarteira write SetCarteira;
    property NossoNumero: string read FNossoNumero write SetNossoNumero;
    property DigitoNossoNumero: string read FDigitoNossoNumero write setDigitoNossoNumero;
    property NomeBanco: string read FNomeBanco write SetNomeBanco;
    property CampoLivre: string read FCampoLivre write SetCampoLivre;
    property DadosFormatados: TDadoFormatado read FDadosFormatados write SetDadosFormatados;
  end;

implementation

{ TBanco }

procedure TBanco.Assign(Source: TBanco);
begin
  CopyObject(Source, Self);
end;

constructor TBanco.Create;
begin
  inherited;
  DadosFormatados := TDadoFormatado.Create;
  LocalPagamento  := 'PAGAVEL EM QUALQUER AGENCIA BANCARIA ATE O VENCIMENTO';
end;

destructor TBanco.destroy;
begin
  FreeAndNil(FDadosFormatados);
  inherited;
end;

procedure TBanco.Formatar;
begin
  if trim(FConta) = '' then
   raise Exception.create('Informe o número da conta!');
  if Trim(FNumeroBanco) = '' then
    raise Exception.Create('Informe o número do banco!');
  if Trim(FAgencia) = '' then
    raise Exception.Create('Informe a Agência!');
  if Trim(FCarteira) = '' then
    raise Exception.Create('Informe a Carteira!');
  if SeqNossoNum = 0 then
    raise Exception.Create('Informe a sequência do Nosso Número!');
end;

function TBanco.getDigitoBanco: string;
begin
  if NumeroBanco = '' then
    Result := ''
  else
    Result := Modulo11(NumeroBanco, 9);
end;

procedure TBanco.SetAgencia(const Value: string);
begin
  FAgencia := Value;
end;

procedure TBanco.SetCampoLivre(const Value: string);
begin
  FCampoLivre := Value;
end;

procedure TBanco.SetCarteira(const Value: string);
begin
  FCarteira := Value;
end;

procedure TBanco.SetCodCedente(const Value: string);
begin
  FCodCedente := Value;
end;

procedure TBanco.SetConta(const Value: string);
begin
  FConta := Value;
end;

procedure TBanco.SetContrato(const Value: string);
begin
  FContrato := Value;
end;

procedure TBanco.SetConvenio(const Value: string);
begin
  FConvenio := Value;
end;

procedure TBanco.SetDadosFormatados(const Value: TDadoFormatado);
begin
  FDadosFormatados := Value;
end;

procedure TBanco.SetDigitoAgencia(const Value: string);
begin
  FDigitoAgencia := Value;
end;

procedure TBanco.SetDigitoConta(const Value: string);
begin
  FDigitoConta := Value;
end;

procedure TBanco.setDigitoNossoNumero(const Value: string);
begin
  FDigitoNossoNumero := Value;
end;

procedure TBanco.SetLocalPagamento(const Value: string);
begin
  FLocalPagamento := Value;
end;

procedure TBanco.SetNomeBanco(const Value: string);
begin
  FNomeBanco := Value;
end;

procedure TBanco.SetNossoNumero(const Value: string);
begin
  FNossoNumero := Value;
end;

procedure TBanco.SetNumeroBanco(const Value: string);
begin
  FNumeroBanco := Value;
end;

procedure TBanco.SetSeqNossoNum(const Value: Integer);
begin
  FSeqNossoNum := Value;
end;

end.
