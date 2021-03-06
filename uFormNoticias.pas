unit uFormNoticias;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, System.JSON,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdSSLOpenSSL,
  FMX.WebBrowser, FMX.TabControl;

type
  TformNoticias = class(TForm)
    ToolBar_Titulo: TToolBar;
    btnVoltar: TButton;
    lblTitulo: TLabel;
    lyt_Botoes: TLayout;
    btnLoad: TButton;
    btnDelete: TButton;
    IdHTTP: TIdHTTP;
    tabNoticia: TTabControl;
    tabLista: TTabItem;
    tabNavegador: TTabItem;
    lvNoticias: TListView;
    procedure btnLoadClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure lvNoticiasItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
    function retirarAspas(str: string) : string;
    //function GetURLasString(const aurl: string) : string;

    procedure buscaNoticia;
  end;

var
  formNoticias: TformNoticias;

  myData : string;
  jsv : TJsonValue;
  originalObject : TJsonObject;
  jsPair : TJsonPair;
  jsArr : TJsonArray;
  jso : TJsonObject;
  i : integer;
  LItem : TListViewItem;

implementation

{$R *.fmx}

uses uFormNavegador;

{ TformNoticias }

function GetURLasString(const aurl: string): string;
var
  iHTTP : TidHTTP;
begin
  iHTTP := TidHTTP.Create(nil);

  try
    iHTTP.IOHandler := TidSSLIOHandlerSocketOpenSSL.Create(iHTTP);
    result := iHTTP.Get(aurl);
  finally
    iHTTP.Free;
  end;
end;



procedure TformNoticias.btnDeleteClick(Sender: TObject);
begin
  lvNoticias.Items.Clear;
end;

procedure TformNoticias.btnLoadClick(Sender: TObject);
begin
  lvNoticias.Items.Clear;
  buscaNoticia;
end;

procedure TformNoticias.btnVoltarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TformNoticias.buscaNoticia;
begin
  try
    myData := GetURLasString('http://esucriapp.servicos.ws/api/noticias/getAll.php');
  except
    on E:Exception do
      ShowMessage('Erro 1: ' + e.Message);
  end;

  try
    jsv := TJSONObject.ParseJSONValue(myData);

    try
      originalObject := jsv as TJSONObject;
      jsPair := originalObject.Get('noticia');

      jsArr := jsPair.JsonValue as TJSONArray;

      for i := 0 to jsArr.Size do
        begin
          jso := jsArr.Get(i) as TJSONObject;

          for jsPair in jso do
            begin
              if jsPair.JsonString.Value = 'titulo' then
                begin
                  formNoticias.lvNoticias.BeginUpdate;
                  LItem := formNoticias.lvNoticias.Items.Add;

                  LItem.Text := retirarAspas(jso.GetValue('descricao').ToString);

                  LItem.Detail := retirarAspas(jso.GetValue('url_noticia').ToString);

                  //LItem.Detail := retirarAspas(jso.GetValue('data').ToString);

                  LItem.IndexTitle := retirarAspas(jso.GetValue('titulo').ToString);

                  formNoticias.lvNoticias.EndUpdate;
                end;
            end;
        end;
    finally
     // jsv.Free();
    end;

  except
    on E:Exception do
      begin
        //ShowMessage('Erro 2: '+e.Message);
        Exit;
      end;
  end;
end;


procedure TformNoticias.FormShow(Sender: TObject);
begin
  lvNoticias.Items.Clear;
  buscaNoticia;
end;


procedure TformNoticias.lvNoticiasItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  idNoticia : integer;
  url : string;
begin
  idNoticia := 0;

  if lvNoticias.Selected <> nil then
    begin
      idNoticia := lvNoticias.Selected.Index;
      url := lvNoticias.Items[idNoticia].Detail;
    end;

  //ShowMessage(IntToStr(idNoticia)+ ' URL: '+url);

  try
    Application.CreateForm(TformNavegador, formNavegador);
    formNavegador.wbNavegador.URL := url;
    formNavegador.Show;
  finally
    FreeAndNil(formNavegador);
  end;

//  url := lvNoticias.Items[lvNoticias.ItemIndex(idNoticia));


  //LItem.Detail := retirarAspas(jso.GetValue('url_noticia').ToString);

end;

function TformNoticias.retirarAspas(str: string): string;
var
 tamanho : integer;
begin
  tamanho := Length(str);
  str := copy(str, 2, tamanho - 2);
  result := str;
end;

end.
