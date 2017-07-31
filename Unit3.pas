unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages,vcl.Imaging.pngimage, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls,jpeg,dateutils, Vcl.Forms, Vcl.Dialogs, IdContext, IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer, Vcl.StdCtrls, Vcl.ExtCtrls,
  GR32_Image;

type
  TForm3 = class(TForm)
    IdTCPServer1: TIdTCPServer;
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Image1: TImage;
    Button2: TButton;
    Image321: TImage32;
    Button3: TButton;
    Edit3: TEdit;
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure IdTCPServer1Connect(AContext: TIdContext);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  var
Stream: TMemoryStream;
Desktopcanvas : TCanvas;
BitMap: TBitMap;
BM:TPngImage;
ms:int64;

CurPos: TPoint;

MyCursor: TIcon;
  pIconInfo: TIconInfo;
   CurPosX, CurPoxY: Integer;
   CursorInfo: TCursorInfo;
   IconInfo: TIconInfo;


implementation

{$R *.dfm}



function GetCursorInfo2: TCursorInfo;
var
 hWindow: HWND;
 pt: TPoint;
 pIconInfo: TIconInfo;
 dwThreadID, dwCurrentThreadID: DWORD;
begin
 Result.hCursor := 0;
 ZeroMemory(@Result, SizeOf(Result));
 // Find out which window owns the cursor
 if GetCursorPos(pt) then
 begin
   Result.ptScreenPos := pt;
   hWindow := WindowFromPoint(pt);
   if IsWindow(hWindow) then
   begin
     // Get the thread ID for the cursor owner.
     dwThreadID := GetWindowThreadProcessId(hWindow, nil);

     // Get the thread ID for the current thread
     dwCurrentThreadID := GetCurrentThreadId;

     // If the cursor owner is not us then we must attach to
     // the other thread in so that we can use GetCursor() to
     // return the correct hCursor
     if (dwCurrentThreadID <> dwThreadID) then
     begin
       if AttachThreadInput(dwCurrentThreadID, dwThreadID, True) then
       begin
         // Get the handle to the cursor
         Result.hCursor := GetCursor;
         AttachThreadInput(dwCurrentThreadID, dwThreadID, False);
       end;
     end
     else
     begin
       Result.hCursor := GetCursor;
     end;
   end;
 end;
end;

procedure jpg (Connection: TIdContext);

begin
BM:=TPngImage.Create;
BitMap := TBitMap.Create;
DesktopCanvas := TCanvas.Create;
DesktopCanvas.Handle := GetDC (Hwnd_Desktop);

BitMap.Width := Screen.Width;
BitMap.Height := Screen.Height;
//BitMap.Canvas.CopyRect (BitMap.Canvas.ClipRect,DesktopCanvas,DesktopCanvas.ClipRect);
//
//if not DrawIcon (BitMap.Canvas.Handle,Mouse.CursorPos.X,Mouse.CursorPos.Y,GetCursor) then
//begin
//
//end;


//form3.Image321.BitMap.Width:=Screen.Width;
//form3.Image321.BitMap.Height:=Screen.Height;
//form3.Image321.BitMap.Canvas.CopyRect(form3.Image321.BitMap.Canvas.ClipRect,DesktopCanvas,DesktopCanvas.ClipRect);
//if not DrawIcon (form3.Image321.bitmap.Canvas.Handle,Mouse.CursorPos.X,Mouse.CursorPos.Y,GetCursor) then
//begin
//
//end;

MyCursor := TIcon.Create;
  try
    CursorInfo := GetCursorInfo2;
     MyCursor.Handle := CursorInfo.hCursor;
    GetIconInfo(CursorInfo.hCursor, IconInfo);



    CurPosX := pIconInfo.xHotspot;
    CurPoxY := pIconInfo.yHotspot;
//bitblt(
//    form3.Image321.BitMap
BitMap.Canvas.CopyRect(BitMap.Canvas.ClipRect,DesktopCanvas,DesktopCanvas.ClipRect);
BitMap.Canvas.Draw(CursorInfo.ptScreenPos.X - IconInfo.xHotspot,
                           CursorInfo.ptScreenPos.Y - IconInfo.yHotspot, MyCursor);

//if not DrawIcon (BitMap.Canvas.Handle,Mouse.CursorPos.X,Mouse.CursorPos.Y,GetCursor) then
//begin
//
//end;
//BitMap.Canvas.Draw(Mouse.CursorPos.X,Mouse.CursorPos.Y,MyCursor);

