unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Forms, Controls, Dialogs, StdCtrls, ExtCtrls, Buttons, Unit2, Unit3, Classes;

type

  { TForm1 }

  TForm1 = class(TForm)
    AlarmsList: TListBox;
    AnalogPanel : TPanel;
    btnAdd: TBitBtn;
    btnRemove: TBitBtn;
    ClockChanger : TButton;
    Timer1: TTimer;
    TimeRightNowLabel: TLabel;
    TimeLabel: TLabel;
    DateLabel: TLabel;
    TrayIcon1: TTrayIcon;
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure ClockChangerClick(Sender : TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormWindowStateChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: Integer;
  TimeStamp: String;
  AlarmData: TStringArray;
begin
  //Show current time
  TimeLabel.Caption:= FormatDateTime('hh:nn:ss', Time);

  //Show current date
  DateLabel.Caption:= FormatDateTime('dddd, dd.mmmm.yyyy', Date);

  //Drawing the analog clock
  Form3.UpdateAnalogClock;

  //Get the current timestamp to compare with each alarm time
  //********This FormatDateTime contains only the  time part of the DateTime
  //(if we want to have dates too to check that further down the app date part must be provided also)
  TimeStamp:= FormatDateTime('hh:nn', Time);

  //Loop through the alarm list to see it is time to check this in case any previous alarm
  //triggered and some list item removed
  for i:= 0 to AlarmsList.Items.Count - 1 do begin

    //Check if the list item exists. We have to check this in case any previous alarm
    //triggered and some list item removed
    if i < AlarmsList.Items.Count then begin
      AlarmData:= AlarmsList.Items[i].Split('-');
      //ShowMessage(Trim(AlarmData[0]) + ' - ' + TimeStamp);

      if Trim(AlarmData[0]) = TimeStamp then begin

        //We remove the alarm, so that it does not ring again
        AlarmsList.Items.Delete(i);

        //We show a baloontip
        TrayIcon1.BalloonHint:= AlarmData[0] + ' --- ' + AlarmData[1];
        TrayIcon1.ShowBalloonHint;

        //We show the alarm message
        ShowMessage('ALARM!'#13#10#13#10
                  + 'Alarm time: ' + AlarmData[0] + #13#10
                  + 'Alarm hint: ' + AlarmData[1]);
      end;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //Load alarmlist from alarmlist.dat file
  AlarmsList.Items.LoadFromFile(Application.Location + DirectorySeparator + 'alarmlist.dat');

  //We run the OnTimer on OnFormCreate
  Timer1Timer(Sender);
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  //Save alarm list to file alarmlist.dat in the same directory as the executable
  AlarmsList.Items.SaveToFile(Application.Location + DirectorySeparator + 'alarmlist.dat');
end;

procedure TForm1.btnAddClick(Sender: TObject);
var
  AlarmText: String;
begin
  if Form2.ShowModal = mrOK then begin
    AlarmText:= Form2.HoursList.GetSelectedText + ':'
              + Form2.MinutesList.GetSelectedText + ' - '
              + Form2.HintEdit.Text;

    AlarmsList.Items.Add(Alarmtext);
  end;
end;

procedure TForm1.btnRemoveClick(Sender: TObject);
begin
  AlarmsList.DeleteSelected;
end;

procedure TForm1.ClockChangerClick(Sender : TObject);
begin
  if AnalogPanel.Visible then
  begin
    AnalogPanel.Visible := False;
    TimeRightNowLabel.Visible := True;
    TimeLabel.Visible := True;
    DateLabel.Visible := True
   end
   else
    begin
    AnalogPanel.Visible := True;
    TimeRightNowLabel.Visible := False;
    TimeLabel.Visible := False;
    DateLabel.Visible := False;
    end;
end;

procedure TForm1.FormWindowStateChange(Sender: TObject);
begin
  //If minimized, make form invisible
  Visible:= not (WindowState = wsMinimized);
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
  //Restore from minimized state when tray icon is clicked
  WindowState:= wsNormal;

  //Above command does not make the form automatically visible, so we need to make it visible
  Visible:= True;
end;

end.
