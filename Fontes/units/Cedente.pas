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