BM.Assign(BitMap);
//BM.SaveToFile('C:\Users\vm\Pictures\aaaa.png');
//form3.Image321.BitMap.Assign(BitMap);
//form3.Image321.Bitmap.SaveToFile('C:\Users\vm\Pictures\aaaa.png');
//    form3.Image321.BitMap.Canvas.CopyRect(form3.Image321.BitMap.Canvas.ClipRect,DesktopCanvas,DesktopCanvas.ClipRect);
//    form3.Image321.BitMap.Canvas.Draw(Mouse.CursorPos.X,Mouse.CursorPos.Y,MyCursor);
  finally
    MyCursor.ReleaseHandle;
    MyCursor.Free;
  end;



//bm.Bitmap.Assign(BitMap);
//form3.Image321.BitMap.Assign(BitMap);
// form3.Image1.Picture.Bitmap.Assign(bm);
 Stream:=TMemoryStream.Create;
 BM.SaveToStream(stream);
// form3.Image321.Bitmap.SaveToStream(Stream);
 Stream.Position:=0;
 Connection.Connection.IOHandler.Write(Stream,Stream.Size,true);
 stream.Free ;
  BM.Free;
 BitMap.Free;
end;





procedure TForm3.Button1Click(Sender: TObject);
begin


IdTCPServer1.Active:=false;
//IdTCPServer1.IOHandler.
IdTCPServer1.Bindings.Items[0].IP:=edit1.Text;
 IdTCPServer1.Bindings.Items[0].Port:=strtoint(edit2.Text);
  IdTCPServer1.Active:=true;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
//BM:=TImage32.Create(form3);


Image321.Bitmap.LoadFromFile('C:\Users\vm\Pictures\1.bmp');
form3.Image321.Invalidate;;
form3.Image321.Bitmap.SaveToFile('C:\Users\vm\Pictures\aaaa.png');
exit;
BitMap := TBitMap.Create;
DesktopCanvas := TCanvas.Create;
DesktopCanvas.Handle := GetDC (Hwnd_Desktop);

BitMap.Width := Screen.Width;
BitMap.Height := Screen.Height;


//if not DrawIcon (BitMap.Canvas.Handle,Mouse.CursorPos.X,Mouse.CursorPos.Y,GetCursor) then
//begin
//
//end;

   BitMap.Canvas.CopyRect (BitMap.Canvas.ClipRect,DesktopCanvas,DesktopCanvas.ClipRect);

//form3.Image321.BitMap.Width:=Screen.Width;
//form3.Image321.BitMap.Height:=Screen.Height;
form3.Image321.BitMap.Canvas.CopyRect(form3.Image321.BitMap.Canvas.ClipRect,DesktopCanvas,DesktopCanvas.ClipRect);

//bm.Bitmap.Assign(BitMap);
//form3.Image321.BitMap.Assign(BitMap);
// form3.Image1.Picture.Bitmap.Assign(bm);
 Stream:=TMemoryStream.Create;
 form3.Image321.Bitmap.SaveToFile('C:\Users\vm\Pictures\aaaa.png');
 form3.Image321.Bitmap.SaveToStream(Stream);
 Stream.Position:=0;
// Connection.Connection.IOHandler.Write(Stream,Stream.Size,true);
 stream.Free ;
//  BM.Free;
// BitMap.Free;
end;




procedure TForm3.Button3Click(Sender: TObject);
var
  CurPosX, CurPoxY: Integer;
  MyCursor: TIcon;
  pIconInfo: TIconInfo;
begin
  MyCursor := TIcon.Create;
  try
     CursorInfo := GetCursorInfo2;
      MyCursor.Handle := CursorInfo.hCursor;
      GetIconInfo(CursorInfo.hCursor, IconInfo);

    GetIconInfo(MyCursor.Handle, pIconInfo);
    CurPosX := pIconInfo.xHotspot;
    CurPoxY := pIconInfo.yHotspot;

  finally
    MyCursor.ReleaseHandle;
    MyCursor.Free;
  end;
end;

procedure TForm3.IdTCPServer1Connect(AContext: TIdContext);
begin
caption:='connected';
end;

procedure TForm3.IdTCPServer1Execute(AContext: TIdContext);
var
a:string;
begin

    a:=AContext.Connection.IOHandler.ReadLn();
//    ShowMessage(a);
    if a ='jpg' then
begin
jpg (AContext);
end;
end;

end.
