unit FactoryArquivoBB;

interface

uses FactoryArquivo, LCBase, Arquivo, SysUtils;

type
  TFactoryArquivoBB = class(TFactoryArquivo)
  public
    function CreateArquivo(ATipo: TTipoArquivo): TArquivo; override;
  end;

implementation

uses
  BBCnab240;

{ TFactoryArquivoBB }

function TFactoryArquivoBB.CreateArquivo(ATipo: TTipoArquivo): TArquivo;
begin
  case ATipo of
    taCnab240: Result := TBBCnab240.create;
  else
    raise Exception.create('Tipo de arquivo para este banco não implementado!');
  end;
end;

end.
