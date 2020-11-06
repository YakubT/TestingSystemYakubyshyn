program Shyfruvalnyk;

{$APPTYPE CONSOLE}

uses
  SysUtils,Windows;
var
fin,fout:text;
fins,fouts,s:	String;
function cezar (s:String):String;
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
    k:=k+1;
    res:=res+chr(k);
    end;
  end;
cezar:=res;
end;
begin
SetConsoleCP(1251);
SetConsoleOutputCP(1251);
writeln('Введіть шлях до файлу');
readln(fins);
writeln('Введіть місце збереження');
readln(fouts);
while (fins=fouts) do
begin
writeln('Це однакові файли, введіть друге місце збереження');
readln(fouts);
end;
AssignFile(fin,fins);
Reset(fin);
AssignFile(fout,fouts);
Rewrite(fout);
while not eof(fin) do begin
readln(fin,s);
writeln(fout,cezar(s));
end;
CloseFile(fin);
CloseFile (fout);
readln;
end.
