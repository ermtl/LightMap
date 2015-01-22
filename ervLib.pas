unit ervLib;

{
  This functions library is Copyright 1988-2014 by Eric Vinter and is
  distributed under the terms of the GNU General Public License.

  This program is free software; you can redistribute it
  and/or modify it under the terms of the GNU General Public
  License as published by the Free Software Foundation;
  either version 2 of the License, or any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program. If not, see < http://www.gnu.org/licenses/ >.

---

  This file contains various functions added since 1988.
  some are still useful, others are no more current, but
  left for compatibility reasons. The library was assembled
  from previous unreleased libraries (strg / files / htmlTool)
  and adapted for use with freePascal / Lazarus in 2014.

  Contact: erv at mailpeers dot net

}

{$mode objfpc}{$H+,O+}

interface

uses
  Classes, SysUtils;


type   AllChars = Set of char;
       FN_TYP   = String[64] ;  { Uniquement pour la compatibilité }
       PathStr  = String[255] ;
       FIB_TYPE =
         RECORD
           HANDLE,
           RECLEN,
           BUF_OFS,
           BUF_SIZE,
           BUF_PTR,
           BUF_END  : WORD ;
           FILENAME : Array[0..63] OF CHAR ;
         End ;
       DIRREC =      { 22 Octets / entrée du répertoire }
         RECORD
           Attr : Byte ;
           Time,
           Size : LONGINT ;
           Name : String[12] ;
         End ;

       mx_array = Array [0..65512] of byte;
       bytefile = record
  	          f : file;
                    cnt,sz,rdsz : Longint;
                    wr : boolean;
                    eofflg : shortint; { 0 => inconnu / 1 => ok  -1 => EOF }
                    buf : ^mx_array;
                  end ;
       STR1   = string[1] ;     STR2   = string[2] ;     STR3   = string[3] ;
       STR4   = string[4] ;     STR6   = string[6] ;     STR8   = string[8] ;
       STR10  = string[10] ;    STR12  = string[12] ;    STR16  = string[16] ;
       STR20  = string[20] ;    STR24  = string[24] ;    STR30  = string[30] ;
       STR32  = string[32] ;    STR40  = string[40] ;    STR50  = string[50] ;
       STR60  = string[60] ;    STR64  = string[64] ;    STR70  = string[70] ;
       STR80  = string[80] ;    STR90  = string[90] ;    STR92  = string[92] ;
       STR96  = string[96] ;    STR100 = string[100] ;   STR128 = string[128] ;
       STR160 = string[160] ;   STR180 = string[180] ;   STR200 = string[200] ;
       STR220 = string[220] ;   STR255 = string ;        STR132 = string[132] ;
       CHARSET = SET OF CHAR ;  BYTESET = SET OF BYTE ;


  Var  INT24   : BOOLEAN ;
       IOERROR : Byte ;
       CHARFILESIZE,
       {CHARFILESPACE,}
       DELTA_SIZE : LONGINT ;   { Utilis‚ par SAME_FILE }
       {FILETIME   : LONGINT ; }
       {FILEATTRIB : WORD ;}
       SeqFileName : PathStr;
       OK          : Boolean ;
       EOFN : Boolean ;
       SILENT : Boolean;
       FILL_CHAR  : Char;    EDIT_CHAR   : Str2;
       MY_SEP     : Char;    STRN_UNPACK : Boolean;
       PROGNAME   : string[12];

  CONST LASTPATH     : ^String = NIL ;
        MYPATH       : ^String = NIL ;
        MYEXTS       : ^String = NIL ;
        TREE_MASK    : String[12] = '*.' ;
        DirSize      = 2900 ;      TreeHeight = 16  ;      TreeSize   = 500 ;
        DOSATTRIB    = 10;
        AUTO_BAK     : Boolean = False ; { Utilis‚ par FILE_ERASE }
        SIZE_OFS     : LONGINT = 0 ;   { Utilis‚ par SAME_FILE }
        OLDINT05     : POINTER = NIL ;
        BakExt       : Str4='.bak';
        SeqInitExt   : Str4 = '.dat';
        SeqInitSign  : Char = '=';
        SeqOpenChar  : Char = '{';
        SeqCloseChar : Char = '}';
        FirstBack    : boolean = True; { sauvegarde le dernier / premier fichier du jour }
        MaxReplace   = 1000;  {prevent hanging with string replacements}



        Function NextLine (const s : string;var ps:integer):String;

        Function MaxVal (a,b:Integer):Integer;
        Function MinVal (a,b:Integer):Integer;
        Function RFILL ( S : string ; N : Integer ) : string ;
        Function LFILL ( S : string ; N : Integer ) : string ;
        Function RPT ( S : string ; N : Integer ) : string ;
        // Function RPL ( S1,S2 : string ; N : WORD ) : string ;
        Procedure Replace ( oldText,newText:string ; var S:string );
        Procedure ReplaceChar ( ol,nw:char ; var S:string );
        Function Before (const Src:string ;const S:string ) : string ;
        Function After (const Src:string ;const S:string ) : string ;
        Function QBefore (const Src:string ;const S:string ) : string ;
        Function QAfter (const Src:string ;const S:string ) : string ;
        Function uQuote (const S:string ) : string ;
        Function Strs (I:int64) : string ;
        Function REAL_STRS (R:REAL) : STR32 ;
        Function VALUE (S:string) : Int64 ;
        Function REAL_VALUE (S:string) : REAL ;
        Function HEXS (I:longint) : STR16 ;
        Function BINS (I:Integer) : STR32 ;
        Function LTRM ( const S:string ) : string ;
        Function RTRM ( const S:string ) : string ;
        //Function PACK (S:string;N:BYTE) : string ;
        //Function UNPACK (S:string;N:BYTE) : string ;
        Function PACK (S:string) : string ;
        Function UNPACK (S:string) : string ;
        Function PHRASE ( S:string ) : string ;
        Function First_Maj (const S:string ) : string ;
        Function MixedCase (const S:string ) : boolean;
        Function WORDEXISTS (W,S:string):Boolean ;
        Function WORDPOS (W,S:string) : Integer ;
        Function LEFTS (Var S:string ; B:Integer ) : string ;
        Function RIGHTS (Var S:string ; B:Integer ) : string ;
        Function MIDS (Var S:string ; B,C:Integer ) : string ;
        Function LOCASE (C:CHAR) : CHAR ;
        Function NORMALIZE ( S:string ) : string ;
        Function RETRIEVE ( S:string ; C:STR16 ) : string ;
        Function PARSE  ( Var S:string ; C:CHARSET ) : string ;
        Function REVERSEPARSE  ( Var S:string ; C:CHARSET ) : string ;
        Function CENTERTEXT ( S:string ; L : Integer ) : string ;
        Function WORDCOUNT (W,S:string) : Integer ;
        Function CharCount (c:char;const S:string) : Integer ;
        Function NEXTPOS ( W,S : string ; N : Integer ) : Integer ;
        Function NEXTWORDPOS ( W,S : string ; N : Integer ) : Integer ;
        Function ELIMINATETEXT ( S:string ; E1,E2:STR16 ; Var F:Integer ; IO:Boolean ) : string ;
        Function STRN (P:POINTER;N:WORD) : string ;    { La 1ø chaine a pour index 0 }
        Procedure NIVPAR (S:string;Var N:Integer) ;
        Function StrFmt (S:string;L:Byte;T:ShortInt) : string ;
        Function FP ( B : Boolean ; S:string ) : string ;
        Function DC ( S : string ) : string ;
        function genpass(const s:string):string;
        function rmshort (s:string;n:integer):String;


