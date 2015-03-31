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
unit Banco001;

interface

uses Banco, SysUtils;

type
  TBanco001 = class (TBanco)
  private
  protected
    function formataNossoNumero: string; override;
    function getCampoLivre: string; override;
  public
    procedure Formatar; override;
  end;

implementation

uses
  uFuncoes, DadoFormatado;

{ TBanco001 }

function TBanco001.formataNossoNumero: string;
var
  QtdRetorno: Integer;
begin
  case Length(Convenio) of
    6: QtdRetorno := 11;
    7: QtdRetorno := 10
    else QtdRetorno := 0;
  end;
  Result := Convenio + RPad(IntToStr(SeqNossoNum), QtdRetorno, '0');
end;

procedure TBanco001.Formatar;
begin
  inherited;
  if not ((Carteira = '17') or (Carteira = '18')) then
    raise Exception.Create('Carteira inválida! Use Carteira 17 ou 18.');

  NomeBanco   := 'Banco do Brasil';
  NossoNumero := formataNossoNumero;

  Agencia     := RPad(Agencia,5);
  Carteira    := RPad(Carteira,2);
  Conta       := RPad(Conta,12);

  CampoLivre  := getCampoLivre;

  // configura dados para impressao
  with DadosFormatados do
  begin
    ImpNossoNumero   := NossoNumero;
    ImpContaAgencia  := Agencia + '-' + DigitoAgencia + '/' + Conta + '-' + DigitoConta;
    ImpCarteira      := Carteira+'/19';
  end;
end;

function TBanco001.getCampoLivre: string;
begin
  if Length(Convenio) = 7 then
    Result := '000000' + NossoNumero + Carteira
  else
    raise Exception.Create('Convênio não implementado!');
end;

end.
