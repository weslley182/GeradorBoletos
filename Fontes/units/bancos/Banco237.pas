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
unit Banco237;

interface

uses Banco, uFuncoes, SysUtils;

type
  TBanco237 = class (TBanco)
  private
  protected
    function getDigitoNossoNumero: string; override;
    function formataNossoNumero: string; override;
    function getCampoLivre: string; override;
  public
    procedure Formatar; override;
  end;

implementation

{ TBanco237 }

procedure TBanco237.Formatar;
begin
  inherited;

//  if not ((Carteira = '01') or (Carteira = '02')) then
//    raise Exception.Create('Carteira inválida! Use Carteira 01 ou 02.');

  if Trim(CodCedente) = '' then
    raise Exception.Create('Informe o código do cedente!');

  NomeBanco          := 'Bradesco';
  Agencia            := RPad(Agencia, 4);
  Carteira           := RPad(Carteira, 2);
  Conta              := RPad(Conta, 7);
  CodCedente         := RPad(CodCedente, 6);

  NossoNumero        := formataNossoNumero;
  FDigitoNossoNumero := getDigitoNossoNumero;

  CampoLivre         := getCampoLivre;

  // configura dados para impressao
  with DadosFormatados do
  begin
    ImpNossoNumero   := Carteira + '/'+ NossoNumero + '-' + FDigitoNossoNumero;
    ImpContaAgencia  := Agencia + '/' + Conta + '-' + DigitoConta;
    ImpCarteira      := Carteira;
  end;
end;

function TBanco237.formataNossoNumero: string;
begin
  Result := RPad(IntToStr(SeqNossoNum), 11, '0');
end;

function TBanco237.getDigitoNossoNumero: string;
var
  ADigito: string;
begin
  Result := '0';

  ADigito := Modulo11(Carteira + NossoNumero,7,true);

  if StrToInt(ADigito) = 1 then
     ADigito := 'P'
  else if StrToInt(ADigito) > 1 then
     ADigito := IntToStr(11 - StrToInt(ADigito));

  Result := ADigito;
end;

function TBanco237.getCampoLivre: string;
begin
  Result := Agencia + Carteira + NossoNumero + RPad(Conta,7) + '0';
end;


end.

