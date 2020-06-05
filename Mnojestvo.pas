unit Mnojestvo;

interface

uses
  SysUtils, Windows;

type
  Mn=set of char;

function Pars_string(s: string): string;
function Mnoj(var M:Mn; s: string):byte;

implementation

function Mnoj(var M:Mn; s: string):byte;
var
  i: integer;
begin
  M:=[];
  result:=0;
  for i:=1 to Length(s) do
    if not(s[i] in M) then
      begin
        result:=result+1;
        M:=M+[s[i]];
      end;
end;

function Pars_string(s: string): string;

const
  R = ['.', ',', ':', ';', '!', '?', '-', ' ', #9, #10, #13];
var
  i, k: integer;
  count: Byte;
  max_wrd: string;
  res: string;


  M: Mn;

begin
  k:=0;
  count:=0;
  for i:=1 to Length(s) do
    begin
      if not(s[i] in R) then
        Inc(k);

      if (i=Length(s)) or (not(s[i] in R) and (s[i+1] in R)) then
        begin
          res:=Copy(s,i-k+1,k);
          If Mnoj(M, res)>count then
            begin
              count:=Mnoj(M, res);
              max_wrd:=res;
              result:=max_wrd;
            end
          else
            if Mnoj(M, res)=count then
              begin
                result:=res;
              end;
          k:=0;
        end;
    end;
end;

end.
 