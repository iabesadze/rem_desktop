unit Unit2;

interface

uses
  Winapi.Windows,jpeg,vcl.Imaging.pngimage
, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, Vcl.StdCtrls, GR32_Image;

type
  TForm2 = class(TForm)
    IdTCPClient1: TIdTCPClient;
    Timer1: TTimer;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Image321: TImage32;
    procedure Timer1Timer(Sender: TObject);
    procedure IdTCPClient1Connected(Sender: TObject);
    procedure IdTCPClient1Disconnected(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
try

IdTCPClient1.Disconnect;
IdTCPClient1.Host:=edit1.Text;
IdTCPClient1.port:=strtoint(edit2.Text);
IdTCPClient1.Connect;
     Timer1.Enabled:=true;
except
     on E: exception do
    begin
        ShowMessage(e.message);
    end;
end;


end;

procedure TForm2.IdTCPClient1Connected(Sender: TObject);
begin
caption:='connected';
end;

procedure TForm2.IdTCPClient1Disconnected(Sender: TObject);
begin
Timer1.Enabled:=false;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
var
st:TMemoryStream;
  a:TPngImage;
begin
//Timer1.Enabled:=false;
   try
     a:=TPngImage.Create;
     IdTCPClient1.IOHandler.WriteLn('jpg');
   st:=TMemoryStream.Create;;
   IdTCPClient1.IOHandler.ReadStream(st);
   st.Position:=0;
   a.LoadFromStream(st);
   Image321.Bitmap.Assign(a);
//   Image1.picture.bitmap.Assign(a);
   st.Free;
    a.Free;
   except
    on E: exception do
    begin
    Timer1.Enabled:=false;
      ShowMessage(e.message);
    end;


   end;

end;

end.
