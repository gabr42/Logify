{******************************************************************************}
{                                                                              }
{  Logify: Metalogger for Delphi                                               }
{                                                                              }
{  Copyright (c) 2024 WiRL Team                                                }
{  https://github.com/delphi-blocks/Logify                                     }
{                                                                              }
{  Licensed under the MIT license                                              }
{                                                                              }
{******************************************************************************}
unit Test.Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  Logify,
  Logify.Adapter.Buffer,
  Logify.Adapter.Debug, Vcl.AppEvnts;

type
  TfrmMain = class(TForm)
    btnLogTrace: TButton;
    btnDebugLogger: TButton;
    memoLog: TMemo;
    btnBufferLogger: TButton;
    btnLogDebug: TButton;
    btnLogInfo: TButton;
    btnLogWarning: TButton;
    btnLogTraceEx: TButton;
    btnLogDebugEx: TButton;
    ApplicationEvents1: TApplicationEvents;
    btnMyLogger: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnBufferLoggerClick(Sender: TObject);
    procedure btnDebugLoggerClick(Sender: TObject);
    procedure btnLogDebugClick(Sender: TObject);
    procedure btnLogDebugExClick(Sender: TObject);
    procedure btnLogInfoClick(Sender: TObject);
    procedure btnLogTraceClick(Sender: TObject);
    procedure btnLogTraceExClick(Sender: TObject);
    procedure btnLogWarningClick(Sender: TObject);
    procedure btnMyLoggerClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    MyLogger: ILogger;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Test.Form.Second;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  MyLogger := TLoggerManager.GetLogger(Self.ClassType);
end;

procedure TfrmMain.btnBufferLoggerClick(Sender: TObject);
begin
  TLoggerAdapterRegistry.Instance.RegisterFactory(
    TLogifyAdapterBufferFactory.CreateAdapterFactory(memoLog.Lines));
end;

procedure TfrmMain.btnDebugLoggerClick(Sender: TObject);
begin
  TLoggerAdapterRegistry.Instance.RegisterFactory(
    TLogifyAdapterDebugFactory.CreateAdapterFactory);
end;

procedure TfrmMain.btnLogDebugClick(Sender: TObject);
begin
  Logger.LogDebug('Debugging something');
end;

procedure TfrmMain.btnLogDebugExClick(Sender: TObject);
begin
  try
    raise Exception.Create('Application Error Message');
  except
    on E: Exception do
      Logger.LogDebug(E, 'My Error Message');
  end;
end;

procedure TfrmMain.btnLogInfoClick(Sender: TObject);
begin
  Logger.LogInfo('Some Info...');
end;

procedure TfrmMain.btnLogTraceClick(Sender: TObject);
begin
  Logger.LogTrace('Tracing something');
end;

procedure TfrmMain.btnLogTraceExClick(Sender: TObject);
begin
  try
    raise Exception.Create('Application Error Message');
  except
    on E: Exception do
      Logger.LogTrace(E, 'My Error Message');
  end;
end;

procedure TfrmMain.btnLogWarningClick(Sender: TObject);
begin
  Logger.LogWarning('Something happened...');
end;

procedure TfrmMain.btnMyLoggerClick(Sender: TObject);
begin
  MyLogger.LogDebug('My Debug Message is: %s', ['Test Message']);

//  MyLogger.LogCritical('MyLogger Pointer: %d', [Integer(MyLogger)]);
//  Logger.LogCritical('Logger Pointer: %d', [Integer(Logger)]);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  frmSecond.Show;
end;

end.
