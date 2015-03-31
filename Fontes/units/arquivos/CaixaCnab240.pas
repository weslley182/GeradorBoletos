unit CaixaCnab240;

interface

uses
  Cnab240;

type
  TCaixaCnab240 = class(TCnab240)
  protected
    procedure SegmentoP(Index: Integer); override;

    procedure HeaderArquivo; override;
    procedure HeaderLote; override;
  public
    function GerarRemessa: Boolean; override;
  end;


implementation

uses uFuncoes;

{ TCaixaCnab240 }

function TCaixaCnab240.GerarRemessa: Boolean;
begin
  NomeCompletoArquivo := DirRemessa + 'Remessa.txt';

  Result := inherited GerarRemessa;
end;

procedure TCaixaCnab240.HeaderArquivo;
begin
  FLayoutArquivo := '050';

  FCampoUsoEmpresa := LPad('REMESSA-PRODUCAO',39);

  FCodigoConta := RPad(Titulos.Items[0].Cedente.DadosBanco.CodCedente, 6) + //!NUMERO DO CONVENIO  ! 59! 64! 6! - !NUMERICO     !6/8!
    rpad('0',8);  // USO EXCLUSIVO DA CAIXA

  FNomeBanco := 'CAIXA ECONOMICA FEDERAL'; //!NOME DO BANCO                  !103!132! 30! - !ALFANUMERICO !   !

  inherited;
end;

procedure TCaixaCnab240.HeaderLote;
begin
  FLayoutLote := '030';

  FCodConvenio := Rpad('0',20);

  inherited;
end;

procedure TCaixaCnab240.SegmentoP(Index: Integer);
begin
  FTipoDocumento    := '2';
  FNumeroDocumento  := LPad(Titulos.Items[index].NumDocumento, 11) +  //Número do Documento de Cobrança ! 63! 73! 11! - Alfa
    lpad('',4);  //Uso Exclusivo CAIXA ! 74! 77! 4! - Alfa !Brancos
  FAgenciaCobradora := '000000'; // //101 a 106 - Agência cobradora + Digito
  FContrato         := '0'; //!N. DO CONTR. DA OPERACAO D CRED!230!239! 10! - !NUMERICO     !   !

  inherited;
end;

end.
