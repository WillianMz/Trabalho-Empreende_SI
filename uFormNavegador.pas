unit uFormNavegador;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.WebBrowser;

type
  TformNavegador = class(TForm)
    ToolBar_Titulo: TToolBar;
    btnVoltar: TButton;
    lblTitulo: TLabel;
    wbNavegador: TWebBrowser;
    procedure btnVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formNavegador: TformNavegador;

implementation

{$R *.fmx}

procedure TformNavegador.btnVoltarClick(Sender: TObject);
begin
  formNavegador.Close;
end;

end.
