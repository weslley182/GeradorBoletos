unit FactoryArquivo;

interface

uses LCBase, Arquivo, SysUtils;

type
  TFactoryArquivo = class
  public
    class function GetFabrica(ABanco: string): TFactoryArquivo;
    function CreateArquivo(ATipo: TTipoArquivo): TArquivo; virtual; abstract;
  end;

implementation

uses
  FactoryArquivoBB, FactoryArquivoCaixa, FactoryArquivoBradesco;

{ TFactoryArquivo }

class function TFactoryArquivo.GetFabrica(ABanco: string): TFactoryArquivo;
begin
  case StrToInt(ABanco) of
    1:   Result := TFactoryArquivoBB.Create;
    104: Result := TFactoryArquivoCaixa.Create;
    237: Result := TFactoryArquivoBradesco.Create;
  else
    raise Exception.Create('Arquivo para o banco informado não implementado!');
  end;
end;

end.
