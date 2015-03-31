unit DadoFormatado;

interface

uses Classes;

type
  TDadoFormatado = class (TPersistent)
  private
    FImpContaAgencia: string;
    FImpCarteira: string;
    FImpNossoNumero: string;
    procedure SetImpCarteira(const Value: string);
    procedure SetImpContaAgencia(const Value: string);
    procedure SetImpNossoNumero(const Value: string);
  published
    property ImpNossoNumero: string read FImpNossoNumero write SetImpNossoNumero;
    property ImpContaAgencia: string read FImpContaAgencia write SetImpContaAgencia;
    property ImpCarteira: string read FImpCarteira write SetImpCarteira;
  end;

implementation


{ TDadoFormatado }

procedure TDadoFormatado.SetImpCarteira(const Value: string);
begin
  FImpCarteira := Value;
end;

procedure TDadoFormatado.SetImpContaAgencia(const Value: string);
begin
  FImpContaAgencia := Value;
end;

procedure TDadoFormatado.SetImpNossoNumero(const Value: string);
begin
  FImpNossoNumero := Value;
end;

end.
