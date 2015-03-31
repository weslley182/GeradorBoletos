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
unit FactoryBanco;

interface

uses Banco, SysUtils;

type
  TFactoryBanco = class
  public
    class function GetBanco (ABanco: string): TBanco;
  published

  end;

implementation

{ TFactoryBanco }

uses Banco001, Banco104, Banco237;

class function TFactoryBanco.GetBanco(ABanco: string): TBanco;
begin
  case StrToInt(ABanco) of
    1  : Result := TBanco001.create;
    104: Result := TBanco104.create;
    237: Result := TBanco237.create;
    else
      raise Exception.Create('Banco ' + ABanco + ' n�o implementado!');
  end;
end;

end.
 