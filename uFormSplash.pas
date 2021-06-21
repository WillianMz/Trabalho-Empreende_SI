unit uFormSplash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,

  System.Devices, FMX.Objects, IniFiles,

  System.IOUtils;

type
  TformSplash = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Paint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
  private
    { Private declarations }
     FInitialized : Boolean;
    procedure carregarForm;
  public
    { Public declarations }
  end;

var
  formSplash: TformSplash;

implementation

{$R *.fmx}

uses uFormCadUsuario, uFormPrincipal;

procedure TformSplash.carregarForm;
var
  INI : TIniFile;
  login, lembrar : Boolean;
begin
  //FrmClass := nil;

  //case TDeviceInfo.ThisDevice.DeviceClass of
   // TDeviceInfo.TDeviceClass.Desktop : FrmClass := TfMain;
    //TDeviceInfo.TDeviceClass.Phone : FrmClass := TformCadUsuario;
    //TDeviceInfo.TDeviceClass.Tablet  : FrmClass := TfMain;
  //end;

  {
  if FormCadUsuario <> nil then
    begin
      FormCadUsuario.Show;
    end
  else
    begin
      ShowMessage('Erro, contate o suporte!');
    end;
         }
  //FormCadUsuario.Show;
  //formSplash.Close;
  //Close; //Fecha o form Splash
 {

  try
    INI := TIniFile.Create(TPath.Combine(TPath.GetDocumentsPath,'Config.wn'));
    login := INI.ReadBool('CONFIGURACOES','Lembrar',lembrar);

    if login = false then
      begin
        ShowMessage('Bem-vindo ao AppEsucri! Para conhecer suas funcionalidades, informe seu nome e n�mero de telefone.');
        formSplash.Visible := False;
        FormCadUsuario.Show;
      end
    else
        if login = true then
          begin
            formSplash.Visible := false;
            FormPrincipal.Show;
          end;
  except
    on E:Exception do
      ShowMessage('Erro: '+ e.Message);

  end;    }


    //FormCadUsuario.ShowModal;
  //  formSplash.Visible := false;
  formSplash.Visible := false;
  FormCadUsuario.Show;

end;



procedure TformSplash.FormCreate(Sender: TObject);
begin
  Timer1.Enabled  := False;
  Timer1.Interval := 2000;
end;

procedure TformSplash.Image1Paint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  Timer1.Enabled := not FInitialized;
end;


procedure TformSplash.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  if not FInitialized then
  begin
    FInitialized := True;
    carregarForm;
  end;
end;

end.
