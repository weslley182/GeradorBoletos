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
unit Cedente;

interface

uses Classes, Pessoa, Banco, SysUtils;

type
   TCedente = class (TPessoa)
  private
    FDadosBanco: TBanco;
    procedure SetDadosBanco(const Value: TBanco);
  public
    constructor create;
    destructor destroy; override;
  published
    property DadosBanco: TBanco read FDadosBanco write SetDadosBanco;
  end;

implementation

{ TCedente }

constructor TCedente.create;
begin
  inherited;
  FDadosBanco := TBanco.Create;
end;

destructor TCedente.destroy;
begin
  FreeAndNil(FDadosBanco);
  inherited;
end;

procedure TCedente.SetDadosBanco(const Value: TBanco);
begin
  FDadosBanco := Value;
end;

end.