Function  SECTORSIZE  (D:Byte):LONGINT;{Donne la taille d'un secteur du disque}
{Function  CLUSTERSIZE (D:Byte):LONGINT;Donne la taille d'un cluster du disque}
Function  DISKNAME    (B:Byte):STR12 ; {Donne le nom du disque}
Function  EXISTE      ( N:PATHSTR )  : BOOLEAN ;
(*Function  SAME_FILE   ( N1,N2:PATHSTR ) : BOOLEAN ;*)
Function  DIR_EXISTE  ( N:PATHSTR )  : BOOLEAN ;
Function  EXEC_EXISTE ( Var N:PATHSTR  ; GBL:BOOLEAN )  : BOOLEAN ;
Function  Drive_Ready ( D:ShortInt ): BOOLEAN ;
{Procedure REC_SIZE    ( Var F;L:WORD ) ;}
(*Procedure CHAR_SEEK   ( Var F;L:LONGINT ) ;*)
Procedure Make_BAK    ( N:PATHSTR ) ;
Function  DatedFilename (N:PATHSTR;dt:TDateTime):PathStr ;
Procedure Make_DatedBAK (N:PATHSTR) ;
Procedure Cre_Text    ( N:PATHSTR ) ;
Procedure ADD_Text    ( Var T:TEXT;N:PATHSTR ) ;
Function  SEARCHFILE( S:PATHSTR ) : PATHSTR ;
Function  FILE_EXT    ( S:PATHSTR ; GBL:BOOLEAN ; EXTNS:String ) : PATHSTR ;
Function  SEARCHPROG  ( S:PATHSTR ; GBL:BOOLEAN ) : PATHSTR ;
{Procedure DOS_CALL    ( S:PATHSTR;B:BOOLEAN) ;}
Procedure DIRECTORY   ( Path:PATHSTR;ATT:WORD;Var N:WORD;Var V ) ;
Procedure TREE        ( DRV:ShortInt ; Var N:WORD ; Var V ) ;  { Non récursif }
Procedure FILE_ERASE  ( N:PATHSTR) ;
Procedure FILE_RENAME ( N1,N2:PATHSTR) ;
Procedure FILE_COPY   (src,dst:PATHSTR) ;
{Function  DISK_SPACE  ( N:PATHSTR;DPL:LONGINT;AFF:Boolean) : Boolean ;}
Function  FMT_NAME    ( N:PATHSTR ) : str16;
// Function  DelOldFiles (s:pathstr;jrs:word) : word;
Function  FILES_ERASE (N:PATHSTR) : word ; { efface des fichiers par lots }

  (*
  Function GetWindowsDir: string;
  Function GetWindowsSysDir: string;
  {$IFNDEF VER80}
  Function RecycleFile(sFileName: string): Boolean;
  {$endif}
  *)
  (* Fonctions FICHIER BYTE bufferisé *)

Procedure byteassign	(Var bfv;Var buffer;siz:word;fn:Pathstr); (* Eqv. de ASSIGN *)
Procedure byteflush	(Var bfv);  (* Ecrit le buffer sur le disque *)
Procedure bytereset	(Var bfv);  (* RAZ pointeur de fichier *)
Procedure byterewrite	(Var bfv);  (* RAZ fichier et pr‚paration … l'‚criture *)
Procedure byteclose	(Var bfv);  (* Ecrit le buffer et ferme le fichier *)
Function  byteof	(Var bfv):boolean ;   (* Eqv. de EOF *)
Procedure byteread	(Var bfv;Var b:byte); (* Lit un byte *)
Procedure bytewrite	(Var bfv;b:byte);     (* Ecrit un byte *)
Procedure ByteCharWrite	(Var bfv;c:char);     (* Lit un car.   *)
Procedure ByteCharRead	(Var bfv;Var c:char); (* Ecrit un car. *)
Procedure bytestrwrite	(Var bfv;s:string);    (* Ecrit une chaine de cars. *)

(* Fonctions fichiers d'init *)
Function  SetSeqFile       (n : PathStr): Boolean;
Function  readseq          (wrd:String) : String;
Function  readseqNum       (wrd:String) : Integer;
Function  readseqStrBlock  (wrd:String;Var V;StrSz,MxLines:Word) : Integer;
Procedure writeseq         (wrd:String;data:String) ;
Procedure writeseqNum      (wrd:String;data:Integer) ;
Procedure writeseqStrBlock (Wrd:String;Data:String;Var V;StrSz,Lines:Word);

Function  StringFromFile  (name:string):string;
Function  BStringFromFile (name:string):string;
Function  FStringFromFile (name:string):string;
Function  StringToFile (name,data:string):Boolean;
Function  LinesCount(const s : String):integer;
Function  StringFromStrings (var strg:Tstrings):string;
Function  StringToStrings (data:string;var strg:Tstrings):Boolean;
Function  ConvHTMail (s:String):String;
Function  UnQuote(const s:string):String;
Function  GetLine (var s:String):string;
// Procedure ConvRichTextToHtml(var s:String;var Ed:TRichedit);
Procedure ConvCharToRadical (var s:String);
Procedure ConvPCToHTML (var s:String;ConvertTag:Byte);
Procedure ConvHTMLtoPC (var s:String;ConvertTag:Byte);
Procedure ConvHTMLtoPCText (var s:String);
Procedure ConvPCToHTMLFilename (var s:String);
Procedure ConvHTMLToPCFilename (var s:String);
Procedure StripTags (tagStart,tagStop:String;var s:String);
Function  GetTag (tagStart,tagStop:String;var posi:integer;const s:String):String;
Procedure StripHTMLTags (var s:String);
Procedure StripHTMLComments (var s:String);
Procedure StripHTMLScript (var s:String);
Procedure ServerSideInclude (var s:String);
Function  GetHTMLTag(pos:Integer;const s:String):String;
Procedure HTMLBrowse (const s:String);
Function  posfrom(const Substr,s:String;n:integer):integer;
Procedure ReplaceString (srch:string;const rpl:String;var s : String);
Procedure CharFilter (rpl:string;var s:String;const st:AllChars);
function ValidEmail(email: string): boolean;
Function CountryCode(const s:String):String;
Function ExtractLinks(s:String):String;




implementation

{$IFDEF Windows}
uses Windows;
{$ENDIF}

const CCodesMax = 238;
 CCodes : Array [0..CCodesMax] of string =('','',
'AL=Albania','DZ=Algeria','AS=American Samoa','AD=Andorra','AO=Angola','AI=Anguilla','AQ=Antarctica',
'AG=Antigua and Barbuda','AR=Argentina','AM=Armenia','AW=Aruba','AU=Australia','AT=Austria','AZ=Azerbaidjan',
'BS=Bahamas','BH=Bahrain','BD=Banglades','BB=Barbados','BY=Belarus','BE=Belgium','BZ=Belize','BJ=Benin',
'BM=Bermuda','BO=Bolivia','BA=Bosnia-Herzegovina','BW=Botswana','BV=Bouvet Island','BR=Brazil',
'IO=British Indian O. Terr.','BN=Brunei Darussalam','BG=Bulgaria','BF=Burkina Faso','BI=Burundi',
'BT=Buthan','KH=Cambodia','CM=Cameroon','CA=Canada','CV=Cape Verde','KY=Cayman Islands',
'CF=Central African Rep.','TD=Chad','CL=Chile','CN=China','CX=Christmas Island','CC=Cocos (Keeling) Isl.',
'CO=Colombia','KM=Comoros','CG=Congo','CK=Cook Islands','CR=Costa Rica','HR=Croatia','CU=Cuba','CY=Cyprus',
'CZ=Czech Republic','CS=Czechoslovakia','DK=Denmark','DJ=Djibouti','DM=Dominica','DO=Dominican Republic',
'TP=East Timor','EC=Ecuador','EG=Egypt','SV=El Salvador','GQ=Equatorial Guinea','EE=Estonia','ET=Ethiopia',
'FK=Falkland Isl.(Malvinas)','FO=Faroe Islands','FJ=Fiji','FI=Finland','FR=France','FX=France (European Ter.)',
'TF=French Southern Terr.','GA=Gabon','GM=Gambia','GE=Georgia','DE=Germany','GH=Ghana','GI=Gibraltar','GR=Greece',
'GL=Greenland','GD=Grenada','GP=Guadeloupe (Fr.)','GU=Guam (US)','GT=Guatemala','GN=Guinea','GW=Guinea Bissau',
'GY=Guyana','GF=Guyana (Fr.)','HT=Haiti','HM=Heard &amp; McDonald Isl.','HN=Honduras','HK=Hong Kong','HU=Hungary',
'IS=Iceland','IN=India','ID=Indonesia','IR=Iran','IQ=Iraq','IE=Ireland','IL=Israel','IT=Italy','CI=Ivory Coast',
'JM=Jamaica','JP=Japan','JO=Jordan','KZ=Kazakhstan','KE=Kenya','KG=Kyrgyzstan','KI=Kiribati','KP=Korea (North)',
'KR=Korea (South)','KW=Kuwait','LA=Laos','LV=Latvia','LB=Lebanon','LS=Lesotho','LR=Liberia','LY=Libya',
'LI=Liechtenstein','LT=Lithuania','LU=Luxembourg','MO=Macau','MG=Madagascar','MW=Malawi','MY=Malaysia',
'MV=Maldives','ML=Mali','MT=Malta','MH=Marshall Islands','MQ=Martinique (Fr.)','MR=Mauritania','MU=Mauritius',
'MX=Mexico','FM=Micronesia','MD=Moldavia','MC=Monaco','MN=Mongolia','MS=Montserrat','MA=Morocco','MZ=Mozambique',
'MM=Myanmar','NA=Namibia','NR=Nauru','NP=Nepal','AN=Netherland Antilles','NL=Netherlands','NT=Neutral Zone',
'NC=New Caledonia (Fr.)','NZ=New Zealand','NI=Nicaragua','NE=Niger','NG=Nigeria','NU=Niue','NF=Norfolk Island',
'MP=Northern Mariana Isl.','NO=Norway','OM=Oman','PK=Pakistan','PW=Palau','PA=Panama','PG=Papua New','PY=Paraguay',
'PE=Peru','PH=Philippines','PN=Pitcairn','PL=Poland','PF=Polynesia (Fr.)','PT=Portugal','PR=Puerto Rico (US)',
'QA=Qatar','RE=Reunion (Fr.)','RO=Romania','RU=Russian Federation','RW=Rwanda','LC=Saint Lucia','WS=Samoa',
'SM=San Marino','SA=Saudi Arabia','SN=Senegal','SC=Seychelles','SL=Sierra Leone','SG=Singapore','SK=Slovak Republic',
'SI=Slovenia','SB=Solomon Islands','SO=Somalia','ZA=South Africa','SU=Soviet Union','ES=Spain','LK=Sri Lanka',
'SH=St. Helena','PM=St. Pierre &amp; Miquelon','ST=St. Tome and Principe','KN=St.Kitts Nevis Anguilla',
'VC=St.Vincent &amp; Grenadines','SD=Sudan','SR=Suriname','SJ=Svalbard &amp; Jan Mayen Is','SZ=Swaziland',
'SE=Sweden','CH=Switzerland','SY=Syria','TJ=Tadjikistan','TW=Taiwan','TZ=Tanzania','TH=Thailand','TG=Togo',
'TK=Tokelau','TO=Tonga','TT=Trinidad &amp; Tobago','TN=Tunisia','TR=Turkey','TM=Turkmenistan',
'TC=Turks &amp; Caicos Islands','TV=Tuvalu','UM=US Minor outlying Isl.','UG=Uganda','UA=Ukraine',
'AE=United Arab Emirates','GB=United Kingdom','US=United States','UY=Uruguay','UZ=Uzbekistan','VU=Vanuatu',
'VA=Vatican City State','VE=Venezuela','VN=Vietnam','VG=Virgin Islands (British)','VI=Virgin Islands (US)',
'WF=Wallis &amp; Futuna Islands ','EH=Western Sahara','YE=Yemen','YU=Yugoslavia','ZR=Zaire','ZM=Zambia',
'ZW=Zimbabwe');

 Var   STRN_PTR1 : POINTER;
       STRN_PTR2 : POINTER;
       STRN_NUM  : WORD;

 function genpass(const s:string):string;

const alpha='abcdefghkmnpqrstuvwxyz';
      numer='0123456789';
      all=alpha+numer;

var f,g,cnt: word;
    c,c2:char;

Begin
 randomize;
 c:=#0;
 c2:=#0;
 Result:=s;
 g:=random(charcount(',',Result)+1);
 for f := 1 to g do Result:=after(',',Result);
 Result:=before(',',Result);
 for f := 1 to length(result) do
  begin
   repeat
    case result[f] of
     'a' : c:=alpha[random(length(alpha))+1];
     'n' : c:=numer[random(length(numer))+1];
     'x' : c:=all[random(length(all)+1)];
     else
      runerror(99);
     end;
    if (c='0') and (pos(c2,numer)=0) then c:=c2; // Les chiffres ne commencent pas par '0'
    cnt:=0;
    for g:=1 to f-1 do if Result[f]=c then inc(cnt);
    if cnt>1 then c:=c2;
    until c<>c2;
   c2:=c;
   Result[f]:=c;
  end;
end;




Function CharCount (c:char;const S:string) : Integer ;

var i:integer;

Begin
 Result:=0;
 for i:=1 to length(s) do if s[i]=c then inc(Result);
End;

Procedure ReplaceChar ( ol,nw:char ; var S:string );

var i:integer;

Begin
 for i:=1 to length(s) do if s[i]=ol then s[i]:=nw;
End;


// Reads a line from a string (accept either windows or Linux formatted strings)

Function NextLine (const s : string;var ps:integer):String;

var i : integer;

Begin
 if ps=0 then ps:=1;
 result:='';
 if ps<1 then exit;
 if ps>=length(s) then
  begin
   ps:=-ps;
   exit;
  end;
 i:=ps;
 while (s[i]<>#13) and (i<length(s)) do inc(i);
 Result:=copy(s,ps,i-ps);
 if (s[i]=#13) and (i<length(s)) then if s[i+1]=#10 then inc(i);
 ps:=i+1;
End;


{-----------------------------------------------------------------------------}

Function MaxVal (a,b:Integer):Integer;
Begin
 if a>b then Result:=a else Result:=b;
End;

Function MinVal (a,b:Integer):Integer;
Begin
 if a<b then Result:=a else Result:=b;
End;


{-----------------------------------------------------------------------------}

Function RPT ( S : string ; N : Integer ) : string ;

Var F   : Integer ;
    R   : string ;

begin
  if N=0 then
    R := ''
   else
    if length(S)=1 then
      R := STRINGOFChar (S[1],N)
     else
      begin
        R  := '' ;
        for F := 1 to N do if length(R)+length(S)<256 then R := R+S ;
      end ;
  Result := R ;
end ;

{-----------------------------------------------------------------------------}

Function RFILL ( S : string ; N : Integer ) : string ;

begin
  if length(s)<n then
    result := s+StringOfChar(FILL_CHAR,n-length(s))
   else
    result := s;
end ;

{-----------------------------------------------------------------------------}

Function LFILL ( S : string ; N : Integer ) : string ;

begin
  if length(s)<n then
    result := StringOfChar(FILL_CHAR,n-length(s))+s
   else
    result := s;
end ;

{-----------------------------------------------------------------------------}

Function CENTERTEXT ( S:string ; L : Integer ) : string ;

begin
  if length(S)<L then
    begin
      S := StringOfChar(FILL_CHAR,(L-length(S)) shr 1 )+S ;
      if length(s)<L then
        result := s+StringOfChar(FILL_CHAR,L-length(s))
       else
        result := copy (s,1,l);
    end
   else
    result := copy (s,1,l);
end ;

{----------------------------------------------------------------------------}

Function StrFmt (S:string;L:Byte;T:ShortInt) : string ;

begin
  if length(S)<L then
    CASE T OF
      -1 : if length(s)<L then s := s+StringOfChar(FILL_CHAR,L-length(s));    { RFILL }
       0 : begin
            S := StringOfChar(FILL_CHAR,(L-length(S)) shr 1 )+S ;
            if length(s)<L then s := s+StringOfChar(FILL_CHAR,L-length(s));   { Center }
           end ;
       1 : if length(s)<L then s := StringOfChar(FILL_CHAR,L-length(s))+s;    { LFILL }
     end ;
  result := copy (s,1,l);
end ;

{-----------------------------------------------------------------------------}

{
Function RPL ( S1,S2 : string ; N : WORD ) : string ;
(*
Var F   : WORD ;
    LS1 : BYTE absolute S1 ;
    LS2 : BYTE absolute S2 ;
    P1,P2 : POINTER ;
*)
begin
(*  does not work with Delphi
  if Length(S1)>0 then
    begin
      F := Length(S1)+N ;
      if F>255 then
        begin
          dec (Length(S1),F-255) ;
          F := 255 ;
        end ;
      if F>Length(S2) then Length(S2) := F ;
      P1 := @S1 ;
      P2 := @S2 ;
      inc (LONGINT(P1)) ;
      inc (LONGINT(P2),N) ;
      MOVE (P1^,P2^,Length(S1)) ;
    end ;
  RPL := S2 ;*)
end ;
}

{-----------------------------------------------------------------------------}

Procedure Replace ( oldText,newText:string ; var S:string );

Var F,cnt : integer ;

begin
  cnt:=MaxReplace;
  F := POS (oldText,S) ;
  while F<>0 do
   begin
    delete (s,f,length(oldText));
    insert(newText,s,f);
    F := POS (oldText,S) ;
    if cnt=0 then f:=0;
    dec (cnt);
   end;
end ;

{-----------------------------------------------------------------------------}

Function Before (const Src:string ;const S:string ) : string ;

Var F : integer ;

begin
  F := POS (Src,S) ;
  if F=0 then
    Before := S
   else
    Before := COPY(S,1,F-1) ;
end ;

{-----------------------------------------------------------------------------}

Function After (const Src:string ;const S:string ) : string ;

Var F : integer ;

begin
  F := POS (Src,S) ;
  if F=0 then
    After := ''
   else
    After := COPY(S,F+length(src),length(s)) ;
end ;

{-----------------------------------------------------------------------------}

Function QBefore (const Src:string ;const S:string ) : string ;

Var F,g : integer ;
    sc,c,Qchar:char;
    inquote:boolean;

begin
  f:=0;
  if length(src)>0 then
   begin
    inquote:=False;
    Qchar:=#0;
    g:=1;
    sc:=src[1];
    while (length(s)>=g) and (f=0) do
     begin
      c:=s[g];
      if inquote then
        begin
         if c=qchar then inquote:=false;
        end
       else
        if (c='''') or (c='"') then
          begin
           Qchar:=c;
           inquote:=true;
          end
         else
          begin
           if c=sc then if copy(s,g,length(src))=src then f:=g;
          end;
      inc(g);
     end;
   end;
(**  F := POS (Src,S) ; **)
  if F=0 then
    QBefore := S
   else
    QBefore := COPY(S,1,F-1) ;
end ;

{-----------------------------------------------------------------------------}

Function QAfter (const Src:string ;const S:string ) : string ;

Var F,g : integer ;
    sc,c,Qchar:char;
    inquote:boolean;

begin
  f:=0;
  if length(src)>0 then
   begin
    inquote:=False;
    Qchar:=#0;
    g:=1;
    sc:=src[1];
    while (length(s)>=g) and (f=0) do
     begin
      c:=s[g];
      if inquote then
        begin
         if c=qchar then inquote:=false;
        end
       else
        if (c='''') or (c='"') then
          begin
           Qchar:=c;
           inquote:=true;
          end
         else
          begin
           if c=sc then if copy(s,g,length(src))=src then f:=g;
          end;
      inc(g);
     end;
   end;
(**  F := POS (Src,S) ; **)
  if F=0 then
    QAfter := ''
   else
    QAfter := COPY(S,F+length(src),length(s)) ;
end ;

{-----------------------------------------------------------------------------}

Function uQuote (const S:string ) : string ;

Var g : integer ;
    c,Qchar:char;
    inquote:boolean;

begin
  inquote:=False;
  Qchar:=#0;
  g:=1;
  result :=s;
  while length(result)>=g do
     begin
      c:=result[g];
      if inquote then
        begin
         if c=qchar then
          begin
           if copy(result,g,2)<>qchar+qchar then inquote:=false else inc(g);
           delete (result,g,1);
           dec(g);
          end
        end
       else
        if (c='''') or (c='"') then
          begin
           Qchar:=c;
           inquote:=true;
           delete (result,g,1);
           dec(g);
          end;
      inc(g);
     end;
end ;

{-----------------------------------------------------------------------------}

Function Strs (I:Int64) : string ;

Var X : string[16] ;

begin
  STR (I,X) ;
  Strs := X ;
end ;

{-----------------------------------------------------------------------------}

Function REAL_STRS (R:REAL) : STR32 ;

Var X : string ;
//    vX : byte absolute x;

begin
  STR (R:20:10,X) ;
  X := LTRM (X) ;
  WHILE X[length(X)] ='0' do {dec (vX)} delete(x,length(x),1) ;
  if X[length(X)] ='.' then {dec (vX)} delete(x,length(x),1) ;
  REAL_STRS := X ;
end ;

{-----------------------------------------------------------------------------}

Function VALUE (S:string) : Int64 ;

Var F   :int64;
    B   : Integer ;
    C   : CHAR ;

begin
  if s='' then
   begin
    result:=0;
    exit;
   end;
  OK  := TRUE ;
  if S[1]=' ' then
    begin
      F := 2 ;
      WHILE S[F]=' ' do inc (F) ;
      DELETE (S,1,F-1) ;
    end ;
  VAL (S,F,B) ;
  if B<>0 then
    begin
      if (B=2) AND (S[1]<'0') then
        begin
          DELETE (S,1,1) ;
          B := 1 ;
         end ;
      OK  := FALSE ;
      WHILE (B=1) AND (length(S)>0) do
        begin
          F := 2 ;
          C := S[F] ;
          WHILE ((C<'$') OR (C>'F') OR not (C IN ['$','+','-','0'..'9','A'..'F']))
            AND (F<=length(S)) do
              begin
                inc (F) ;
                C := S[F] ;
              end ;
          if F>1 then DELETE (S,1,F-1) ;
          VAL (S,F,B) ;
          if (B=2) AND (C<'0') then
            begin
              DELETE (S,1,1) ;
              VAL (S,F,B) ;
            end ;
        end ;
      if B>1 then
        begin
          SetLength (s,B-1) ;
          VAL (S,F,B) ;
        end ;
      if (B>0) OR (length(S)=0) then F := 0 else OK := TRUE ;
    end ;
  result := F ;
end ;

{-----------------------------------------------------------------------------}

Function REAL_VALUE (S:string) : REAL ;

Var F,B :         Integer ;
    R   : REAL ;

begin
  OK  := FALSE ;
  if s='' then
   begin
    result:=0;
    exit;
   end;
  F := POS (',',S) ;
  WHILE F>0 do
    begin
      S[F] := '.' ;
      F := POS (',',S) ;
    end ;
  F := 1 ;
  WHILE not (S[F] IN ['+','-','.','0'..'9']) AND (F<=length(S)) do inc (F) ;
  if F>1 then DELETE (S,1,F-1) ;
  VAL (S,R,B) ;
  if B = 1 then
    if length(S)>1 then
      REPEAT
        S := COPY(S,2,255) ;
        VAL (S,R,B) ;
       UNTIL (B<>1) OR (length(S)<2)
     else
      begin
        B := 0 ;
        R := 0 ;
      end ;
  if B IN [2..255] then
    begin
      S := COPY(S,1,B-1) ;
      VAL (S,R,B) ;
    end ;
  if B <= 0 then OK := TRUE ;
  REAL_VALUE := R ;
end ;

{-----------------------------------------------------------------------------}

Function HEXS (I:longint) : STR16 ;

CONST HX : ARRAY [0..15] OF CHAR = '0123456789ABCDEF' ;

Var S : STR16 ;

begin
  S[0] := #0 ;
  REPEAT
    S := HX[I AND $F]+S ;
    I := I shr 4 ;
   UNTIL I = 0 ;
  HEXS := '$'+S ;
end ;

{-----------------------------------------------------------------------------}

Function BINS (I:Integer) : STR32 ;

Var S : STR32 ;
    C : CHAR ;

begin
  S := '' ;
  REPEAT
    C := '0' ;
    if ODD(I) then C := '1' ;
    S := C+S ;
    I := I shr 1 ;
   UNTIL I = 0 ;
  BINS := '%'+S ;
end ;

{-----------------------------------------------------------------------------}

Function LEFTS (Var S:string ; B:Integer ) : string ;

begin
if (B >= length(S)) OR (length(S)=0)
  then
  LEFTS := S
 else
  if B <= 0 then LEFTS := '' else LEFTS := COPY (S,1,B) ;
end ;

{-----------------------------------------------------------------------------}

Function RIGHTS (Var S:string ; B:Integer ) : string ;

begin
  if (B >= length(S)) OR (length(S)=0) then
    RIGHTS := S
   else
    if B <= 0 then RIGHTS := '' else RIGHTS := COPY (S,length(S)-B+1,255) ;
end ;

{-----------------------------------------------------------------------------}

Function MIDS (Var S:string ; B,C:Integer ) : string ;

begin
  MIDS := COPY (S,B,C) ;
end ;

{-----------------------------------------------------------------------------}

Function LTRM ( const S:string ) : string ;

Var F  :         Integer ;

begin
  F := 1 ;
  WHILE (F<=length(S)) AND (S[F]=' ') do inc(F) ;
  if F > 1 then LTRM := COPY (S,F,255) else LTRM := S ;
end ;

{-----------------------------------------------------------------------------}

Function RTRM ( const S:string ) : string ;

Var M : Integer ;

begin
  M := length(S) ;
  WHILE (m>0) and (S[m] = ' ') do dec(m) ;
  RTRM := copy (S,1,m) ;
end ;

{-----------------------------------------------------------------------------}

Function LOCASE (C:CHAR) : CHAR ;

Var B : BYTE absolute C ;

begin
  if C IN ['A'..'Z'] then B := B OR $20 ;
  LOCASE := C ;
end ;

{-----------------------------------------------------------------------------}

{ $L STR.OBJ }

{Function UPPERCASE ( Var S:string ) : string ; External ;

Var F  :         Integer ;
    LS : BYTE absolute S ;

begin
  for F := 1 to LS do UPPERCASE[F] := UPCASE(S[F]) ;
  UPPERCASE[0] := S[0] ;
end ;
}
{-----------------------------------------------------------------------------}


Function NORMALIZE ( S:string ) : string ;

Var F  : Integer ;

begin
  S := LTRM (S) ;
  S := RTRM (S) ;
  S := UPPERCASE (S) ;
  if length(S)>2 then F := POS('  ',S) else F := 0 ;
  WHILE F>0 do
    begin
      S := COPY(S,1,F)+COPY(S,F+2,255) ;
      if length(S)>2 then F := POS('  ',S) else F := 0 ;
    end ;
  NORMALIZE := S ;
end ;

{-----------------------------------------------------------------------------}

Function RETRIEVE ( S:string ; C:STR16 ) : string ;

Var F  :         Integer ;
    CH :            CHAR ;

begin
  WHILE (length(S)>0) AND (length(c)>0) do
    begin
      CH := C[1] ;
      C := COPY (C,2,255) ;
      F := POS  (CH,S) ;
      WHILE F > 0 do
        begin
          if F=1 then S := COPY(S,2,255) else S := COPY(S,1,F-1)+COPY(S,F+1,255) ;
          if length(S)>0 then F := POS(CH,S) else F := 0 ;
        end ;
    end ;
  RETRIEVE := S ;
end ;

{-----------------------------------------------------------------------------}

Function First_Maj (const S:string ) : string ;

Var F  : Integer ;

begin
  Result := LTRM (S) ;
  Result := RTRM (Result) ;
  for F := 2 to length(Result) do if Result[F] IN ['A' .. 'Z'] then Result[F] := char(ord(Result[f]) + $20) ;
  if length(Result)>0 then Result[1] := UPCASE(Result[1]) ;
end ;

{-----------------------------------------------------------------------------}

Function MixedCase (const S:string ) : boolean;

Var F  : Integer ;
    b : boolean;

begin
  Result:=False;
  b:=False;
  for F := 1 to length(s) do
   begin
    if s[F] IN ['A' .. 'Z'] then b:=True ;
    if s[F] IN ['a' .. 'z'] then Result:=True ;
   end;
  Result:= Result and b;
end ;

{-----------------------------------------------------------------------------}

Function PHRASE ( S:string ) : string ;


begin
  S := FIRST_MAJ (S) ;
  if S[length(S)]<>'.' then S := S+'.' ;
  PHRASE := S ;
end ;

{-----------------------------------------------------------------------------}

Function PARSE  ( Var S:string ; C:CHARSET ) : string ;

Var F,LVL :         Integer ;
    QUOTE : Boolean ;

begin
  WHILE (length(S)>0) AND (S[1] IN C) do S := COPY (S,2,255) ;
  if length(S)>0 then
    begin
      F := 1 ;
      LVL := 0 ;
      QUOTE := FALSE ;
      WHILE (F<=length(S)) AND (not (S[F] IN C) OR (LVL>0)) do
        begin
          if S[F] IN ['(','{','[',')','}',']','"'] then
            if S[F] = '"' then
              begin
                QUOTE := not QUOTE ;
                if QUOTE then LVL := 1 else LVL := 0 ;
              end
             else
              if not QUOTE then
                begin
                  if S[F] IN ['(','{','['] then inc(LVL) ;
                  if S[F] IN [')','}',']'] then dec(LVL) ;
                end ;
          inc(F) ;
        end ;
      PARSE := COPY(S,1,F-1) ;
      S     := COPY(S,F,255) ;
    end
   else
    PARSE := '' ;
end ;

{-----------------------------------------------------------------------------}

Function REVERSEPARSE  ( Var S:string ; C:CHARSET ) : string ;

Var F  :         Integer ;

begin
  WHILE (length(S)>0) AND (S[length(S)] IN C) do s := copy (s,1,length(s)-1);
  if length(S)>0 then
    begin
      F := length(S) ;
      WHILE (F>1) AND not (S[F] IN C) do dec(F) ;
      REVERSEPARSE := COPY(S,F+1,255) ;
      S     := COPY(S,1,F) ;
    end
   else
    REVERSEPARSE := '' ;
end ;

{-----------------------------------------------------------------------------}

Function WORDCOUNT (W,S:string) : Integer ;

Var C,F :         Integer ;
    ST  :     SET OF CHAR ;

begin
  C := 0 ;
  if (length(w)>0) AND (length(S)>=length(w)) then
    begin
      F := POS (W,S) ;
      if F>0 then
        begin
          ST := [#0..#255] ;
          for C := 1 to length(w) do
            begin
              CASE W[C] OF
                'A'..'Z','a'..'z' : ST := ST-['_','A'..'Z','a'..'z'] ;
                '0'..'9'          : ST := ST-['0'..'9'] ;
               end ;
            end ;
          C := 0 ;
          if ST <> [#0..#255] then
            WHILE length(S)>0 do if PARSE (S,ST) = W then inc(C)
           else
            WHILE F>0 do
              begin
                inc(C) ;
                if length(S)>F+length(w)-1 then
                  begin
                    S := COPY (S,F+length(w),255) ;
                    F := POS (W,S) ;
                  end
                 else
                  F := 0 ;
              end ;
        end ;
    end ;
  WORDCOUNT := C ;
end ;

{-----------------------------------------------------------------------------}

Function WORDPOS (W,S:string) : Integer ;

Var C,F :         Integer ;
    B   :         Boolean ;
    ST  :     SET OF CHAR ;

begin
  f := 0;
  B := FALSE ;
  if (length(w)>0) AND (length(S)>=length(w)) then
    begin
      F := POS(W,S) ;
      if F>0 then
        begin
          ST := [#0..#255] ;
          for C := 1 to length(w) do
            begin
              CASE W[C] OF
                'A'..'Z','a'..'z' : ST := ST-['_','A'..'Z','a'..'z'] ;
                '0'..'9'          : ST := ST-['0'..'9'] ;
               end ;
            end ;
          if ST <> [#0..#255] then
            begin
              F := length(S) ;
              WHILE (length(S)>0) AND not B do
                if PARSE (S,ST)=W then
                  begin
                    F := F-length(S)-length(w)+1 ;
                    B := TRUE ;
                  end ;
            end
           else
            B := TRUE ;
        end ;
    end ;
  if B then WORDPOS:=F else WORDPOS:=0 ;
end ;

{-----------------------------------------------------------------------------}

Function WORDEXISTS (W,S:string) : Boolean ;

begin
  WORDEXISTS := ( WORDPOS(W,S) > 0 ) ;
end ;

{-----------------------------------------------------------------------------}

Function NEXTPOS ( W,S : string ; N : Integer ) : Integer ;

Var F,G : Integer ;

begin
  for F := 2 to N do
    begin
      G := POS(W,S) ;
      if G>0 then S[G] := #0 ;
    end ;
  NEXTPOS := POS (W,S) ;
end ;

{-----------------------------------------------------------------------------}

Function NEXTWORDPOS ( W,S : string ; N : Integer ) : Integer ;

Var F,G : Integer ;

begin
  for F := 2 to N do
    begin
      G := WORDPOS(W,S) ;
      if G>0 then S[G] := #0 ;
    end ;
  NEXTWORDPOS := WORDPOS (W,S) ;
end ;

{-----------------------------------------------------------------------------}

Function ELIMINATETEXT ( S:string ; E1,E2:STR16 ; Var F:Integer ; IO:Boolean ) : string ;

Var G,M,N :                   Integer ;
    T     : ARRAY [1..255] OF Integer ;
    RES   :                    string ;

begin
RES := '' ;
if S > '' then
  begin
  for G := 1 to length(S) do T[G] := F ;
  if E1 = E2 then
    begin
    M := WORDPOS(E1,S) ;
    WHILE M>0 do
      begin
      for G := M to M+length(E1)-1 do T[G] := -16384 ;
      F := (F+1) AND 1 ;
      for G := M+length(E1)-1 to length(S) do if T[G]>=0 then T[G] := (T[G]+1) AND 1 ;
      N     := WORDPOS (E1,COPY(S,M+1,255)) ;
      if N>0 then M := M+N else M := 0 ;
      end ;
    end
   else
    begin
    M := WORDPOS(E1,S) ;
    WHILE M>0 do
      begin
      for G := M to M+length(E1)-1 do T[G] := -16384 ;
      inc (F) ;
      for G := M+length(E1)-1 to length(S) do inc (T[G]) ;
      N     := WORDPOS (E1,COPY(S,M+1,255)) ;
      if N>0 then M := M+N else M := 0 ;
      end ;
    M := WORDPOS(E2,S) ;
    WHILE M>0 do
      begin
      for G := M to M+length(E2)-1 do T[G] := -16384 ;
      F := F-1 ;
      for G := M+length(E2)-1 to length(S) do T[G] := T[G]-1 ;
      N     := WORDPOS (E2,COPY(S,M+1,255)) ;
      if N>0 then M := M+N else M := 0 ;
      end ;
    end ;
  for G := 1 to length(S) do
    if (IO AND(T[G]=0)) OR (not IO AND (T[G]>0) ) then
      RES:=RES+S[G] ;
  end ;
ELIMINATETEXT := RES ;
if F<0 then
  begin
  F  :=     0 ;
  OK := FALSE ;
  end
 else
  OK := TRUE ;
end ;

{-----------------------------------------------------------------------------}

//Function PACK (S:string;N:BYTE) : string ;
Function PACK (S:string) : string ;

Var S1      : string ;
    A,B,PRS : WORD ;
    C       : CHAR ;
    DO_IT   : Boolean ;

//CONST PAK : SET OF CHAR =
//  [#0..#17,#19,#20,' ','"','*','+',',','-','.','/','0'..'9','a'..'z'] ;

begin
  S1 := S ;
  PRS := 0 ;
  A := 1 ;
  WHILE A<=length(S) do
    begin
      if S[A]<#21 then
        begin
          INSERT (#20,S,A) ;
          inc (A) ;
        end ;
      inc (A) ;
    end ;
  A := 2 ;
  C := S[1] ;
  B := 0 ;
  WHILE A<=length(S) do
    if S[A]=C then
      begin
        inc (A) ;
        inc (B) ;
      end
     else
      begin
        DO_IT := B<>0 ;
        CASE B OF
          1,2    : if C=' ' then
                     S[A-B-1] := CHAR(B)
                    else
                     DO_IT := FALSE ;
          3..7   : begin
                     if C=' ' then
                       S[A-B-1] := CHAR(B)
                      else
                       begin
                         S[A-B] := CHAR(B+8) ;
                         dec (B) ;
                       end ;
                   end ;
          8..255 : begin
                     if C=' ' then
                       begin
                         S[A-B-1] := #0 ;
                         S[A-B] := CHAR (B-1) ;
                       end
                      else
                       begin
                         S[A-B] := #9 ;
                         S[A-B+1] := CHAR (B-2) ;
                         dec (B) ;
                       end ;
                     dec (B) ;
                   end ;
         end ;
        if DO_IT then
          begin
            DELETE (S,A-B,B) ;
            inc (PRS,B) ;
            dec (A,B) ;
          end ;
        B := 0 ;
        C := S[A] ;
        inc (A) ;
      end ;
  (*
  F := 1 ;
  S2 := S ;
  WHILE F<=length(S)-12 do if S[F] IN PAK then
    begin
      G := F ;
      WHILE (G<=length(S)) AND (S[G] IN PAK) do inc (G) ;
      if G>F+11 then
        begin
          H := G-F ;
          if H AND $3<>0 then H := H+4 ;
          H := H SHL 2 ;
          INSERT (#18+CHAR(H),S,F) ;
          inc (F,2) ;
          inc (G,2) ;
        end ;
      F := G ;
    end ;
  if length(S2)<=length(S) then S := S2 ;
  *)
  if PRS<2 then
    if S1[1]=#1 then
      PACK := #1#20+S1
     else
      PACK := S1
   else
    PACK := #1+S ;
end ;

{-----------------------------------------------------------------------------}

//Function UNPACK (S:string;N:BYTE) : string ;
Function UNPACK (S:string) : string ;

Var F,G : WORD ;
    C   : CHAR ;
    ST  : Array [0..255] OF Byte absolute S ;

(*CONST UPK : Array [0..63] OF CHAR =
  (#0,#1,#2,#3,#4,#5,#6,#7,#8,#9,#10,#11,#12,#13,#14,#15,#16,#17,#19,#20,
   ' ','"','*','+',',','-','.','/','0','1','2','3','4','5','6','7','8','9',
   'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r',
   's','t','u','v','w','x','y','z') ;
  *)
begin
  (*
  F := POS (#18,S) ;
  WHILE F>0 do
    begin
      G := ORD(S[F+1]) ;
      DELETE (S,F,2) ;
      for H := 1 to G shr 2 do
        begin
          C1 := UPK[ORD(S[F])AND $3F] ;
          C2 := UPK[ORD(S[F]) shr 6+ORD(S[F+1]) AND $F] ;
          C3 := UPK[ORD(S[F+1]) shr 4+ORD(S[F+2]) AND $3] ;
          C4 := UPK[ORD(S[F+2]) shr 2] ;
          S[F] := C1 ;
          S[F+1] := C2 ;
          S[F+2] := C3 ;
          INSERT (C4,S,F+3) ;
          inc (F,4) ;
        end ;
      G := G AND $3 ;
      if G<>0 then DELETE (S,F-G,G) ;
      F := POS (#18,S) ;
    end ;
  *)
  F := 1 ;
  REPEAT inc (F) UNTIL (ST[F]<21) OR (F>length(S)) ;
  WHILE F <= length(S) do
    begin
      if ST[F]<21 then
        CASE ST[F] OF
          0,9  :  begin
                    G := ST[F+1] ;
                    C := ' ' ;
                    if ST[F]=9 then C := S[F-1] ;
                    S[F] := C ;
                    S[F+1] := C ;
                    INSERT (RPT(C,G),S,F+2) ;
                    inc (F,G+1) ;
                  end ;
          1..8,
          10..17: begin
                    G := ST[F] ;
                    C := ' ' ;
                    if ST[F]>=10 then
                      begin
                        C := S[F-1] ;
                        G := G-9 ;
                      end ;
                    S[F] := C ;
                    INSERT (RPT(C,G),S,F+1) ;
                    inc (F,G) ;
                  end ;
          20    : DELETE (S,F,1) ;
         end ;
      REPEAT inc (F) UNTIL (ST[F]<21) OR (F>length(S)) ;
    end ;
  UNPACK := COPY (S,2,255) ;
end ;

{-----------------------------------------------------------------------------}

Function STRN (P:POINTER;N:WORD) : string ;

TYPE AR = Array[-2..29999] OF WORD ;

Var PT   : ^string absolute P ;
    PT1  : ^Byte absolute P ;
    PT2  : ^AR absolute P ;
    OFST : WORD absolute P ; { Offset du pointeur }
    s_n  : WORD ;

begin
  if PT2^[-2] = $FFFF then
    begin
      EOFN := (N>=PT2^[-1]) ;
      inc (OFST,PT2^[N]) ;
    end
   else
    begin
      if (STRN_PTR1=P) AND (STRN_NUM<=N) then
        P := STRN_PTR2
       else
        begin
          STRN_NUM := 0 ;
          STRN_PTR1 := P ;
        end ;
      for s_n := STRN_NUM+1 to N do inc (OFST,PT1^+1) ;
      STRN_NUM:=N;
      STRN_PTR2 := P ;
      EOFN := PT^='<EOF>' ;
    end ;
  if (PT^[1]=#1) AND STRN_UNPACK then
//   STRN := UNPACK (PT^,0)
   STRN := UNPACK (PT^)
   else
    STRN := PT^ ;
  if EOFN then STRN := '' ;
end ;


{-----------------------------------------------------------------------------}

Procedure NIVPAR (S:string;Var N:Integer) ;

Var F : Integer ;

begin
  OK := TRUE ;
  for F := 1 to length(S) do
    begin
      if S[F]='(' then inc (N) ;
      if S[F]=')' then dec (N) ;
      if N<0 then OK := FALSE ;
    end ;
end ;

{-----------------------------------------------------------------------------}
{
 FP provides an easy way to modify texts according to singular/plural,
 gender or any boolean conditions.

  Ex1 :
  MyText := strs(N)+' machine'+FP (N>1,'s') ;
  Ex2 :
  if Nargs<>4 then
   Msg :='There is too '+FP(Nargs>4,'many#few')+' arguments.');
}

Function FP ( B : Boolean ; S:string ) : string ;

begin
  if POS (MY_SEP,S)>0 then
    if B then
      S := Before (MY_SEP,S)
     else
      S := After (MY_SEP,S)
   else
    if not B then S := '' ;
  FP := S ;
end ;

{-----------------------------------------------------------------------------}

Function DC ( S : string ) : string ;

Var F,G  : Integer ;
    SEED : Integer absolute S ;

begin
  dc:='';
  F := HI (SEED) xor $A5 ;
  for G := 2 to length(S) do
    begin
      F := F+(ORD(S[G]) xor (F shr 1)) ;
      DC[G-1] := CHAR(F) ;
    end ;
  Setlength (s,length(S)-1);
end ;

{-----------------------------------------------------------------------------}

function rmshort (s:string;n:integer):String;

var st:String;

Begin
 Result:='';
 while s<>'' do
  begin
   st:= before(' ',s);
   s:= after(' ',s);
   if length(st)>n then
    begin
     if Result='' then Result:=st else Result:= Result+' '+st;
    end;
  end;
End;

{-----------------------------------------------------------------------------}


 {-----------------------------------------------------------------------------}

 Function SECTORSIZE (D:Byte) : LONGINT ;

 Begin
   if d<250 then SECTORSIZE := 512 ;
 End ;

 {-----------------------------------------------------------------------------}

 Function DISKNAME (B:Byte) : STR12 ;

 Var S : STR12 ;
     F : INTEGER ;
     DR : TSEARCHREC ;

 Begin
   S := '' ;
   IF B>0 then S := CHAR(B+64)+':\' ;
   IF FINDFIRST (S+'*.*',$08,DR)=0 then
     Begin
       S := DR.NAME ;
       F := POS ('.',S) ;
       IF F>0 then DELETE (S,F,1) ;
     End
    Else
     S := '' ;
   DISKNAME := S ;
 End ;

 {-----------------------------------------------------------------------------}


 Function EXISTE ( N:PATHSTR ) : BOOLEAN ;

 Var F : FILE OF CHAR ;
     B : BOOLEAN ;
     FM : BYTE ;

 BEGIN
   FM := FILEMODE ;
   FILEMODE := 0 ;    { Read only }
   IF N>'' then
     Begin
       AssignFile (F,N) ;
       {$I-}
       RESET (F) ;
       {$I+}
       IOERROR := IORESULT ;
     End
    Else
     IOERROR := 2 ;         { File not found }
   B := (IOERROR=0) ;
   INT24 := (IOERROR>127) ;
   IF B then
     Begin
       N := ExpandFileName(N) ;
       CHARFILESIZE := FILESIZE (F) ;
       {CHARFILESPACE := CHARFILESIZE OR (CLUSTERSIZE(ORD(N[1])-64)-1) + 1 ;}
       {FILETIME := FileGetDate (F) ;}
       CLOSE(F) ;
       {GETFATTR (F,FILEATTRIB) ;}
     End ;
   FILEMODE := FM ;
   EXISTE := B ;
 END ;

 {-----------------------------------------------------------------------------}
 (*
 Function  SAME_FILE   ( N1,N2:PATHSTR ) : BOOLEAN ;

 Var SZ,TIM : LONGINT ;
     ATT    : WORD ;

 Begin
   OK := EXISTE (N1) ;
   SZ := CHARFILESIZE ;
   TIM := FILETIME ;
   ATT := FILEATTRIB ;
   IF OK then OK := EXISTE (N2) ;
   DELTA_SIZE := SZ-CHARFILESIZE-SIZE_OFS ;
   SAME_FILE := OK AND (DELTA_SIZE=0) AND (TIM=FILETIME) AND (ATT=FILEATTRIB) ;
 End ;
 *)

 {-----------------------------------------------------------------------------}

 Function DIR_EXISTE ( N:PATHSTR ) : BOOLEAN ;

 Var S  : PATHSTR ;
 //    LN : BYTE ABSOLUTE N ;

 Begin
   N := ExtractFilePath (N) ;
   s:='';
   GETDIR (0,S) ;
   {$I-}
   CHDIR (N) ;
   {$I+}
   IOERROR := IORESULT ;
   DIR_EXISTE := (IOERROR=0) ;
   INT24 := (IOERROR>127) ;
   IF N<>S then CHDIR (S) ;
 End ;


 {-----------------------------------------------------------------------------}

 Function  Drive_Ready ( D:ShortInt ) : BOOLEAN ;

 Var S : PATHSTR ;

 Begin
   S[1] := CHAR (D+64) ;
   IF D=0 then GETDIR (0,S) ;
   IF D<0 then
     EXISTE ('PRN')
    Else
     EXISTE (S[1]+':\$_$_$_$_.$$$') ;
   Drive_Ready := NOT INT24 AND (IOERROR<>3) ;
 End ;

 {-----------------------------------------------------------------------------}
 (*
 Procedure REC_SIZE (Var F;L:WORD) ;

 Var FIB : FILEREC ABSOLUTE F ;

 Begin
   FIB.RECSIZE := L ;
 End ;
 *)
 {-----------------------------------------------------------------------------}
 (*
 Procedure CHAR_SEEK (Var F;L:LONGINT) ;

 Var FIB : FILEREC ABSOLUTE F ;
     F0  : FILE OF CHAR ABSOLUTE F ;
     SZ  : WORD ;

 Begin
   WITH FIB DO
     Begin
       SZ := RECSIZE ;
       RECSIZE := 1 ;
       SEEK (F0,L) ;
       RECSIZE := SZ ;
     End ;
 End ;
 *)
 {-----------------------------------------------------------------------------}

 Procedure Make_BAK (N:PATHSTR) ;

 Var F0 : FILE ;
     N1 : PATHSTR ;

 Begin
   IF (POS (BakExt,N)>0) OR NOT EXISTE (N) then EXIT ;
   N1 := BEFORE ('.',N)+BakExt ;
   IF EXISTE (N1) then
     Begin
       AssignFile (F0,N1) ;
       ERASE (F0) ;
     End ;
   IF NOT EXISTE (N1) then
     Begin
       AssignFile (F0,N) ;
       RENAME (F0,N1) ;
     End ;
 End ;


 {-----------------------------------------------------------------------------}

 Function DatedFilename (N:PATHSTR;dt:TDateTime):PathStr ;

 Var y,m,d:Word;
     st : String;

 Begin
   DecodeDate(dt,y,m,d);
   st:=strs(y)+lfill(strs(m),2)+lfill(strs(d),2);
   st:=copy(st,3,20);
   ReplaceString(' ','0',st);
   Result := BEFORE ('.',N)+'-'+st+'.'+after ('.',N) ;
 End;

 {-----------------------------------------------------------------------------}

 Procedure Make_DatedBAK (N:PATHSTR) ;

 Var F0 : FILE ;
     N1 : PATHSTR ;

 Begin
 (*   DecodeDate(now.Date,y,m,d);
    st:=strs(y)+lfill(strs(m),2)+lfill(strs(d),2);
    st:=copy(st,3,999);
    ReplaceString(' ','0',st);
    EdFichier.Text:=st;
    st:=EdTitre.Text;
    st:=before(' ',ltrm(st));
    ConvCharToRadical(st);
    EdFichier.Text:=EdFichier.Text+'-'+st+'.html';
 *)
   If (POS (BakExt,N)>0) OR NOT EXISTE (N) or (pos('.',n)=0) then EXIT ;
   N1 := DatedFilename(BEFORE ('.',n)+BakExt,Now) ;
   If EXISTE (N1) and not FirstBack then
     Begin
       AssignFile (F0,N1) ;
       ERASE (F0) ;
     End ;
   If NOT EXISTE (N1) then
     Begin
       AssignFile (F0,N) ;
       RENAME (F0,N1) ;
     End ;
 End ;


 {-----------------------------------------------------------------------------}

 Procedure FILE_ERASE (N:PATHSTR) ;

 Var F : FILE ;

 Begin
   If AUTO_BAK then Make_BAK (N) ;
   AssignFile(f,N);
     {$I-}
   Reset(f);
     {$I+}
   IOERROR := IOResult ;
   OK := IOERROR = 0 ;
   If OK then
     begin
       Close(f);
       Erase(f);
     end ;
 End ;

 {-----------------------------------------------------------------------------}

 Procedure FILE_COPY (src,dst:PATHSTR) ;

   { Simple copy program w/NO error checking }
 Var FromF, ToF: file;
 {$ifdef VER80}
     NumRead, NumWritten: word;
 {$else}
     NumRead, NumWritten: integer;
 {$endif}
     buf: array[1..2048] of Char;

 begin
   NumRead:=0;
   NumWritten:=0;
   buf[1]:=#0;
   src:=ExpandFileName (src);
   dst:=ExpandFileName (dst);
   if not existe (src) or (src=dst) then exit;
   AssignFile(FromF, src);
   Reset(FromF, 1);
   {getftime (FromF,tim);}
   AssignFile(ToF, dst);
   Rewrite(ToF, 1);
   {  WriteLn('Copying ', FileSize(FromF),' bytes...');  }
   repeat
     BlockRead(FromF,buf,SizeOf(buf),NumRead);
     BlockWrite(ToF,buf,NumRead,NumWritten);
    until (NumRead = 0) or (NumWritten <> NumRead);
   Close(FromF);
   {setftime(ToF,tim);}
   Close(ToF);
 End ;

 {-----------------------------------------------------------------------------}

 Procedure FILE_RENAME (N1,N2:PATHSTR) ;

 Var F : FILE ;

 Begin
   OK := EXISTE (N1) ;
   If OK then
     Begin
       AssignFile (F,N1) ;
       RENAME (F,N2) ;
     End ;
 End ;

 {-----------------------------------------------------------------------------}

 Procedure Cre_Text (N:PATHSTR) ;

 Var F0 : FILE OF CHAR ;

 Begin
   OK := (N>'') ;
   If (N='') OR EXISTE (N) then EXIT ;
   AssignFile (F0,N) ;
   {$I-}
   REWRITE (F0) ;
   {$I+}
   IOERROR := IORESULT ;
   OK := (IOERROR=0) ;
   If OK then CLOSE (F0) ;
 End ;

 {-----------------------------------------------------------------------------}

 Procedure ADD_Text ( Var T:TEXT;N:PATHSTR ) ;

 Begin
   If EXISTE (N) then
     Begin
       AssignFile (T,N) ;
       APPEND (T) ;
     End
    Else
     Begin
       AssignFile (T,N) ;
       REWRITE (T) ;
     End ;
 End ;

 {-----------------------------------------------------------------------------}

 Function SEARCHFILE (S:PATHSTR) : PATHSTR ;

 Var P : PATHSTR ;
     B,B1 : Boolean ;

 Begin
   B := EXISTE (S) ;
   If NOT B then
     Begin
       P := ExtractFileName (S) ;
       B := (P=S) ;
       S := P ;
       If B OR NOT EXISTE (S) then
         If (LASTPATH<>NIL) AND EXISTE (LASTPATH^+'\'+P) then
           S := LASTPATH^+'\'+P
          Else
           If EXISTE ('\'+P) then
             S := '\'+P
            Else
             Begin
               S := '' ;
               If MYPATH<>NIL then S := FileSearch(P,MYPATH^) ;
               {If S='' then S := FileSearch(P,GETENV('PATH')) ;  DELPHI??}
               If S>'' then
                 Begin
                   If S[2]<>':' then
                     Begin
                       GETDIR (0,P) ;
                       CHDIR (ExtractFilePath(S)) ;
                       S := ExpandFileName(S) ;
                       CHDIR (P) ;
                     End ;
                   If LASTPATH <> NIL then LASTPATH^ := ExtractFilePath (S) ;
                 End ;
             End ;
       B := False ;
     End ;
   If (S>'') AND (S[2]<>':') then
     Begin
       GETDIR (0,P) ;
       B1 := P<>ExtractFilePath(S) ;
       If B1 then CHDIR (ExtractFilePath(S)) ;
       S := ExpandFileName(S) ;
       If B1 then CHDIR (P) ;
     End ;
   If NOT (B OR EXISTE (S)) then S := '' ;
   SEARCHFILE := S ;
 End ;

 {-----------------------------------------------------------------------------}

 Function  FILE_EXT    ( S:PATHSTR ; GBL:BOOLEAN ; EXTNS:String ) : PATHSTR ;

 Var S1 : PATHSTR ;
     F : WORD ;

 Begin
   If POS ('.',S)>0 then
     Begin
       S1 := BEFORE ('.',S) ;
       OK := EXISTE (S) ;
       If NOT OK AND GBL then
         Begin
           S := SEARCHFILE (S) ;
           OK := S>'' ;
         End ;
       If NOT OK then S := S1 ;
     End ;
   If POS ('.',S)=0 then
     Begin
       If (EXTNS = '') AND (MYEXTS<>NIL) then EXTNS := MYEXTS^ ;
       OK := False ;
       WHILE NOT OK AND (EXTNS[1]='.') AND (EXTNS>'') DO
         Begin
           F := POS (';',EXTNS) ;
           If F=0 then F := POS (',',EXTNS) ;
           If F=0 then
             F := LENGTH(EXTNS)
            Else
             DEC (F) ;
           If F>4 then F := 4 ;
           S1 := S+COPY (EXTNS,1,F) ;
           EXTNS := COPY (EXTNS,F+2,255) ;
           OK := EXISTE (S1) ;
           If NOT OK AND GBL then
             Begin
               S1 := SEARCHFILE (S1) ;
               OK := S1>'' ;
             End ;
           If OK then S := S1 ;
         End ;
     End ;
   If NOT OK then S := '' ;
   FILE_EXT := S ;
 End ;


 {-----------------------------------------------------------------------------}

 Function  SEARCHPROG  ( S:PATHSTR ; GBL:BOOLEAN ) : PATHSTR ;

 Begin
   SEARCHPROG := FILE_EXT (S,GBL,'.EXE;.COM;.BAT') ;
 End ;

 {-----------------------------------------------------------------------------}

 Function  EXEC_EXISTE ( Var N:PATHSTR  ; GBL:BOOLEAN )  : BOOLEAN ;

 Var B : BOOLEAN ;

 Begin
   N := SEARCHPROG (N,GBL) ;
   B := N>'' ;
   {If POS ('.BAT',N)>0 then N := GETENV('COMSPEC')+' /C '+N ;  DELPHI!}
   EXEC_EXISTE := B ;
 End ;

 {-----------------------------------------------------------------------------}
 (*
 Procedure DOS_CALL (S:PATHSTR;B:BOOLEAN) ;

 Var BB,EX,NOPATH : BOOLEAN ;
     P     : PATHSTR ;
     ARGS  : String[80] ;
     SC    : ^SCREENTYP ;
     L_SC  : ^L_SCREENTYP ;
     C     : CHAR ;
     D_S   : ^SCREENTYP ABSOLUTE DOS_SCREEN ;
     L_D_S : ^L_SCREENTYP ABSOLUTE DOS_SCREEN ;
     PT    : POINTER ;
     matt,mmode  : byte;

 Begin
   matt:=attrib;
   attrib := DOSATTRIB;
   ARGS := BEFORE (' ',S) ;
   EX := POS ('.EXE',ARGS) + POS ('.COM',ARGS) > 0 ;
   NOPATH := (POS ('\',ARGS) + POS (':',ARGS)=0) ;
   If EX then
     Begin
       ARGS := AFTER (' ',S) ;
       EX := EXEC_EXISTE (S,True) ;
     End ;
   If NOT EX AND (S>'') AND (S[1]+UPCASE(S[2])<>'/C') then S := '/C '+S ;
   If B then
     Begin
       {
       SCREENWINDOW (1,1,80,25,FALSE,'') ;
       }
       If HI_TEXT then
         Begin
           NEW (L_SC) ;
           FILLCHAR (L_SC^,SIZEOF (L_SC^),0) ;
           READSCREEN (L_SC^) ;
           MERGE (L_D_S) ;
         End
        Else
         Begin
           NEW (SC) ;
           FILLCHAR (SC^,SIZEOF (SC^),0) ;
           READSCREEN (SC^) ;
           MERGE (D_S) ;
         End ;
       GOABSOLUTE ;
       BB := CURS_STAT ;
       GOTOXY (1,1) ;
       If NOT HI_TEXT AND (D_S <> NIL) then
         Begin
           GOTOXY (1,25) ;
           INSLINE ;
         End ;
       If S='' then
         WRITELN (#10#10' Tapez  "EXIT"  pour quitter le DOS .'#13#10) ;
       CURSOR (TRUE) ;
     End ;
   GETDIR (0,P) ;
   If EX AND (POS('\',S)+POS(':',S)>0) AND NOT NOPATH then CHDIR (ExtractFilePath(S)) ;
   mmode:=screenmode;
   videomode(3);
   GETINTVEC (5,PT) ;
   SWAPVECTORS ;
   If OLDINT05<>NIL then SETINTVEC (5,OLDINT05) ;
   If EX then
     EXEC (S,ARGS)
    Else
     EXEC (GETENV('COMSPEC'),S) ;
   If OLDINT05<>NIL then SETINTVEC (5,PT) ;
   SWAPVECTORS ;
   videomode(mmode);
   CHDIR (P) ;
   If B then
     Begin
       {
       POPSCREEN ;
       }
       If HI_TEXT then
         Begin
           If L_D_S <> NIL then READSCREEN (L_D_S^) ;
           If S>'' then
             Begin
               SET_COLOR (NORM) ;
               WRITE (#13#10' Tapez une touche ... ') ;
               CURSOR (True) ;
               GET (C) ;
             End ;
           GOWINDOW ;
           MERGE (L_SC) ;
           DISPOSE (L_SC) ;
         End
        Else
         Begin
           If D_S <> NIL then READSCREEN (D_S^) ;
           If S>'' then
             Begin
               SET_COLOR (NORM) ;
               WRITE (#13#10' Tapez une touche ... ') ;
               CURSOR (True) ;
               GET (C) ;
             End ;
           GOWINDOW ;
           MERGE (SC) ;
           DISPOSE (SC) ;
         End ;
       CURSOR (BB) ;
     End ;
   attrib := matt;
 End ;
 *)
 {-----------------------------------------------------------------------------}

 Procedure DIRECTORY (Path:PATHSTR;ATT:WORD;Var N:WORD;Var V) ;

 Var D : Array [0..DirSize] OF DIRREC ABSOLUTE V ;
     R : TSEARCHREC ;
     Err : Integer;
     F : WORD ;

 Begin
   F := 0 ;
   Err := FINDFIRST (Path,Att,R) ;
   WHILE (F<N) AND (ERR=0) DO WITH D[F] DO
     Begin
       MOVE (R.Attr,D[F],22) ;
       INC (F) ;
       Err := FINDNEXT (R) ;
     End ;
   Sysutils.FindClose(R);
   OK := (ERR<>0) ;
   N := F ;
 End ;

 {-----------------------------------------------------------------------------}

 Procedure TREE ( DRV:ShortInt ; Var N:WORD ; Var V ) ;

 Var D     : Array [0..TreeSize] OF PATHSTR ABSOLUTE V ;
     T     : Array [0..TreeHeight] OF TSEARCHREC ;
     NV    : Array [0..TreeHeight] OF Boolean ;
     F,G   : WORD ;
     H,Err : INTEGER ;
     S,S1  : PATHSTR ;

 Procedure SUB ;

 Begin
   WITH T[H] DO
     WHILE (ERR=0) AND ((NAME[1]='.') OR (ATTR AND $10=0)) DO
       Err := FINDNEXT (T[H]) ;
 End ;

 Begin
   s:='';
   GETDIR (DRV,S) ;
   D[0] := S ;
   If S[Length(S)] <> '\' then S := S+'\' ;
   FOR F := 0 TO TreeHeight DO NV[F] := True ;
   F := 1 ;
   H := 0 ;
   Err := FINDFIRST (S+TREE_MASK,$10,T[H]) ;
   SUB ;
   If ERR<>0 then DEC(H) ;
   NV[0] := FALSE ;
   WHILE (F<N) AND (H>=0) DO
     Begin
       If ERR=0 then
         Begin
           S1 := S ;
           FOR G := 0 TO H DO S1 := S1+T[G].NAME+'\' ;
           D[F] := S1 ;
 {$ifdef VER80}
           If S1[0]>=#4 then DEC (D[F][0]) ;
 {$ELSE}
           If length(S1)>=4 then Setlength(D[F],Length(D[F])-1) ;
 {$ENDIf}
           INC (F) ;
           INC (H) ;
         End ;
       If H<=TreeHeight then
         Begin
           If NV[H] then
             Begin
               Err := FINDFIRST (S1+TREE_MASK,$10,T[H]) ;
               NV[H] := FALSE ;
             End
            Else
             Err := FINDNEXT (T[H]) ;
           SUB ;
           If ERR<>0 then
             Begin
               NV[H] := TRUE ;
               DEC(H) ;
             End ;
         End
        Else
         F := N ;
     End ;
   OK := (F<N) ;
   N := F ;
 End ;

 {-----------------------------------------------------------------------------}
 (*   Pas pour DELPHI
 Function  DISK_SPACE  ( N:PATHSTR;DPL:LONGINT;AFF:Boolean) : Boolean ;

 Var B  : Boolean ;
     N1 : PATHSTR ;
     C  : CHAR ;

 Begin
   N1 := BEFORE (MY_SEP,N) ;
   N1 := ExpandFileName(N1) ;
   C  := N1[1] ;
   DPL := DISKFREE (ORD(C)-64) - DPL ;
   WHILE N>'' DO
     Begin
       N1 := BEFORE (MY_SEP,N) ;
       N := AFTER (MY_SEP,N) ;
       N1 := ExpandFileName(N1) ;
       If EXISTE (N1) then DEC (DPL,CHARFILESPACE) ;
     End ;
   DPL := DPL OR (CLUSTERSIZE(ORD(C)-64)-1) + 1 ;
   If DPL < CLUSTERSIZE(ORD(C)-64) then
     Begin
       If AFF then
         EXITCHAR := AFF_MES (62,4,#10'  La place disponible sur le disque '+C+': est insuffisante pour'+
                               #10#13'  effectuer l''op‚ration demand‚e.',
                               'ATTENTION') ;
       DISK_SPACE := False ;
     End
    Else
     DISK_SPACE := True ;
 End ;
 *)

 {-----------------------------------------------------------------------------}

 Function  FMT_NAME    ( N:PATHSTR ) : str16;

 Begin
   n := ExtractFileName(n);
   FMT_NAME:=rfill (before ('.',n),8)+'.'+rfill (after ('.',n),3);
 End;

 {-----------------------------------------------------------------------------}



 Procedure byteassign (Var bfv;Var buffer;siz:word;fn:Pathstr);

 Var bf : bytefile absolute bfv;

 begin
   with bf do
     begin
       assignFile (f,fn);
       cnt :=0;
       sz := siz;
       rdsz := 0;
       eofflg := 0;
       buf:=addr(buffer);
       wr := false;
     end ;
 end ;

 {-----------------------------------------------------------------------------}

 Procedure byteflush (Var bfv);

 Var bf : bytefile absolute bfv;

 begin
   with bf do
     begin
       if wr and (cnt<>0) then
         begin
           blockwrite(f,buf^,cnt);
           cnt := 0;
           rdsz := 0;
           eofflg := -1;
         end ;
     end ;
 end ;


 {-----------------------------------------------------------------------------}

 Procedure bytereset (Var bfv);

 Var bf : bytefile absolute bfv;

 begin
   with bf do
     begin
       byteflush(bf);
       wr := false;
       reset (f,1);
       rdsz := 0;
       eofflg := 0;
     end ;
 end ;

 {-----------------------------------------------------------------------------}

 Procedure byterewrite (Var bfv);

 Var bf : bytefile absolute bfv;

 begin
   with bf do
     begin
       rewrite (f,1);
       wr := true;
       cnt := 0;
       rdsz := 0;
       eofflg := -1;
     end ;
 end ;

 {-----------------------------------------------------------------------------}

 Procedure byteclose (Var bfv);

 Var bf : bytefile absolute bfv;

 begin
   byteflush(bf);
   with bf do  close (f);
 end ;

 {-----------------------------------------------------------------------------}

 Function byteof (Var bfv):boolean ;

 Var bf : bytefile absolute bfv;

 begin
   with bf do
     begin
       if eofflg=0 then
        begin
          eofflg := 1;
          if eof(f) then eofflg := -1;
        end ;
       byteof := ((eofflg = -1) and (bf.cnt >= bf.rdsz)) ;
     end ;
 end;

 {-----------------------------------------------------------------------------}

 Procedure byteread (Var bfv;Var b:byte);

 Var bf : bytefile absolute bfv;

 begin
   with bf do
     begin
       if cnt=0 then
         begin
           blockread(f,buf^,sz,integer(rdsz));
           eofflg := 1;
           if eof(f) then eofflg := -1;
           wr := false;
         end ;
       if cnt<rdsz then
         begin
           b := buf^[cnt];
           inc (cnt);
           if cnt >= rdsz then cnt := 0;
         end
        else
         b := 0;
     end ;
 end ;

 {-----------------------------------------------------------------------------}

 Procedure ByteCharRead (Var bfv;Var c:char);

 Var b : byte absolute c;

 begin
   byteread (bfv,b);
 end ;

 {-----------------------------------------------------------------------------}

 Procedure bytewrite (Var bfv;b:byte);

 Var bf : bytefile absolute bfv;

 begin
   with bf do
     begin
       buf^[cnt]:=b;
       inc (cnt);
       if cnt>=sz then
         begin
           blockwrite(f,buf^,cnt);
           cnt:=0;
         end;
       wr := true;
       eofflg := -1;
     end ;
 end ;

 {-----------------------------------------------------------------------------}

 Procedure ByteCharWrite (Var bfv;c:char);

 begin
   bytewrite (bfv,ord(c));
 end ;

 {-----------------------------------------------------------------------------}

 Procedure bytestrwrite (Var bfv;s:string);

 Var bf : bytefile absolute bfv;
     ct : byte;

 begin
   for ct := 1 to length(s) do
    with bf do
     begin
       buf^[cnt]:=ord(s[ct]);
       inc (cnt);
       if cnt>=sz then
         begin
           blockwrite(f,buf^,cnt);
           cnt:=0;
         end;
       wr := true;
       eofflg := -1;
     end ;
 end ;

 {-----------------------------------------------------------------------------}

 (*
 Function DelOldFiles (s:pathstr;jrs:word) : word;

 Var dirinfo : Tsearchrec;
     l       : longint;
     fin : boolean;
     cnt : word;
     Err : Integer;

 begin
   l := DirInfo.Time;
   l := l-jrs * 65536;
   cnt := 0;
   fin :=((l<=0) or (jrs=0));
   while not fin do
    Begin
     Err := FindFirst(s, FAArchive, DirInfo);
     fin := (Err <>0);
     while not fin and (DirInfo.time>=l) do
       begin
         Err := FindNext(DirInfo);
         fin := (Err <>0);
       end;
     if not fin and (DirInfo.time<l) then
       begin
        File_Erase (DirInfo.name);
        inc (cnt);
       end ;
    End;
   sysutils.FindClose(DirInfo);
   DelOldFiles := cnt;
 end ;  *)

 {-----------------------------------------------------------------------------}

 Function FILES_ERASE (N:PATHSTR) : word ; { efface des fichiers par lots }

 Var Dirinfo : Tsearchrec;
     cnt : word;
     Err : Integer;

 Begin
   cnt := 0;
   Err := FindFirst(n, {Archive}$3F, DirInfo);
   while (Err=0) and (cnt<500) do   {sécurité si suppression impossible}
     begin
       sysutils.FindClose (DirInfo);
       File_Erase (DirInfo.name);
       inc (cnt);
       Err := FindFirst(n, FAArchive, DirInfo);
     end ;
   sysutils.FindClose (DirInfo);
   FILES_ERASE := cnt;
 End ;
 {-----------------------------------------------------------------------------}

 (* Fonctions fichiers d'init *)

 Function SetSeqFile (N:PathStr) : Boolean;

 Var b : Boolean;

 Begin
   N := ExpandFileName (n);
   B := Existe (n);
   if not b then n := Before ('.',n)+SeqInitExt;
   B := Existe (n);
   if b then
     SeqFileName := n
    else
     SeqFileName := '';
   SetSeqFile := b;
 End;

 Function readseq (wrd:String) : String;

 Var t : text;
     s : String;
     n : String;
     Niv,MyNiv:Integer;

 Begin
  wrd := uppercase (wrd);
  if wrd[length(wrd)]<>SeqInitSign then wrd := wrd+SeqInitSign;
  Wrd := RtRm(Wrd);
  s := '';
  Niv := 0;
  MyNiv := 0;
  if Wrd[1]=SeqOpenChar then
   Begin
    MyNiv := 1;
    while (length(Wrd)>2) and (Wrd[2]=SeqOpenChar) do
      Begin
       inc (MyNiv);
       delete (Wrd,2,1);
      End;
   End ;
  if (SeqFileName<>'') and (wrd<>'') then
    Begin
      assign (t,SeqFileName);
      reset (t);
      while not eof (t) and (uppercase(s)<>wrd) do
        Begin
          readln (t,n);
          s := copy (n,1,length(wrd));
          if s<>'' then
           begin
            if S[1]=SeqOpenChar then inc (Niv);        { Supprime ce qui est entre accolades }
            if S[1]=SeqCloseChar then dec (Niv);
            if (Niv<>MyNiv) and (s[1]<>SeqOpenChar) then s := '';
           end;
          (*if S[1]=SeqOpenChar then inc (Niv);        { Supprime ce qui est entre accolades }
          if S[1]=SeqCloseChar then dec (Niv);
          if (Niv<>MyNiv) and (s[1]<>SeqOpenChar) then s := '';*)
        End ;
      close (t);
    End ;
  if uppercase(s)<>wrd then
   readseq := ''
  else
   readseq := copy (n,length(wrd)+1,255);
 End ;


 Function readseqNum (wrd:String) : Integer;

 Begin
  readseqNum := Value(readseq(wrd));
 End ;


 Function readseqStrBlock (wrd:String;Var V;StrSz,MxLines:Word) : Integer;

 Var st : Array [0..65500] of Char absolute V;
     Ln,f,g : Word;
     t : text;
     s,n : String;
     Niv,MyNiv:Integer;

 Begin
  Fillchar (St,StrSz*MXLines+MXLines,#0);
  wrd := uppercase (wrd);
  If Wrd[1] <> SeqOpenChar then Wrd := SeqOpenChar+Wrd;
  Wrd := RtRm(Wrd);
  Ln := 0;
  s := '';
  Niv := 0;
  MyNiv := 1;
  while (length(Wrd)>2) and (Wrd[2]=SeqOpenChar) do
    Begin
      inc (MyNiv);
      delete (Wrd,2,1);
    End;
  if (SeqFileName<>'') and (wrd<>'') then
    Begin
      assign (t,SeqFileName);
      reset (t);
      while not eof (t) and (uppercase(s)<>wrd) do
        Begin
          readln (t,n);
          s := copy (n,1,length(wrd));
          if S[1]=SeqOpenChar then inc (Niv);        { Supprime ce qui est entre accolades }
          if S[1]=SeqCloseChar then dec (Niv);
          if Niv<>MyNiv then s := '';
        End ;
      If uppercase(s)=wrd then
       While not eof(t) and (ln<MxLines) and (Niv>=MyNiv) do
        Begin
          readln (t,n);
          if n[1]=SeqOpenChar then
            inc (Niv)
           else
            if n[1]=SeqCloseChar then
              dec (Niv)
             else
              if niv>=MyNiv then
                Begin
                  For F := 0 to MyNiv do if n[1]=' ' then delete (n,1,1);
                  g := Length(n);
                  if g>StrSz then g := StrSz;
                  for f := 0 to g do St[Ln*StrSz+Ln+F]:=N[f];
                  Inc (Ln);
                End;

        End;
      close (t);
    End ;
  readseqStrBlock := Ln;
 End ;

 Procedure writeseq (wrd:String;data:String) ;

 Var t,old : text;
     n,s : String;
     w : Boolean;
     Niv,MyNiv:Integer;

 Begin
  wrd := uppercase (wrd);
  if wrd[length(wrd)]<>SeqInitSign then wrd := wrd+SeqInitSign;
  Wrd := RtRm(Wrd);
  Niv := 0;
  MyNiv := 0;
  if Wrd[1]=SeqOpenChar then
   Begin
    MyNiv := 1;
    while (length(Wrd)>2) and (Wrd[2]=SeqOpenChar) do
      Begin
       inc (MyNiv);
       delete (Wrd,2,1);
      End;
   End ;
  if wrd<>'' then
   if SeqFileName<>'' then
    Begin
      Make_Bak (SeqFileName);
      assign (old,before('.',SeqFileName)+'.BAK');
      reset (old);
      assign (t,SeqFileName);
      rewrite (t);
      w := False;
      while not eof (old) do
        Begin
          readln (old,n);
          s := copy (n,1,length(wrd));
          if S[1]=SeqOpenChar then inc (Niv);        { Supprime ce qui est entre accolades }
          if S[1]=SeqCloseChar then dec (Niv);
          if (Niv<>MyNiv) and (s[1]<>SeqOpenChar) then s := '';
          if (uppercase(s)=wrd) then
            Begin
              writeln (t,wrd+data);
              w := true;
            End
           else
            writeln (t,n);
        End ;
      if not w then writeln (t,wrd+data);
      close (old);
      close (t);
    End
   else
    Begin
      assign (t,SeqFileName);
      rewrite (t);
      writeln (t,wrd+data);
      close (t);
    End ;
 End ;


 Procedure writeseqStrBlock (Wrd:String;Data:String;Var V;StrSz,Lines:Word);

 Var st : Array [0..65500] of Char absolute V;
     t,old : text;
     n,s,blk : String;
     w : Boolean;
     Niv,MyNiv:Integer;

   Procedure Sub_01;   { Ecrit l'ensemble des données du tableau }

   Var f,g : Word;

   Begin
     writeln (t,wrd+data);
     Blk := Rpt (' ',MyNiv);
     for f := 0 to Lines-1 do
       Begin
         for g := 0 to ord(St[f*StrSz+f]) do  n[g] := St[f*StrSz+f+g];
         Writeln (t,Blk,n);
       End ;
     Writeln (t,SeqCloseChar);
   End ;

 Begin
  wrd := uppercase (wrd);
  If Wrd[1] <> SeqOpenChar then Wrd := SeqOpenChar+Wrd;
  Wrd := RtRm(Wrd);
  if wrd[length(wrd)]<>SeqInitSign then wrd := wrd+SeqInitSign;
  Wrd := RtRm(Wrd);
  Niv := 0;
  MyNiv := 0;
  if Wrd[1]=SeqOpenChar then
   Begin
    MyNiv := 1;
    while (length(Wrd)>2) and (Wrd[2]=SeqOpenChar) do
      Begin
       inc (MyNiv);
       delete (Wrd,2,1);
      End;
   End ;
  if wrd<>'' then
   if SeqFileName<>'' then
    Begin
      Make_Bak (SeqFileName);
      assign (old,before('.',SeqFileName)+'.BAK');
      reset (old);
      assign (t,SeqFileName);
      rewrite (t);
      w := False;
      while not eof (old) do
        Begin
          readln (old,n);
          s := copy (n,1,length(wrd));
          if S[1]=SeqOpenChar then inc (Niv);        { Supprime ce qui est entre accolades }
          if S[1]=SeqCloseChar then dec (Niv);
          if (Niv<>MyNiv) and (s[1]<>SeqOpenChar) then s := '';
          if (uppercase(s)=wrd) then
            Begin
              Sub_01;
              n := '';
              while not eof(old) and (Niv>=MyNiv) do
               Begin
                readln (old,n);
                if n[1]=SeqOpenChar then inc (Niv);
                if n[1]=SeqCloseChar then dec (Niv);
               End;
              w := true;
            End
           else
            writeln (t,n);
        End ;
      if not w then
        Begin
         Sub_01;
         Writeln (t);
        End;
      close (old);
      close (t);
    End
   else
    Begin
      assign (t,SeqFileName);
      rewrite (t);
      Sub_01;
      Writeln (t);
      close (t);
    End ;
 End ;

 Procedure writeseqNum (wrd:String;data:Integer) ;

 Var s : String;

 Begin
   str (data,s);
   WriteSeq (wrd,s);
 End ;
 (*
 {$IfDEF VER80}
 Function GetWindowsDir: string;
 const
 //     * The length of the directory buffer. Usually 64 or even 16 is enough:)
 //    **
 //    ** Must be DWORD type.
    dwLength: Longint = 255;
 Var pcWinDir: PChar;

 Begin
  GetMem(pcWinDir, dwLength);
  GetWindowsDirectory(pcWinDir, dwLength);
  Result := StrPas(pcWinDir);
  FreeMem(pcWinDir, dwLength);
 End;

 Function GetWindowsSysDir: string;
 const
 //     * The length of the directoy buffer. Usually 64 or even 32 is enough:)
 //    **
 //    ** Must be DWORD type.
 //
    dwLength: Longint = 255;
 Var pcSysDir: PChar;

 Begin
  GetMem(pcSysDir, dwLength);
  GetSystemDirectory(pcSysDir, dwLength);
  Result := StrPas(pcSysDir);
  FreeMem(pcSysDir, dwLength);
 End;

 {$else}
 Function GetWindowsDir: string;
 const
 //     * The length of the directory buffer. Usually 64 or even 16 is enough:)
 //    **
 //    ** Must be DWORD type.
    dwLength: DWORD = 255;
 Var pcWinDir: PChar;

 Begin
  GetMem(pcWinDir, dwLength);
  GetWindowsDirectory(pcWinDir, dwLength);
  Result := string(pcWinDir);
  FreeMem(pcWinDir, dwLength);
 End;

 Function GetWindowsSysDir: string;
 const
 //     * The length of the directoy buffer. Usually 64 or even 32 is enough:)
 //    **
 //    ** Must be DWORD type.
 //    *
    dwLength: DWORD = 255;
 Var pcSysDir: PChar;

 Begin
  GetMem(pcSysDir, dwLength);
  GetSystemDirectory(pcSysDir, dwLength);
  Result := string(pcSysDir);
  FreeMem(pcSysDir, dwLength);
 End;
 {$endif}

 {$IfNDEF VER80}
 Function RecycleFile(sFileName: string): Boolean;

 Var FOS: TSHFileOpStruct;

 begin
  FillChar(FOS, SizeOf(FOS), 0);
  with FOS do
   begin
    wFunc := FO_DELETE;
    pFrom := PChar(sFileName);
    fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION or FOF_SILENT;
   end;
  Result := (SHFileOperation(FOS) = 0);
 End;
 {$endif}
 *)


Function CountryCode(const s:String):String;

var i : integer;

Begin
 for i:=CCodesMax downto 0 do
  if length(s)=2 then
    begin
     Result:=After('=',CCodes[i]);
     if uppercase(s)=before('=',CCodes[i]) then exit;
    end
   else
    begin
     Result:=before('=',CCodes[i]);
     if pos(uppercase(s),after('=',uppercase(CCodes[i])))=1 then exit;
    end;
End;


Function LinesCount(const s : String):integer;

var c : char;
    i : integer;

Begin
 i:=0;
 c:=#0;
 Result:=0;
 while  (c=#0) and (i<Length(s)) do
  begin
   inc(i);
   if (s[i]<#14) and (s[i]>#9) then if s[i]=#10 then c:=#10 else if s[i]=#13 then c:=#13;
  end;
 if c<>#0 then
  while  i<=Length(s) do
   begin
    if s[i]=c then inc(Result);
    inc(i);
   end;
End;


Function posfrom(const Substr,s:String;n:integer):integer;

var mn:integer;

Begin
 if n<1 then n:=1;
 mn:=n-1;
 if n<2 then
  begin
   Result:=pos(substr,s);
   exit;
  end;
 result:=0;
 while n<=length(s) do
  if s[n]=substr[1] then
   if copy (s,n,length(substr))=substr then
     begin
      result:=n-mn;
      exit;
     end
    else
     inc (n)
   else
    inc(n);
End;

Function StringFromFile (name:string):string;

var src:Textfile;
    s,st : string;
    f : integer;

Begin
 result :='';
 if not FileExists(name) then exit;
 try
 try
 assignFile (src,name);
// src:=FileOpen(name,fmOpenRead);
 reset (src);
 st:='';
 f:=0;
 while not eof(src) do
  begin
   readln (src,s);
   st:=st+s+#13#10;
   inc(f);
   if (f and $7F)=0 then  { Optimised fo speed }
    begin
     result:=result+st;
     st:='';
    end;
  end;
 result:=result+st;
 finally
 closefile(src);
 end;
 except
 result :='';
 end;
End;

Function BStringFromFile (name:string):string;

var src:file of byte;
    b: Byte;

Begin
 result :='';
 if not FileExists(name) then exit;
 assignFile (src,name);
 reset (src);
 while not eof(src) do
  begin
   read (src,b);
   result:=result+char(b);
  end;
 closefile(src);
End;


Function FStringFromFile (name:string):string;

var src:file of byte;
    lng: integer;

Begin
 result :='';
 if not FileExists(name) then exit;
 assignFile (src,name);
 reset (src);
 lng:=FileSize(src);
 SetLength(Result,lng);
 BlockRead (src,Result[1],lng);
 closefile(src);
End;


Function StringToFile (name,data:string):Boolean;

var dst:Textfile;

Begin
 result :=true;
 try
 try
 if existe(name) then
  if CharFileSize=length(data) then
   if StringFromFile(name)=Data then exit; { Don't overwrite with same data }
 assignFile (dst,name);
 rewrite (dst);
 Write (dst,data);
 finally
 closefile(dst);
 end;
 except
 result:=False;
 end;
End;


Function StringFromStrings (var strg:Tstrings):string;

Begin
 result :=strg.Text;
End;


Function StringToStrings (data:string;var strg:Tstrings):Boolean;

Begin
 strg.SetText(pchar(@data));
 result :=true;
End;


Function  GetLine (var s:String):string;

Begin
 Result:=before (#13#10,s);
 s:=after (#13#10,s);
End;

{
Procedure ConvRichTextToHtml(var s:String;var Ed:TRichedit);

Var f,h : integer;
    b,i,u : Boolean;
    MStyle: TFontStyles;

Begin
 with Ed, ed.SelAttributes do
  begin
   h:=SelStart;
   b:=False;
   i:=False;
   u:=False;
   MStyle:=[];
   s:='';
   for f := 1 to length(Text) do
    begin
     SelStart:=f;
     if style <> MStyle then
      begin
       if (style+[fsBold] = Style) and not b then
        begin b:= True; s:=s+'<b>';end;
       if (style+[fsBold] <> Style) and b then
        begin b:= False; s:=s+'</b>'; end;
       if (style+[fsItalic] = Style) and not i then
        begin i:= True; s:=s+'<i>'; end;
       if (style+[fsItalic] <> Style) and i then
        begin i:= False; s:=s+'</i>'; end;
       if (style+[fsUnderline] = Style) and not u then
        begin u:= True; s:=s+'<u>'; end;
       if (style+[fsUnderline] <> Style) and u then
        begin u:= False; s:=s+'</u>'; end;
       MStyle:=Style;
      end;
     s:=s+Text[f];
    end;
   if b then s:=s+'</b>';
   if i then s:=s+'</i>';
   if u then s:=s+'</u>';
   SelStart:=h;
  end;
End;
}


var ConvHTMailTemp:String;

Function ConvHTMail (s:String):String;

const nbr = 23;
      cmp : Array[0..nbr] of Str2=
       ('20','3D','E8','E9',
        'E0','A9','EE','F9',
        'F4','C9','EA','C2',
        'EB','E2','AB','BB',
        'FB','E7','CA','C7',
        'C0','CE','','');
      rpl : Array[0..nbr] of Str10=
       (' ','=','&egrave;','&eacute;',
        '&agrave;','&copy;','&icirc;','&ugrave;',
        '&ocirc;','&Eacute;','&ecirc;','&Acirc;',
        '&euml;','&acirc;','&quot;','&quot;',
        '&ucirc;','&ccedil;','&Ecirc;','&Ccedil;',
        '&Agrave;','&Icirc;','','');

var f,g : integer;
    st:String;

Begin
 if s='///START' then
  begin
   ConvHTMailTemp:='';
   s:='';
  end;
 Result:=ConvHTMailTemp;
 f:=1;
 while f<=length(s) do
  begin
   if s[f]='=' then
     if f=length(s) then
       begin
        ConvHTMailTemp:=Result;
        Result:='';
        exit;
       end
      else
       begin
        st:=copy (s,f+1,2);
        for g := 0 to nbr do
         if st=cmp[g] then
          begin
           Result:=Result+rpl[g];
           inc (f,2);
          end;
       end
    else
     Result:=Result+s[f];
   inc (f);
  end;
 ConvHTMailTemp:='';
End;


const
    nbr = 49;
    nbrnotag = nbr-4;
    PC_HTML_rpl : Array[0..nbr+nbr-1] of Str8=
       ('É','Eacute','È','Egrave','Ê','Ecirc', 'Ë','Euml',  'Ä','Auml',
        'À','Agrave','Â','Acirc', 'Û','Ucirc', 'Ù','Ugrave','Ü','Uuml',
        'Ò','Ograve','Ô','Ocirc', 'Ö','Ouml',  'Î','Icirc', 'Ì','Igrave',
        'Ï','Iuml',  'Ç','Ccedil','é','eacute','è','egrave','ê','ecirc',
        'ë','euml',  'à','agrave','â','acirc', 'ä','auml',  'û','ucirc',
        'ù','ugrave','ü','uuml',  'ò','ograve','ô','ocirc', 'ö','ouml',
        'î','icirc', 'ì','igrave','ï','iuml',  'ç','ccedil',' ','nbsp',
        '©','copy',  '''','#8217','"','#8220', '"','#8221', 'oe','#339',
        ' ','#160',  '–','#8211', '—','#8212', '•','#8226', '€','#8364',
        '>','gt',    '<','lt',    '&','amp',   '"','quot');
    Radical_rpl : Array[0..1] of Str80=
       ('ÉÈÊËÄÀÂÛÙÜÒÔÖÎÌÏÇéèêëàâäûùüòôöîìïç',
        'EEEEAAAUUUOOOIIICeeeeaaauuuoooiiic');


Procedure ConvCharToRadical (var s:String);

var f,g : Integer;

Begin
 for f := 1 to length(s) do
  begin
   g:=pos(s[f],Radical_Rpl[0]);
   if g>0 then s[f]:=Radical_Rpl[1][g];
  end;
End;

Procedure ConvPCToHTML (var s:String;ConvertTag:Byte);

var f : Integer;
    st : String;
    c:str2;

Begin
 f:=1;
 while f<=length(s) do
  begin
   st:='';
   c:=s[f];
   case c of
        'É' : st:=PC_HTML_rpl[1];
        'È' : st:=PC_HTML_rpl[3];
        'Ê' : st:=PC_HTML_rpl[5];
        'Ë' : st:=PC_HTML_rpl[7];
        'Ä' : st:=PC_HTML_rpl[9];
        'À' : st:=PC_HTML_rpl[11];
        'Â' : st:=PC_HTML_rpl[13];
        'Û' : st:=PC_HTML_rpl[15];
        'Ù' : st:=PC_HTML_rpl[17];
        'Ü' : st:=PC_HTML_rpl[19];
        'Ò' : st:=PC_HTML_rpl[21];
        'Ô' : st:=PC_HTML_rpl[23];
        'Ö' : st:=PC_HTML_rpl[25];
        'Î' : st:=PC_HTML_rpl[27];
        'Ì' : st:=PC_HTML_rpl[29];
        'Ï' : st:=PC_HTML_rpl[31];
        'Ç' : st:=PC_HTML_rpl[33];
        'é' : st:=PC_HTML_rpl[35];
        'è' : st:=PC_HTML_rpl[37];
        'ê' : st:=PC_HTML_rpl[39];
        'ë' : st:=PC_HTML_rpl[41];
        'à' : st:=PC_HTML_rpl[43];
        'â' : st:=PC_HTML_rpl[45];
        'ä' : st:=PC_HTML_rpl[47];
        'û' : st:=PC_HTML_rpl[49];
        'ù' : st:=PC_HTML_rpl[51];
        'ü' : st:=PC_HTML_rpl[53];
        'ò' : st:=PC_HTML_rpl[55];
        'ô' : st:=PC_HTML_rpl[57];
        'ö' : st:=PC_HTML_rpl[59];
        'î' : st:=PC_HTML_rpl[61];
        'ì' : st:=PC_HTML_rpl[63];
        'ï' : st:=PC_HTML_rpl[65];
        'ç' : st:=PC_HTML_rpl[67];
        '©' : st:=PC_HTML_rpl[71];
        '''': st:=PC_HTML_rpl[73];
        '–' : st:=PC_HTML_rpl[83];
        '—' : st:=PC_HTML_rpl[85];
        '•' : st:=PC_HTML_rpl[87];
        '€' : st:=PC_HTML_rpl[89];
        '>' : if (ConvertTag and 1) = 1 then st:=PC_HTML_rpl[nbr+nbr-7];
        '<' : if (ConvertTag and 1) = 1 then st:=PC_HTML_rpl[nbr+nbr-5];
        '&' : if (ConvertTag and 1) = 1 then st:=PC_HTML_rpl[nbr+nbr-3];
        '"' : if (ConvertTag and 1) = 1 then st:=PC_HTML_rpl[nbr+nbr-1]
               else if (ConvertTag and 2) = 2 then st:=PC_HTML_rpl[75];
        end;
   if st>'' then
    begin
     delete (s,f,1);
     insert('&'+st+';',s,f);
     inc (f,length(st)+1);
    end;
   inc(f);
  end;
End;

Procedure ConvHTMLtoPC (var s:String;ConvertTag:Byte);

var f,g,h,j : Integer;
    st : String;

Begin
 f:=1;
 while f<=length(s) do
  begin
   if s[f]='&' then
    begin
     g:=f+1;
     while (g<length(s)) and (s[g]<>';') do inc(g);
     h:=g-f-1;
     st:=copy(s,f+1,h);
     j:=0;
     if (ConvertTag and 1) = 1 then g:=nbr else g:=nbrNoTag;
     g:=g+g-1;
     while g>0 do
      if PC_HTML_rpl[g]=st then
        begin
         j:=g;
         g:=0;
        end
       else
        dec (g,2);
     if j<>0 then
      begin
       delete (s,f,h+2);
       if (j<>76) or ((ConvertTag and 2) <> 2) then insert(PC_HTML_rpl[j-1],s,f);
      end;
    end;
   inc(f);
  end;
End;


Procedure ReplaceString (srch:string;const rpl:String;var s : String);

var f,g,ls : Integer;
    ch,ch2 : Char;
    eq,one,uplo : Boolean;

Begin
 if srch='' then exit;
 eq:=(length(srch)=length(rpl));
// eq:=False;                  /////////DEBUG
 srch:=uppercase(srch);
 ch:=srch[1];
 uplo:=(ch=locase(ch));
 one:= length(srch)=1;
 if one then ch2:=#0 else ch2:=srch[2];
 f:=pos(ch,s);       {Speedup}
 g:=pos(locase(ch),s);
 if (g>0) and (g<f) then f:=g;
 if f=0 then f:=1;
 ls:=length(s);
 while f<=ls do
  if upcase(s[f])=ch then
    if one then
      if eq then
        begin
         s[f]:=rpl[1];
         inc(f);
        end
       else
        begin
         delete (s,f,1);
         if rpl>'' then
          begin
           insert(rpl,s,f);
           inc(f,length(rpl));
          end;
         ls:=length(s);
        end
     else
      if (f=length(s)) or (upcase(s[f+1])=ch2) then
       if uppercase(copy(s,f,length(srch)))=srch then
        if eq then
          begin
           move(rpl[1],s[f],length(rpl));
           inc(f,length(rpl));
          end
         else
          begin
           delete (s,f,length(srch));
           if rpl>'' then
            begin
             insert(rpl,s,f);
             inc(f,length(rpl));
            end;
           ls:=length(s);
          end
        else
         inc(f)
      else
       inc(f)
   else
    if uplo then
      repeat inc (f) until (f>ls) or (s[f]=ch)
     else
      repeat inc (f) until (f>ls) or (upcase(s[f])=ch);
End;



Procedure StripTags (tagStart,tagStop:String;var s:String);

var f,st,lng : integer;
    decst:Boolean;
    ch,ch2:char;

Begin
 if length(tagStart)=0 then exit;
 f := 1;
 tagStart:=uppercase(tagStart);
 ch:=tagStart[1];
 tagStop:=uppercase(tagStop);
 ch2:=tagStop[1];
 st:=0;
 while f<=length(s) do
  begin
   decst:=((st>0) and (uppercase(copy(s,f,length(tagStop)))=tagStop));
   if (upcase(s[f])=ch) and (uppercase(copy(s,f,length(tagStart)))=tagStart) then
     begin
      inc(st);
      delete (s,f,length(tagStart));
     end
    else
     if decst then
       delete (s,f,length(tagStop))
      else
       if st>0 then
         begin
          lng:=1;
          while (f+lng<=length(s)) and (upcase(s[f+lng])<>ch) and (upcase(s[f+lng])<>ch2) do inc(lng);
          delete (s,f,lng);
         end
        else
         inc (f);
   if decst then dec(st);
  end;
End;


// var ch1: char;

Function GetTag (tagStart,tagStop:String;var posi:integer;const s:String):String;

var f : integer;
    inTag:Boolean;
    c1,c2 : char;
//    ch1 : char;

Begin
 if posi<1 then posi:=1;
 tagStart:=uppercase(tagStart);
 tagStop:=uppercase(tagStop);
 c1:=tagStart[1];
 c2:=tagStop[1];
 inTag:=False;
 result:='';
 f:=0;
 while posi<=length(s) do
  begin
   if (upcase(s[posi])=c1) and (uppercase(copy(s,posi,length(tagStart)))=tagStart) then
    if not inTag or (c1<>c2) or (uppercase(copy(s,posi,length(tagStop)))<>tagStop) then
     begin
      inTag:=True;
      inc(posi,length(tagStart));
      f := posi;
     end;
//   ch1:= upcase(s[posi]);
   if inTag and (upcase(s[posi])=c2) and (uppercase(copy(s,posi,length(tagStop)))=tagStop) then
    begin
     Result:=copy(s,f,posi-f);
     exit;
    end;
   inc(posi);
  end;
End;





Procedure ConvHTMLtoPCText (var s:String);

var f : integer;

Begin
 StripHTMLScript(s);
 StripHTMLComments(s);
 ReplaceString(#13#10,' ',s);
 ReplaceString('<P>',#13#10,s);
 ReplaceString('</P>',#13#10,s);
 ReplaceString('<BR>',#13#10,s);
 ReplaceString('</CENTER>',#13#10,s);
 ReplaceString('</MARQUEE>',#13#10,s);
 ReplaceString('<DIV',#1'<DIV',s);
 ReplaceString('<IMG',' <img',s);
 repeat
   f:=length(s);
   ReplaceString(#1#1,#1,s);
   ReplaceString(#1#13#10,#13#10,s);
   ReplaceString(#13#10#1,#13#10,s);
  until (f=length(s));
 ReplaceString(#1,#13#10,s);
 StripHTMLTags(s);
 ConvHTMLtoPC(s,3);
 repeat
   f:=length(s);
   ReplaceString('        ',' ',s);
   ReplaceString('    ',' ',s);
   ReplaceString('  ',' ',s);
   ReplaceString(' '#13#10,#13#10,s);
   ReplaceString(#13#10' ',#13#10,s);
  until (f=length(s));
End;


Function GetHTMLTag(pos:Integer;const s:String):String;

Var f,g : Integer;

Begin
 f:=pos;
 if (f=0) or (f>length(s)) then f:=length(s);
 g:=pos+1;
 Result:='';
 while (f>0) and (s[f]<>'<') and (s[f]<>'>') do dec(f);
 if f=0 then exit;
 while (g<length(s)) and (s[g]<>'<') and (s[g]<>'>') do inc(g);
 if (s[f]='<') and (s[g]='>') then Result:=Copy(s,f,g-f+1);
End;


Function UnQuote(const s:string):String;

var d,f : integer;

Begin
 if (s>'') and (s[1] in ['"','''']) then d:=2 else d:=1;
 if (s>'') and (s[length(s)] in ['"','''']) then f:=length(s)-d+1 else f:=length(s);
 Result:=copy(s,d,f);
End;

Procedure ConvHTMLToPCFilename (var s:String);

var f : integer;

Begin
 ReplaceString('file:///','',s);
 if (length(s)>1) and (upcase(s[1]) in ['A'..'Z']) and (s[2]='|') then s[2]:=':';
 for f :=1 to length(s) do if s[f]='/' then s[f]:='\';
End;

Procedure ConvPCToHTMLFilename (var s:String);

var f : integer;

Begin
 s:=ExtractRelativePath(GetCurrentDir+'\',s);
 if (upcase(s[1]) in ['A'..'Z']) and (s[2]=':') then
  begin
    s[2]:=':';
    s:='file:///'+s;
  end;
 for f :=1 to length(s) do if s[f]='\' then s[f]:='/';

 {ls:=uppercase(GetCurrentDir);
 s:=ExpandFilename(s);
 if length(s)<length(ls) then g:=length(s) else g:=length(ls);
 f:=1;
 while (f<g) and (upcase(s[f])=ls[f]) do inc (f);
 delete (s,1,f-1);
 delete (ls,1,f-1);}
End;


Procedure ServerSideInclude (var s:String);

var ups,tag,fname : String;
    f : Integer;

Begin
 ups:=Uppercase(s);
 f:=pos('<!--#INCLUDE FILE="',ups);
 if f=0 then f:=pos('<!--#INCLUDE VIRTUAL="',ups);
 while f>0 do
  begin
   tag:=getHTMLTag(f,s);
   fname:=after('"',before('"-->',Tag));
   delete(s,f,length(tag));
   insert(StringFromFile(fname),s,f);
   ups:=Uppercase(s);
   f:=pos('<!--#INCLUDE FILE="',ups);
   if f=0 then f:=pos('<!--#INCLUDE VIRTUAL="',ups);
  end;
End;

Procedure StripHTMLComments (var s:String);

Begin
 StripTags('<!--','-->',s);
End;

Procedure StripHTMLScript (var s:String);

Begin
 StripTags('<SCRIPT','/SCRIPT>',s);
End;


Procedure StripHTMLTags (var s:String);

var f,st : integer;
    c : Char;
    s2 : String;

Begin
 f := 1;
 st:=0;
 s2:='';
 while f<=length(s) do
  begin
   c:=s[f];
   if c='<' then st:=1;
   {if st=1 then delete (s,f,1) else inc (f);}
   if st=0 then s2:=s2+c;
   if c='>' then st:=0;
   inc(f);
  end;
 s:=s2;
End;


Procedure CharFilter (rpl:string;var s:String;const st:AllChars);

var f : integer;

Begin
 f := 1;
 while f<=length(s) do
  if not (s[f] in st) then
    begin
     delete(s,f,1);
     insert(rpl,s,f);
     inc (f,length(rpl));
    end
   else
    inc (f);
End;

Procedure HTMLBrowse (const s:String);

Begin
 {$IFDEF Windows}
 ShellExecute (0, 'open', pchar(@s), Nil, Nil, SW_SHOWNORMAL);
 {$ENDIF}
 {$ifdef Unix}
  // TODO
 {$endif}
End;

function ValidEmail(email: string): boolean;
  // Returns True if the email address is valid
  // Author: Ernesto D'Spirito
  const
    // Valid characters in an "atom"
    atom_chars = [#33..#255] - ['(', ')', '<', '>', '@', ',', ';', ':',
                                '\', '/', '"', '.', '[', ']', #127];
    // Valid characters in a "quoted-string"
    quoted_string_chars = [#0..#255] - ['"', #13, '\'];
    // Valid characters in a subdomain
    letters = ['A'..'Z', 'a'..'z'];
    letters_digits = ['0'..'9', 'A'..'Z', 'a'..'z'];
//    subdomain_chars = ['-', '0'..'9', 'A'..'Z', 'a'..'z'];
  type
    States = (STATE_BEGIN, STATE_ATOM, STATE_QTEXT, STATE_QCHAR,
      STATE_QUOTE, STATE_LOCAL_PERIOD, STATE_EXPECTING_SUBDOMAIN,
      STATE_SUBDOMAIN, STATE_HYPHEN);
  var
    State: States;
    i, n, subdomains: integer;
    c: char;
  begin
    State := STATE_BEGIN;
    n := Length(email);
    i := 1;
    subdomains := 1;
    while (i <= n) do begin
      c := email[i];
      case State of
      STATE_BEGIN:
        if c in atom_chars then
          State := STATE_ATOM
        else if c = '"' then
          State := STATE_QTEXT
        else
          break;
      STATE_ATOM:
        if c = '@' then
          State := STATE_EXPECTING_SUBDOMAIN
        else if c = '.' then
          State := STATE_LOCAL_PERIOD
        else if not (c in atom_chars) then
          break;
      STATE_QTEXT:
        if c = '\' then
          State := STATE_QCHAR
        else if c = '"' then
          State := STATE_QUOTE
        else if not (c in quoted_string_chars) then
          break;
      STATE_QCHAR:
        State := STATE_QTEXT;
      STATE_QUOTE:
        if c = '@' then
          State := STATE_EXPECTING_SUBDOMAIN
        else if c = '.' then
          State := STATE_LOCAL_PERIOD
        else
          break;
      STATE_LOCAL_PERIOD:
        if c in atom_chars then
          State := STATE_ATOM
        else if c = '"' then
          State := STATE_QTEXT
        else
          break;
      STATE_EXPECTING_SUBDOMAIN:
        if c in letters then
          State := STATE_SUBDOMAIN
        else
          break;
      STATE_SUBDOMAIN:
        if c = '.' then begin
          inc(subdomains);
          State := STATE_EXPECTING_SUBDOMAIN
        end else if c = '-' then
          State := STATE_HYPHEN
        else if not (c in letters_digits) then
          break;
      STATE_HYPHEN:
        if c in letters_digits then
          State := STATE_SUBDOMAIN
        else if c <> '-' then
          break;
      end;
      inc(i);
    end;
    if i <= n then
      Result := False
    else
      Result := (State = STATE_SUBDOMAIN) and (subdomains >= 2);
  end;

Function ExtractLinks(s:String):String;

var f,g : integer;
    st:string;

Begin
 Result:='';
 f:=pos ('://',s);
 while f>3 do
  begin
   st:=lowercase(copy(s,f-3,3));
   if (st='ttp') and (f>4) then st:=lowercase(s[f-4])+st;
   if (st='tps') and (f>5) then st:=lowercase(s[f-5])+lowercase(s[f-4])+st;
   if (st='ftp') or (st='http') or (st='https') then
    begin
     g:=f+3;
     while (g<length(s)) and not (s[g] in [' ',#9,#10,#13,',']) do inc(g);
     if s[g] in [' ',#10,#13,','] then dec(g);
     if (g>f+6) then
      begin
       st:=st+copy(s,f,g-f+1);
       if pos('.',st)>0 then Result:=Result+st+#13;
      end;
    end;
   s[f]:=' ';
   f:=pos ('://',s);
  end;
End;

Begin
  EOFN := FALSE ;
  STRN_PTR1 := NIL ;
  STRN_PTR2 := NIL ;
  STRN_NUM  := 0 ;
  SILENT := FALSE ;
  FILL_CHAR  := ' ' ;
  EDIT_CHAR  := 'ú' ;
  MY_SEP     := '#' ;
  STRN_UNPACK := TRUE ;
  PROGNAME   :='' ;

  INT24 := False ;
  IOERROR := 0 ;
  SeqFileName:= '';
end.

