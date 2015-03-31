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
unit Banco104;

interface

uses Banco, uFuncoes, SysUtils;

type
  TBanco104 = class (TBanco)
  private
    FDigitoCedente: string;
  protected
    function getDigitoNossoNumero: string; override;
    function formataNossoNumero: string; override;
    function getCampoLivre: string; override;
  public
    procedure Formatar; override;
  end;

implementation

{ TBanco104 }

procedure TBanco104.Formatar;
begin
  inherited;

  if not ((Carteira = '01') or (Carteira = '02')) then
    raise Exception.Create('Carteira inválida! Use Carteira 01 ou 02.');

  if Trim(CodCedente) = '' then
    raise Exception.Create('Informe o código do cedente!');

  NomeBanco          := 'Caixa Econômica';
  Agencia            := rpad(Agencia, 4);
  Carteira           := rpad(Carteira, 2);
  Conta              := rpad(Conta, 6);
  CodCedente         := rpad(CodCedente, 6);

  NossoNumero        := RPad(IntToStr(SeqNossoNum), 15);
  FDigitoNossoNumero := getDigitoNossoNumero;
  FDigitoCedente     := Modulo11(CodCedente);

  CampoLivre         := getCampoLivre;

  // configura dados para impressao
  with DadosFormatados do
  begin
    ImpNossoNumero   := formataNossoNumero + '-' + DigitoNossoNumero;
    ImpContaAgencia  := Agencia + '-' + DigitoAgencia + '/' + Conta + '-' + DigitoConta;
    ImpCarteira      := Carteira+'/19';
  end;
end;

function TBanco104.formataNossoNumero: string;
begin
  if Carteira = '01' then
    Result := '14'+NossoNumero
  else
    Result := '24'+NossoNumero;
end;

function TBanco104.getDigitoNossoNumero: string;
begin
  Result := Modulo11(formataNossoNumero);
end;

function TBanco104.getCampoLivre: string;
begin
  Result := CodCedente + FDigitoCedente +
            Copy(NossoNumero,1,3) + Carteira[2] +
            Copy(NossoNumero,4,3) + '4' + //cedente emite o boleto
            Copy(NossoNumero,7,9); // pega o restante do nosso numero

  Result := Result + Modulo11(Result);
end;


end.

