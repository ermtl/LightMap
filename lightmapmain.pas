unit LightMapMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  MaskEdit, Grids, ExtCtrls, LazSerial, Registry,ervlib;

type

  { TMainForm }

  TMainForm = class(TForm)
    ExitBtn: TButton;
    LoadBtn: TButton;
    SerialSettingsBtn: TButton;
    OpenDialog: TOpenDialog;
    SaveBtn: TButton;
    SaveDialog: TSaveDialog;
    startButton: TButton;
    MapType: TComboBox;
    heatMap: TImage;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    Timer: TTimer;
    XEdit: TMaskEdit;
    MinValue: TMaskEdit;
    YEdit: TMaskEdit;
    Serial: TLazSerial;
    Console: TMemo;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Grid: TStringGrid;
    MaxValue: TMaskEdit;
    procedure ExitBtnClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SerialSettingsBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridClick(Sender: TObject);
    procedure GridMouseDown(Sender: TObject; {%H-}Button: TMouseButton;
      {%H-}Shift: TShiftState; X, Y: Integer);

    procedure GridResize(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure startButtonClick(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect;
      {%H-}aState: TGridDrawState);
    procedure MapTypeChange(Sender: TObject);
    procedure MaxValueChange(Sender: TObject);
    procedure MinValueChange(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure XEditChange(Sender: TObject);
    procedure YEditChange(Sender: TObject);
    procedure SerialRxData(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;
  xpos,ypos : integer;
  minVal,maxVal,mminVal,mmaxVal : real;
  done,TimTick:boolean;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.ExitBtnClick(Sender: TObject);
begin
  close;
end;

procedure TMainForm.Button2Click(Sender: TObject);
var
  reg: TRegistry;
  st: Tstrings;
  i: Integer;
begin
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey('hardware\devicemap\SERIALCOMM', False);
    st := TstringList.Create;
    try
      reg.GetValueNames(st);
      for i := 0 to st.Count - 1 do
        Console.Lines.Add(reg.Readstring(st.strings[i]));
    finally
      st.Free;
    end;
    reg.CloseKey;
  finally
    reg.Free;
  end;
end;

procedure TMainForm.SerialSettingsBtnClick(Sender: TObject);
begin
  Serial.ShowSetupDialog;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  done:=true;
end;

procedure TMainForm.GridClick(Sender: TObject);
begin

end;

procedure TMainForm.GridMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var p:tpoint;

begin
 p.x:=x;
 p.y:=y;
 p:=Grid.mousetocell(p);
 if not done and (p.x*p.y>0) then
  begin
   xpos:=p.x-1;
   ypos:=p.y-1;
   Grid.refresh;
  end;
end;



procedure TMainForm.GridResize(Sender: TObject);
var x,y:integer;

begin
 for x:=0 to value(XEdit.text) do
   for y:=0 to value(YEdit.text) do
    begin
      if (x=0) and (y>0) then Grid.Cells[x,y]:='     '+strs(y);
      if (y=0) and (x>0) then Grid.Cells[x,y]:='     '+strs(x);
    end;
  Grid.refresh;
end;

procedure TMainForm.LoadBtnClick(Sender: TObject);

var s,st:string;
    phase,x:integer;

begin
  if opendialog.execute then
    begin
     s:=stringfromfile (opendialog.filename);
     phase:=0;
     while s>'' do
      begin
        st:=before(#13,s);
        s:=after(#13,s);
        if (pos('//',st)=0) and (st>'') then
          begin
           if phase=0 then
             begin
              XEdit.text:=before(',',st);
              XEditChange(Sender);
              st:=after(',',st);
              YEdit.text:=before(',',st);
              YEditChange(Sender);
              st:=after(',',st);
              minValue.text:=before(',',st);
              st:=after(',',st);
              maxValue.text:=before(',',st);
              st:=after(',',st);
              MapType.itemIndex:=value(before(',',st));
              inc(phase);
             end
            else
             begin
              if phase<=value(YEdit.text) then
               for x:=1 to value(XEdit.text) do
                begin
                 Grid.Cells[x,phase]:=before(',',st);
                 st:=after(',',st);
                end;
              inc(phase);
             end;
          end;
      end;
     done:=true;
     MinValueChange(Sender);
     MaxValueChange(Sender);
    end;
end;

procedure TMainForm.SaveBtnClick(Sender: TObject);
var s:string;
    x,y:integer;

begin
 s:='// LightMap V1.00'#13+
    XEdit.text+','+YEdit.text+','+minValue.text+','+maxValue.text+','+strs(MapType.itemIndex)+#13;
 for y:=1 to value(YEdit.text) do
   for x:=1 to value(XEdit.text) do
     begin
       s:=s+Grid.Cells[x,y];
       if x<value(XEdit.text) then s:=s+',' else s:=s+#13;
     end;
  if SaveDialog.execute then StringToFile(SaveDialog.filename,s);
end;

procedure TMainForm.startButtonClick(Sender: TObject);

var x,y:integer;

begin
  Serial.open;
  xPos:=0;
  yPos:=0;
  minVal:=99999999999;
  mminVal:=minVal;
  maxVal:=0;
  mmaxVal:=maxVal;
  MinValue.Text:='';
  MaxValue.Text:='';
  done:=false;
  for x:=0 to value(XEdit.text) do
   for y:=0 to value(YEdit.text) do
    Grid.Cells[x,y]:='';
  GridResize(Sender);
end;

procedure TMainForm.GridDrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);

var ratio,vs:real;
    c:longint;

begin
  grid.canvas.Brush.Color:=clWhite ;
  if aCol*aRow=0 then grid.canvas.Brush.Color:=grid.FixedColor ;
  grid.canvas.Font.Color:=clBlack;
  if (aCol>0) and (aRow>0) then
   begin
    vs:=real_value(Grid.Cells[aCol,aRow]);
    if vs<>0 then
     begin
      ratio := 1 * (vs-minVal) / (maxVal+0.01 - minVal);
      c:=trunc(255.0*(1 - ratio));
      if c<0 then c:=0;
      if c>255 then c:=255;
      grid.canvas.Brush.Color:=heatMap.Canvas.Pixels[c,mapType.ItemIndex];

      if c<80 then grid.canvas.Font.Color:=clWhite;
      grid.canvas.FillRect(arect);
     end;
   end;
  if not done and (aRow=ypos+1) and (aCol=xpos+1) and (aCol*aRow>0) then
   begin
    if TimTick then grid.canvas.Brush.Color:=clWhite else grid.canvas.Brush.Color:=clGray;
    grid.canvas.FillRect(arect);
   end;
  grid.Canvas.TextOut(aRect.Left + 2, aRect.Top + 10, before('.',Grid.Cells[aCol,aRow]));
end;

procedure TMainForm.MapTypeChange(Sender: TObject);
begin
  Grid.refresh;
end;

procedure TMainForm.MaxValueChange(Sender: TObject);
begin
  if MaxValue.text='' then MaxValue.Text:=strs(trunc(mmaxVal));
  maxVal:=real_value(MaxValue.text);
  Grid.refresh;
end;

procedure TMainForm.MinValueChange(Sender: TObject);
begin
  if MinValue.text='' then MinValue.Text:=strs(trunc(mminVal));
  minVal:=real_value(MinValue.text);
  Grid.refresh;
end;

procedure TMainForm.TimerTimer(Sender: TObject);
begin
  TimTick:=not TimTick;
  if not done then Grid.refresh;
end;

procedure TMainForm.XEditChange(Sender: TObject);
begin
  Grid.colcount:=value(XEdit.text)+1;
  GridResize(Sender);
end;

procedure TMainForm.YEditChange(Sender: TObject);
begin
 Grid.rowcount:=value(YEdit.text)+1;
 GridResize(Sender);
end;


procedure TMainForm.SerialRxData(Sender: TObject);

var s:string;
    vs:real;

begin
  s:=Serial.ReadData;
  if s[length(s)] = #10 then s:=copy(s,1,length(s)-1);
  Console.Lines.Add(s);
  if (pos ('.',s) >0) and (pos ('Light',s) =0) and not done then
   begin
    vs:=real_value(s);
    if vs<minVal then minVal:=vs;
    if vs>MaxVal then maxVal:=vs;
    MinValue.Text:=strs(trunc(minVal));
    MaxValue.Text:=strs(trunc(maxVal));
    mminVal:=minVal;
    mmaxVal:=maxVal;
    Grid.Cells[xPos+1,yPos+1]:=real_strs(vs);
    Grid.refresh;
    inc(xPos);
    if xPos>=value(XEdit.text) then
     begin
      xPos:=0;
      inc (yPos);
      if yPos>=value(YEdit.text) then
        begin
         done:=true;
         yPos:=0;
         Grid.refresh;
        end;
     end;
   end;
end;


end.

