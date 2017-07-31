object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 320
  ClientWidth = 587
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Image321: TImage32
    Left = 0
    Top = 0
    Width = 587
    Height = 320
    Align = alClient
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 3
  end
  object Button1: TButton
    Left = 135
    Top = 20
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 9
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '172.16.9.86'
  end
  object Edit2: TEdit
    Left = 8
    Top = 36
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '3389'
  end
  object IdTCPClient1: TIdTCPClient
    OnDisconnected = IdTCPClient1Disconnected
    OnConnected = IdTCPClient1Connected
    ConnectTimeout = 0
    Host = '172.16.9.86'
    IPVersion = Id_IPv4
    Port = 1111
    ReadTimeout = -1
    Left = 32
    Top = 32
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 184
    Top = 112
  end
end
