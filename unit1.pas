unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation
procedure Oktaeder(kante:real;var inhalt:real);
begin
     inhalt:=2*sqrt(3)*kante*kante;
end;

function Dodekaeder(kante:real):real;
begin
     result:=3*(sqrt(25+10*sqrt(5)))*kante*kante;
end;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
begin
     Edit1.clear;
     Edit2.clear;
     Edit3.clear;
     Edit4.clear;
     Edit5.clear;
     ComboBox1.Items.clear;
     ComboBox1.Text:='Flächeneinhait wählen';
     with ComboBox1.Items do
     begin
       add('am');
       add('fm');
       add('pm');
       add('nm');
       add('µm');
       add('mm');
       add('cm');
       add('dm');
       add('m');
       add('dam');
       add('hm');
       add('km');
       add('Mm');
       add('Gm');
       add('Tm');
       add('Pm');
       add('Em');
     end;

     ComboBox2.Items.clear;
     ComboBox2.Text:='Genauigkeit auswählen';
     with ComboBox2.Items do
     begin
       for i:=0 to 20 do
       begin
         add(IntToStr(i));
       end;
     end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var kante,inhalt:real;
    i:integer;
    rv:string;
begin
     inhalt:=0;
     rv:='0.';
     try kante:=StrToFloat(Edit1.Text);
       if (kante > 0) then
       begin
         Oktaeder(kante, inhalt);
         if ComboBox2.Text = '0' then
         begin
           Edit2.Text:=FloatToStr(round(inhalt))+' '+ComboBox1.Text+'²';
           Edit3.Text:=FloatToStr(round(Dodekaeder(kante)))+' '+ComboBox1.Text+'²';
         end else
         begin
           for i:=1 to StrToInt(ComboBox2.Text) do
           begin
             rv:=rv+'0';
           end;
           Edit2.Text:=FormatFloat(rv, inhalt)+' '+ComboBox1.Text+' '+ComboBox1.Text+'²';
           Edit3.Text:=FormatFloat(rv, Dodekaeder(kante))+' '+ComboBox1.Text+'²';
         end;
       end;
     except
       showMessage('Gib einen gültigen Zahlenwert ein!');
     end;
     //ShowMessage(ComboBox1.Text);
end;

procedure TForm1.Button2Click(Sender: TObject);
var kante,inhalt:real;
    i:integer;
    rv:string;
begin
     kante:=0;
     inhalt:=0;

     repeat
       inhalt:=Dodekaeder(kante);
       kante:=kante+1;
     until
       inhalt>=100;

     if ComboBox2.Text = '0' then
     begin
       Edit4.Text:=FloatToStr(round(Dodekaeder(kante)))+' '+ComboBox1.Text;
     end else
     begin
       for i:=1 to StrToInt(ComboBox2.Text) do
       begin
         rv:=rv+'0';
       end;

       Edit4.Text:=FormatFloat(rv, Dodekaeder(kante))+ComboBox1.Text;
     end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var kante,inhalt,ri:real;
    i:integer;
    rv:string;
begin
     inhalt:=0;
     ri:=0;
     i:=0;
     try kante:=StrToFloat(Edit1.Text);
       if (kante > 0) then
       begin
         Oktaeder(kante,inhalt);
         ri:=inhalt;
         repeat
           Oktaeder(kante,inhalt);
           if ComboBox2.Text = '0' then
           begin
             kante:=kante+1;
           end else
           begin
             for i:=1 to StrToInt(ComboBox2.Text) do
             begin
               rv:=rv+'0';
             end;
           end;
         until
           inhalt>=ri*3;
         Edit5.Text:=FormatFloat(rv, inhalt);
       end else
       begin
         //
       end;
     except
       //
     end;

end;

end.

