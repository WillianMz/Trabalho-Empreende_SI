unit uFormPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.MultiView,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListBox, FMX.Edit,
  FMX.Layouts, FMX.Objects, FMX.WebBrowser, FMX.TabControl, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, FMX.ListView,System.JSON, IdSSLOpenSSL;

type
  TFormPrincipal = class(TForm)
    ToolBar_Titulo: TToolBar;
    lblTitulo: TLabel;
    lyt_Menu: TLayout;
    btnVerNoticias: TButton;
    btnUsuario: TButton;
    btnCurso: TButton;
    lblDesenvolvedor: TLabel;
    tcPrincipal: TTabControl;
    tabVideo: TTabItem;
    wbVideo: TWebBrowser;
    btnSobre: TButton;
    procedure btnVerNoticiasClick(Sender: TObject);
    procedure btnCursoClick(Sender: TObject);
    procedure btnUsuarioClick(Sender: TObject);
    procedure btnSobreClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;


implementation

{$R *.fmx}

uses uFormCadUsuario, Androidapi.JNI.Network, uFormSobre, uFormCursoSI, uFormNoticias;


procedure TFormPrincipal.btnCursoClick(Sender: TObject);
begin
  if IsConnected = False then
    begin
      ShowMessage('Ops.! Verifique sua conex?o com a internet!');
      Exit;
    end
  else
      try
        Application.CreateForm(TFormCursoSI, FormCursoSI);
        FormCursoSI.Show;
      finally
        FreeAndNil(FormCursoSI);
      end;
end;

procedure TFormPrincipal.btnSobreClick(Sender: TObject);
begin
  try
    Application.CreateForm(TFormSobre, FormSobre);
    FormSobre.Show;
  finally
    FreeAndNil(FormSobre);
  end;
end;

procedure TFormPrincipal.btnUsuarioClick(Sender: TObject);
begin
  if IsConnected = False then
    begin
      ShowMessage('Ops.! Verifique sua conex?o com a internet!');
      Exit;
    end
  else
    FormCadUsuario.Show;
end;

procedure TFormPrincipal.btnVerNoticiasClick(Sender: TObject);
begin
  if IsConnected = False then
    begin
      ShowMessage('Ops.! Verifique sua conex?o com a internet!');
      Exit;
    end
  else
      try
        Application.CreateForm(TformNoticias, formNoticias);
        formNoticias.Show;
      finally
        FreeAndNil(formNoticias);
      end;
end;




end.
