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
unit Logify.Adapter.Debug;

interface

uses
  System.SysUtils, Logify;

type
  /// <summary>
  ///   Adapter for the Logify framework
  /// </summary>
  TLogifyAdapterDebug = class(TLoggerAdapterHelper, ILoggerAdapter)
  protected
    procedure InternalLog(const AMessage, AClassName: string; AException: Exception; ALevel: TLogLevel); override;
    procedure InternalRaw(const AMessage: string); override;
    function InternalGetLogger(const AName: string = ''): TObject; override;
  end;

  /// <summary>
  ///   AdapterFactory class for the Logify framework
  /// </summary>
  TLogifyAdapterDebugFactory = class(TLoggerAdapterFactory)
  public
    class function CreateAdapterFactory(const AName: string = ''): TLogifyAdapterDebugFactory;
  public
    function CreateLoggerAdapter: ILoggerAdapter; override;
  end;

implementation

uses
  Winapi.Windows;

function TLogifyAdapterDebug.InternalGetLogger(const AName: string): TObject;
begin
  Result := Self;
end;

procedure TLogifyAdapterDebug.InternalLog(const AMessage, AClassName: string;
    AException: Exception; ALevel: TLogLevel);
begin
  OutputDebugString(PChar(FormatMsg(AMessage, AClassName, AException, ALevel)));
end;

procedure TLogifyAdapterDebug.InternalRaw(const AMessage: string);
begin
  OutputDebugString(PChar(AMessage));
end;

{ TLogifyAdapterDebugFactory }

class function TLogifyAdapterDebugFactory.CreateAdapterFactory(const AName: string): TLogifyAdapterDebugFactory;
begin
  Result := TLogifyAdapterDebugFactory.Create();
  Result.Name := AName;
end;

function TLogifyAdapterDebugFactory.CreateLoggerAdapter: ILoggerAdapter;
begin
  Result := TLogifyAdapterDebug.Create();
end;

end.
