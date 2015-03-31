{******************************************************************************}
{ Projeto: Curso Criando Componente Boleto                                     }
{                                                                              }
{ Copyright (C) 2011 Luiz Carlos                                               }
{                                                                              }
{ Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la  }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation;                                                    }
{                                                                              }
{ Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM    }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT)                             }
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
    raise Exception.Create('Carteira inv�lida! Use Carteira 01 ou 02.');

  if Trim(CodCedente) = '' then
    raise Exception.Create('Informe o c�digo do cedente!');

  NomeBanco          := 'Caixa Econ�mica';
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

