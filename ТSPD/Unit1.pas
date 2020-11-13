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
    Image1: TImage;
    BitBtn1: TBitBtn;
    RadioGroup1: TRadioGroup;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
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
  masotvet: array [1..40,1..15] of string;
  masprotvet : array [1..40,1..15] of integer;
  randzad : array [1..40] of Integer;
  randotvet : array [1..15] of Integer;
  kntvar : array [1..40] of Integer;
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
var i,kvar:integer;s:string;
begin
readln(f,kvar);
kvar:=kvar-1;
kntvar[nomer]:=kvar;
readln(f,s);
s:=anticezar(s);
masvopros[nomer]:=s;
for i:=1 to kvar do
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
var i,kvar:integer;s:string;
begin
readln(f,kvar);
kvar:=kvar-1;
kntvar[nomer]:=kvar;
readln(f,s);
masvopros[nomer]:=anticezar(s);
for i:=1 to kvar do
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
procedure show_task ();
var i:integer;
begin
  Form1.RadioGroup1.Items.Clear;
  Form1.BitBtn1.Show;
  Form1.Label2.show;
  Form1.Label2.Caption:=masvopros[randzad[it]];
  for i:=1 to kntvar[randzad[it]] do
  randotvet[i]:=i;
  random_shufle(randotvet,kntvar[randzad[it]]);
  if (mastypes[randzad[it]]<3) then
  begin
    for i:=1 to kntvar[randzad[it]] do
    Form1.RadioGroup1.Items.add(masotvet[randzad[it]][randotvet[i]]);
    Form1.RadioGroup1.Show;
  end
  else
  begin
    Form1.GroupBox1.Show;
    Form1.CheckBox1.Hide;
    Form1.CheckBox2.Hide;
    Form1.CheckBox3.Hide;
    Form1.CheckBox4.Hide;
    Form1.CheckBox5.Hide;
    Form1.CheckBox6.Hide;
    Form1.CheckBox7.Hide;
    Form1.CheckBox8.Hide;
    Form1.CheckBox9.Hide;
    Form1.CheckBox10.Hide;
    for i:=1 to kntvar[randzad[it]] do
    begin
    (Form1.FindComponent('CheckBox' + IntToStr(i)) AS TCheckBox).caption:=masotvet[randzad[it]][randotvet[i]];
    (Form1.FindComponent('CheckBox' + IntToStr(i)) AS TCheckBox).Show;
    end;
  end;
  if ((mastypes[randzad[it]]=2) or (mastypes[randzad[it]]=4)) then
  begin
    Form1.Image1.Picture.LoadFromFile('image'+IntToStr(randzad[it])+'.bmp');
    Form1.Image1.show;
  end;
    it:=it+1;
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
procedure hide_all ();
begin
Form1.BitBtn1.Hide;
Form1.Button1.Hide;
Form1.Edit1.Hide;
Form1.GroupBox1.Hide;
Form1.Image1.Hide;
Form1.Label1.Hide;
Form1.Label2.Hide;
Form1.RadioGroup1.Hide;
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
SetThreadLocale(1049);
  Label2.Hide;
  Image1.Hide;
  BitBtn1.Hide;
  RadioGroup1.Hide;
  GroupBox1.Hide;
  bal:=0;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var i:Integer;
begin
hide_all();
Label1.Show;
label1.Caption:='Відповідь зарахована';
end;

end.
