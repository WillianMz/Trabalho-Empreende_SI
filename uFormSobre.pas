unit uFormSobre;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo;

type
  TFormSobre = class(TForm)
    ToolBar_Titulo: TToolBar;
    btnVoltar: TButton;
    lblTitulo: TLabel;
    Memo_Descricao: TMemo;
    procedure btnVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSobre: TFormSobre;

implementation

{$R *.fmx}

procedure TFormSobre.btnVoltarClick(Sender: TObject);
begin
  Self.Close;
end;

end.
