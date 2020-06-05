unit Task2;

{��� ��������� ����, ���������� �����, ����������� ����� ��� ����������� ���������.
������� ����, ������ ������ �������� ������ ��������� ��������� �� ����
��������������� ������ ��������� �����, � ������� ���������� ����� ��������� ����.}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ExtCtrls, Mnojestvo;

type
  TFormMain = class(TForm)
    MainMenu: TMainMenu;
    Filee: TMenuItem;
    New: TMenuItem;
    Open: TMenuItem;
    save: TMenuItem;
    Save_as: TMenuItem;
    exit: TMenuItem;
    programm: TMenuItem;
    mmoDATA: TMemo;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    spl: TSplitter;
    mmoRES: TMemo;
    N: TMenuItem;
    Process: TMenuItem;
    SaveRes: TMenuItem;
    ClearRes: TMenuItem;
    procedure NewClick(Sender: TObject);
    procedure OpenFileClick(Sender: TObject);
    procedure saveClick(Sender: TObject);
    procedure Save_asClick(Sender: TObject);
    procedure mmoDATAChange(Sender: TObject);
    procedure exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ProcessClick(Sender: TObject);
    procedure SaveResClick(Sender: TObject);
    procedure ClearResClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;
  FileName: string;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  OpenDialog.InitialDir:=ExtractFilePath(Application.ExeName);
  SaveDialog.InitialDir:=ExtractFilePath(Application.ExeName);
  Save.Enabled:=false;
  Save_As.Enabled:=false;
  SaveRes.Enabled:=false;
  ClearRes.Enabled:=false;
  mmoDATA.Clear;
  mmoRES.Clear;
end;

procedure TFormMain.NewClick(Sender: TObject);
var
  buttonSelected: integer;

begin
  save.Enabled:=false;
  Save_as.Enabled:=false;
  if mmoDATA.lines.count > 0 then
    begin
      buttonSelected:=MessageDlg('��������� ������������ ������?', mtCustom, mbYesNoCancel, 0);
      if buttonSelected = mrYes then
        begin
          if SaveDialog.Execute then
            begin
              mmoDATA.Enabled:=True;
              mmoDATA.Lines.Clear;
            end;
        end
      else
        if buttonSelected = mrNo then
          begin
            mmoDATA.Lines.Clear;
          end;
    end
  else
    begin
      mmoDATA.Enabled:= True;
    end;
end;


procedure TFormMain.OpenFileClick(Sender: TObject);
var
  buttonSelected: integer;

begin
  if mmoDATA.lines.count > 0 then
    begin
      buttonSelected:=MessageDlg('��������� ������������ ������?', mtCustom, mbYesNoCancel, 0);
      if buttonSelected = mrYes then
        begin
          Save_As.click;
          mmoDATA.Enabled:=True;
          mmoDATA.Lines.Clear;
        end
      else
        if buttonSelected = mrNo then
          begin
            mmoDATA.Lines.Clear;
          end
    end
  else
    begin
      mmoDATA.Enabled:= True;
    end;

  if OpenDialog.Execute then
    begin
      mmoDATA.Lines.Clear;
      FileName:=OpenDialog.FileName;
      mmoDATA.Lines.LoadFromFile(OpenDialog.FileName);
    end;
end;

procedure TFormMain.Save_asClick(Sender: TObject);

begin
  SaveDialog.FileName:=FileName;
  if SaveDialog.Execute then
    begin
      FileName:=SaveDialog.FileName;
      mmoDATA.Lines.SaveToFile(SaveDialog.FileName);
    end;
end;

procedure TFormMain.saveClick(Sender: TObject);
begin
     if FileName='' then
       Save_As.Click
     else
       mmoDATA.Lines.SaveToFile(FileName);
end;


procedure TFormMain.mmoDATAChange(Sender: TObject);
begin
  if mmoDATA.Lines.Count>0 then
    begin
      save.Enabled:=True;
      Save_as.Enabled:=True;
    end
  else
    begin
      Save.Enabled:=false;
      Save_As.Enabled:=false;
    end;
  mmoRES.Clear;
end;

procedure TFormMain.exitClick(Sender: TObject);
begin
  close
end;


procedure TFormMain.ProcessClick(Sender: TObject);
var
  i: Integer;

begin
  mmoRES.Clear;
  If mmoDATA.Lines.Count>0 then
    begin
      for i:=0 to mmoDATA.Lines.Count-1 do
        mmoRES.Lines.Add(Pars_string(mmoDATA.Lines.Strings[i]));
      ClearRes.Enabled:=True;
      SaveRes.Enabled:=True;
    end
  else
    ShowMessage('���� ������� ������');
end;

procedure TFormMain.SaveResClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    mmoRES.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TFormMain.ClearResClick(Sender: TObject);
begin
  if mmoRES.Lines.Count>0 then
    mmoRES.Clear
  else
    ShowMessage('���� ���������� ������')
end;

end.
