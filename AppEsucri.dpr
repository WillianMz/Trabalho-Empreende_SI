program AppEsucri;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFormPrincipal in 'uFormPrincipal.pas' {FormPrincipal},
  uFormCadUsuario in 'uFormCadUsuario.pas' {FormCadUsuario},
  Androidapi.JNI.Network in 'Androidapi.JNI.Network.pas',
  uFormSobre in 'uFormSobre.pas' {FormSobre},
  uFormCursoSI in 'uFormCursoSI.pas' {FormCursoSI},
  uFormNoticias in 'uFormNoticias.pas' {formNoticias},
  uFormSplash in 'uFormSplash.pas' {formSplash},
  uFormNavegador in 'uFormNavegador.pas' {formNavegador};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TformSplash, formSplash);
  Application.CreateForm(TFormCadUsuario, FormCadUsuario);
  Application.Run;
end.
