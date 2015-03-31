unit BBCnab240;

interface

uses Cnab240, uFuncoes, SysUtils;

type
  TBBCnab240 = class(TCnab240)
  protected
    procedure SegmentoP(Index: Integer); override;

    procedure HeaderArquivo; override;
    procedure HeaderLote; override;
  public
    function GerarRemessa: Boolean; override;
  end;

implementation

uses Banco, Cedente;

{ TBBCnab240 }

function TBBCnab240.GerarRemessa: Boolean;
var
  ANomeArquivo,
  AConta,
  AAgencia: string;
begin
  AAgencia := RPad(Titulos.Items[0].Cedente.DadosBanco.Agencia,4);
  AConta   := RPad(Titulos.Items[0].Cedente.DadosBanco.Conta,5);

  ANomeArquivo := 'CNAB240' + '_' + AAgencia + '_' + AConta + '_' +
    FormatDateTime('ddmmyyyy', Now) + '_' +
    IntToStr(NumArquivo) + '.REM';

  NomeCompletoArquivo := DirRemessa + ANomeArquivo;

  Result := inherited GerarRemessa;
end;

procedure TBBCnab240.HeaderArquivo;
begin
  FLayoutArquivo := '030';
  FCampoUsoEmpresa := LPad('', 20)  + //!PARA USO RESERVADO DA EMPRESA  !192!211! 20! - !ALFANUMERICO !   !
    LPad('', 11)                    + //EM BRANCO
    'CSP'                           +
    '000'                           + //não utilizado
    '  '                            ; //dois espaços não utilizados
  with Titulos.Items[0].Cedente.DadosBanco do
  begin
    FCodigoConta := RPad(Conta,12) + //!NUMERO DA CONTA CORRENTE       ! 59! 70! 12! - !NUMERICO     !6/8!
      DigitoConta         + //!DIGITO VERIFICADOR DA CONTA    ! 71! 71!  1! - !ALFANUMERICO !6/8!
      ' '                 ; //!DIGITO VERIFICADOR DA AG/CONTA ! 72! 72!  1! - !ALFANUMERICO !6/8!
    FNomeBanco := NomeBanco; //!NOME DO BANCO                  !103!132! 30! - !ALFANUMERICO !   !
  end;

  inherited;
end;

procedure TBBCnab240.HeaderLote;
begin
  FLayoutLote := '020';

  with Titulos.Items[0].Cedente.DadosBanco do
  begin
    FCodConvenio := Rpad(Convenio,9)+ '0014' +
      Carteira + '019';
  end;
  inherited;
end;

procedure TBBCnab240.SegmentoP(Index: Integer);
begin
  FTipoDocumento    := '1';
  FNumeroDocumento  := Titulos.Items[index].NumDocumento;
  FAgenciaCobradora := '000000'; // //101 a 106 - Agência cobradora + Digito
  FContrato         := Titulos.Items[index].Cedente.DadosBanco.Contrato; //!N. DO CONTR. DA OPERACAO D CRED!230!239! 10! - !NUMERICO     !   !

  inherited;

end;

end.
