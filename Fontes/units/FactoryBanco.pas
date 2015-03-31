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
      raise Exception.Create('Banco ' + ABanco + ' não implementado!');
  end;
end;

end.
 