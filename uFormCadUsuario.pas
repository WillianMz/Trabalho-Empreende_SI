unit uFormCadUsuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.DateTimeCtrls, FMX.Edit, FMX.ListBox, FMX.Layouts, FMX.TabControl,
  FMX.StdCtrls, FMX.Controls.Presentation, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IniFiles,
  
  System.IOUtils;

type
  TFormCadUsuario = class(TForm)
    ToolBar_Titulo: TToolBar;
    lblTitulo: TLabel;
    TabControl_cadUser: TTabControl;
    TabItem_Nome: TTabItem;
    Layout_Menu: TLayout;
    btnConcluir: TButton;
    ListBox_Dados: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    edtNomeCompleto: TEdit;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    edtCelular: TEdit;
    IdHTTP: TIdHTTP;
    ListBoxItem5: TListBoxItem;
    Label1: TLabel;
    Switch1: TSwitch;
    ListBoxItem6: TListBoxItem;
    btnTermosDeUso: TButton;
    procedure btnConcluirClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure gravarDadosLocais;
    procedure lerDadosLocais;
  public
    { Public declarations }
    procedure CadastarUsuario;
  end;

var
  FormCadUsuario: TFormCadUsuario;

implementation

{$R *.fmx}

uses uFormPrincipal;



procedure TFormCadUsuario.btnVoltarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFormCadUsuario.CadastarUsuario;
//begin

  //IdHTTP.Post('hhttp://esucriapp.servicos.ws/api/users/cadUsuario.php?');
var
  nome, celular, url : String;
  Response : TStringStream;
begin
  nome := edtNomeCompleto.Text;
  celular := edtCelular.Text;

  Response := TStringStream.Create('');

  try
    try
      url := 'http://esucriapp.servicos.ws/api/users/cadUsuario.php?' +
      'nome="'+nome+'"'+'&celular="'+celular+'"';

      IdHTTP.Get(url,response);
      Response.Position := 0;
      //ShowMessage(Response);
    except
      on E:Exception do
        begin
          ShowMessage('Se voc? entender este erro, voc? est? no curso certo. Erro: '+e.Message);
        end;
    end;
  finally
    Response.Free();
      try
        Application.CreateForm(TFormPrincipal, FormPrincipal);
        FormPrincipal.Show;
      finally
        //FreeAndNil(FormPrincipal);
      end;
    self.Close;
  end;

end;

procedure TFormCadUsuario.FormShow(Sender: TObject);
begin
  lerDadosLocais;
end;

procedure TFormCadUsuario.gravarDadosLocais;
var
  INI : TIniFile;
begin
  try
    //True por padr?o, caso o usu?rio esque?a
    Switch1.IsChecked := True;
    INI := TIniFile.Create(TPath.Combine(TPath.GetDocumentsPath,'Dados.ini'));

    INI.WriteString('USUARIO','Nome',edtNomeCompleto.Text);
    INI.WriteString('USUARIO','Celular',edtCelular.Text);
    INI.WriteBool('USUARIO','Lembrar',Switch1.IsChecked);
  finally
    INI.DisposeOf;
  end;
end;

procedure TFormCadUsuario.lerDadosLocais;
var
  INI : TIniFile;
  nome, celular : String;
  lembrar : Boolean;
begin
  try
    INI := TIniFile.Create(TPath.Combine(TPath.GetDocumentsPath,'Dados.ini'));
    INI.ReadString('USUARIO','Nome',nome);
    INI.ReadString('USUARIO','Celular', celular);
    Switch1.IsChecked := INI.ReadBool('USUARIO','Lembrar', lembrar);
    //edtNomeCompleto.Text := INI.ReadString('USUARIO','Nome',nome);
    //edtCelular.Text := INI.ReadString('USUARIO','Celular', celular);
    //Switch1.IsChecked := INI.ReadBool('USUARIO','Lembrar', lembrar);

    if Switch1.IsChecked = false then
      begin
        edtNomeCompleto.Text := '';
        edtCelular.Text := '';
        Switch1.IsChecked := False;
        edtNomeCompleto.SetFocus;
      end
    else
        if Switch1.IsChecked = true then
          begin
            edtNomeCompleto.Text := INI.ReadString('USUARIO','Nome',nome);
            edtCelular.Text := INI.ReadString('USUARIO','Celular', celular);
            Switch1.IsChecked := INI.ReadBool('USUARIO','Lembrar', lembrar);
          end;

  finally
    INI.DisposeOf;
  end;

end;

procedure TFormCadUsuario.btnConcluirClick(Sender: TObject);
begin

  if edtNomeCompleto.Text = '' then
   begin
     ShowMessage('Digite o seu nome completo');
     edtNomeCompleto.SetFocus;
     exit;
   end;

  if edtCelular.Text = '' then
    begin
      ShowMessage('Informe o N? do seu celular');
      edtCelular.SetFocus;
      exit;
    end;

   if (Length(edtCelular.Text) < 11) then
    begin
      ShowMessage('O N?mero de celular deve conter 11 dig?tos incluindo o DDD + N?mero!');
      edtCelular.SetFocus;
      exit;
    end;

  //ShowMessage('TESTE DE CADASTRO!');
  gravarDadosLocais;
  CadastarUsuario;
end;

end.
