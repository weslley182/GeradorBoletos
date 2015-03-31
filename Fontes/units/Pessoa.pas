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
unit Pessoa;

interface

uses Classes, Endereco, SysUtils, LCBase;

type
  TPessoa = class(TPersistent)
  private
    FTipo: TTipoPessoa;
    FNome: string;
    FCpf_Cnpj: string;
    FEndereco: TEndereco;
    procedure SetCpf_Cnpj(const Value: string);
    procedure SetEndereco(const Value: TEndereco);
    procedure SetNome(const Value: string);
    procedure SetTipo(const Value: TTipoPessoa);
  public
    constructor create;
    destructor destroy; override;
    procedure Assign(Source: TPessoa); reintroduce;
  published
    property Nome: string read FNome write SetNome;
    property Cpf_Cnpj: string read FCpf_Cnpj write SetCpf_Cnpj;
    property Tipo: TTipoPessoa read FTipo write SetTipo; //F - Fisica  J - Juridica
    property Endereco: TEndereco read FEndereco write SetEndereco;
  end;

implementation

uses
  uFuncoes;

{ TPessoa }

procedure TPessoa.Assign(Source: TPessoa);
begin
  CopyObject(Source, Self);
end;

constructor TPessoa.create;
begin
  FEndereco := TEndereco.Create;
end;

destructor TPessoa.destroy;
begin
  FreeAndNil(FEndereco);
  inherited;
end;

procedure TPessoa.SetCpf_Cnpj(const Value: string);
begin
  FCpf_Cnpj := Value;
end;

procedure TPessoa.SetEndereco(const Value: TEndereco);
begin
  FEndereco := Value;
end;

procedure TPessoa.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TPessoa.SetTipo(const Value: TTipoPessoa);
begin
  FTipo := Value;
end;

end.
