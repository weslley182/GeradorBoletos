unit FactoryArquivoBradesco;

interface

uses FactoryArquivo, LCBase, Arquivo, SysUtils;

type
  TFactoryArquivoBradesco = class(TFactoryArquivo)
  public
    function CreateArquivo(ATipo: TTipoArquivo): TArquivo; override;
  end;

implementation

uses
  BradescoCnab400;

{ TFactoryArquivoBradesco }

function TFactoryArquivoBradesco.CreateArquivo(ATipo: TTipoArquivo): TArquivo;
begin
  case ATipo of
    taCnab400: Result := TBradescoCnab400.create;
  else
    raise Exception.create('Tipo de arquivo para este banco não implementado!');
  end;
end;

end.
