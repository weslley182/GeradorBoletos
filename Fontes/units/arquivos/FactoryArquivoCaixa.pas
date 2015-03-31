unit FactoryArquivoCaixa;

interface

uses FactoryArquivo, LCBase, Arquivo, SysUtils;

type
  TFactoryArquivoCaixa = class(TFactoryArquivo)
  public
    function CreateArquivo(ATipo: TTipoArquivo): TArquivo; override;
  end;

implementation

uses
  CaixaCnab240;

{ TFactoryArquivoCaixa }

function TFactoryArquivoCaixa.CreateArquivo(ATipo: TTipoArquivo): TArquivo;
begin
  case ATipo of
    taCnab240: Result := TCaixaCnab240.create;
  else
    raise Exception.create('Tipo de arquivo para este banco não implementado!');
  end;
end;

end.
