unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Label2: TLabel;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton1: TRadioButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Image1: TImage;
    BitBtn1: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  names:string;
  bal,n,it:integer;
  f:text;
  masvopros:array [1..40] of string;
  mastypes: array [1..40] of integer;
  masotvet: array [1..40,1..6] of string;
  masprotvet : array [1..40,1..6] of integer;
  randzad : array [1..40] of Integer;
  randotvet : array [1..7] of Integer;
implementation

uses Unit2;

{$R *.dfm}

function anticezar (s:String):String;
var res:String;i,k:integer;
begin
res:='';

for i:=1 to length(s) do
  begin
    if (s[i]=' ') then
    res:=res+' '
    else
    begin
    k:=ord(s[i]);
    k:=k-1;
    res:=res+chr(k);
    end;
  end;
anticezar:=res;
end;
procedure readingt1 (nomer:integer);
var i:integer;s:string;
begin
readln(f,s);
s:=anticezar(s);
masvopros[nomer]:=s;
for i:=1 to 4 do
  begin
  readln(f,s);
  s:=anticezar(s);
  masotvet[nomer][i]:=s;
  end;
readln (f,i);
masprotvet[nomer][1]:=1;
masprotvet[nomer][2]:=i-1;
end;

procedure readingt2 (nomer:integer);
var i:integer;s:string;
begin
readln(f,s);
masvopros[nomer]:=anticezar(s);
for i:=1 to 5 do
  begin
  readln(f,s);
  masotvet[nomer][i]:=anticezar(s);
  end;
readln (f,s);
masprotvet[nomer][1]:=(Length(s) div 2)+1;
for i:=1 to length(s) do
if (s[i] <> ' ') then
masprotvet[nomer][(i div 2) + 2]:=ord(s[i])-49;
end;
procedure random_shufle (var mas:array of Integer;len :integer);
var i,a,b,c:Integer;
begin
  Randomize;
  for i:=1 to len do
  begin
  a:=Random(len);
  b:=Random(len);
  c:=mas[a];
  mas[a]:=mas[b];
  mas[b]:=c;
  end;

end;
procedure fill_rand_zad ();
var i:Integer;
begin
  Randomize;
  for i:=1 to n do
      randzad[i]:=i;

  random_shufle(randzad,n);
end;
procedure show_task();
var i:integer;
begin
  if (mastypes[randzad[it]]<3) then
  begin
  for i:=1 to 4 do
  randotvet[i]:=i;
  random_shufle(randotvet,4);
  Form1.RadioButton1.Caption:=masotvet[randzad[it]][randotvet[1]];
  Form1.RadioButton2.Caption:=masotvet[randzad[it]][randotvet[2]];
  Form1.RadioButton3.Caption:=masotvet[randzad[it]][randotvet[3]];
  Form1.RadioButton4.Caption:=masotvet[randzad[it]][randotvet[4]];
  Form1.Label2.caption:=masvopros[randzad[it]];
  if (mastypes[randzad[it]]=2) then
    Form1.Image1.Picture.LoadFromFile('image'+IntToStr(randzad[it])+'.bmp');

  Form1.RadioButton1.show;
  Form1.RadioButton2.show;
  Form1.RadioButton3.show;
  Form1.RadioButton4.show;
  Form1.Label2.show;
  Form1.Image1.show;
  end;

   if (mastypes[randzad[it]]>2) then
  begin
  for i:=1 to 5 do
  randotvet[i]:=i;
  random_shufle(randotvet,5);
  Form1.CheckBox1.Caption:=masotvet[randzad[it]][randotvet[1]];
  Form1.CheckBox2.Caption:=masotvet[randzad[it]][randotvet[2]];
  Form1.CheckBox3.Caption:=masotvet[randzad[it]][randotvet[3]];
  Form1.CheckBox4.Caption:=masotvet[randzad[it]][randotvet[4]];
  Form1.CheckBox5.Caption:=masotvet[randzad[it]][randotvet[5]];
  Form1.Label2.caption:=masvopros[randzad[it]];
  if (mastypes[randzad[it]]=4) then
    Form1.Image1.Picture.LoadFromFile('image'+IntToStr(randzad[it])+'.bmp');

  Form1.CheckBox1.show;
  Form1.CheckBox2.show;
  Form1.CheckBox3.show;
  Form1.CheckBox4.show;
  Form1.CheckBox5.show;
  Form1.Label2.show;
  Form1.Image1.show;
  end;

end;
procedure TForm1.Button1Click(Sender: TObject);
var k,t:integer;
begin
  it:=1;
  names:=Edit1.Text;
  Button1.Hide;
  Edit1.Hide;
  Label1.Hide;
  AssignFile(f, 'ask and ans.txt');
  reset(f);
  readln(f,n);
  n:=n-1;
  for k:=1 to n do
  begin
  readln(f,t);
  t:=t-1;
  mastypes[k]:=t;
  if (t<3) then
  readingt1(k)
  else
  readingt2(k);
  end;
  CloseFile(f);
  fill_rand_zad();
  show_task();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
SetThreadLocale(1049);
  Label2.Hide;
  RadioButton1.Hide;
  RadioButton2.Hide;
  RadioButton3.Hide;
  RadioButton4.Hide;
  CheckBox1.Hide;
  CheckBox2.Hide;
  CheckBox3.Hide;
  CheckBox4.Hide;
  CheckBox5.Hide;
  Image1.Hide;
  BitBtn1.Hide;
  bal:=0;
end;

end.
