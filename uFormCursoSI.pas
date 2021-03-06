unit uFormCursoSI;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.TabControl, FMX.WebBrowser;

type
  TFormCursoSI = class(TForm)
    ToolBar_Titulo: TToolBar;
    btnVoltar: TButton;
    lblTitulo: TLabel;
    TabControl_Curso: TTabControl;
    TabItem1: TTabItem;
    WebBrowser_Apresentação: TWebBrowser;
    TabItem2: TTabItem;
    WebBrowser_MatrizSI: TWebBrowser;
    procedure btnVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCursoSI: TFormCursoSI;

implementation

{$R *.fmx}

procedure TFormCursoSI.btnVoltarClick(Sender: TObject);
begin
  Self.Close;
end;

end.
