unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TForm2 }

  TForm2 = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    HintEdit: TEdit;
    HintLabel: TLabel;
    HoursLabel: TLabel;
    TimeSelectedCaptionLabel: TLabel;
    TimeSelectedLabel: TLabel;
    MinutesLabel: TLabel;
    HoursList: TListBox;
    MinutesList: TListBox;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HoursListSelectionChange(Sender: TObject; User: boolean);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

//This procedure runs everytime the Form2 is shown, not on OnCreate that means everytime the user clicks the
// Add button on the main form the hour and minute in the listboxes updates, and the hintEdit clears.
procedure TForm2.FormShow(Sender: TObject);
var
  parts: TStringArray;
begin
  //These are for convenience (the current time is automatically selected in the listboxes, and the
  //HintEdit contents clears)

  //Empty the last inputted hint
  HintEdit.Text:= '';

  //Get time elements
  parts:= FormatDateTime('h|m', Time).Split('|');

  //Select current hour
  HoursList.Selected[StrToInt(parts[0])]:= True;

  //Select current minute + 1 (into the future)
  MinutesList.Selected[StrToInt(parts[1]) + 1]:= True;
end;

procedure TForm2.btnOKClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TForm2.btnCancelClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TForm2.HoursListSelectionChange(Sender: TObject; User: boolean);
begin
  TimeSelectedLabel.Caption:= HoursList.GetSelectedText + ':'
                    + MinutesList.GetSelectedText;
end;

end.

