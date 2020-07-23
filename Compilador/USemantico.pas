unit USemantico;

interface

uses UToken, USemanticError, StrUtils, Classes, SysUtils;

type
    TSemantico = class
    procedure AdicionaLista(gItem: String);
    function PegaUltimoLista(): String;
    procedure RemoveLista();
    procedure Acao1();
    procedure Acao2();
    procedure Acao3();
    procedure Acao4();
    procedure Acao5(sToken: TToken);
    procedure Acao6(sToken: TToken);
    procedure Acao7();
    procedure Acao8();
    procedure Acao9(sToken: TToken);
    procedure Acao10();
    procedure Acao11(sToken: TToken);
    procedure Acao12(sToken: TToken);
    procedure Acao13();
    procedure Acao14();
    procedure Acao15(sToken: TToken);
    procedure Acao16(sToken: TToken);
    procedure Acao17();
    procedure Acao18();
    procedure Acao19();
    procedure Acao20(sToken: TToken);
    procedure Acao21(sToken: TToken);
    procedure Acao22();
    procedure Acao23();
    procedure Acao24();
    procedure Acao25();
    procedure Acao26();
    procedure Acao27();
    procedure Acao28();
    procedure Acao29();
    procedure Acao30(sToken: TToken);
    procedure Acao31();
    procedure Acao32(sToken: TToken);
    procedure Acao33(sToken: TToken);
    procedure Acao34();
    procedure Acao35();
    procedure Acao36();
    procedure Acao37();
    procedure Acao38();
    procedure Acao39();
    procedure Acao40();
    procedure Acao41();
    procedure Acao42();
    procedure Acao43();
    procedure Acao44();
    procedure Acao45();
    function VerificaTS(sTexto: String): Boolean;
    function PegaTipoTs(sTexto: String): String;
    public
        procedure executeAction(action : integer; const token : TToken); //raises ESemanticError

    end;

var
  gLista: TStringList;
  gListaArquivo: TStringList;
  gOperadorRelacional: String;
  gTipo_var: String;
  gValor_var: String;
  gListaRotulos: TStringList;
  gListaIdentificadores: TStringList;
  gTS: TStringList;

implementation

procedure TSemantico.executeAction(action : integer; const token : TToken);
begin
  Case action Of
    1  : Acao1;
    2  : Acao2;
    3  : Acao3;
    4  : Acao4;
    5  : Acao5(token);
    6  : Acao6(token);
    7  : Acao7;
    8  : Acao8;
    9  : Acao9(token);
    10 : Acao10;
    11 : Acao11(token);
    12 : Acao12(token);
    13 : Acao13;
    14 : Acao14;
    15 : Acao15(token);
    16 : Acao16(token);
    17 : Acao17;
    18 : Acao18;
    19 : Acao19;
    20 : Acao20(token);
    21 : Acao21(token);
    22 : Acao22;
    23 : Acao23;
    24 : Acao24;
    25 : Acao25;
    26 : Acao26;
    27 : Acao27;
    28 : Acao28;
    29 : Acao29;
    30 : Acao30(token);
    31 : Acao31;
    32 : Acao32(token);
    33 : Acao33(token);
    34 : Acao34;
    35 : Acao35;
    36 : Acao36;
    37 : Acao37;
    38 : Acao38;
    39 : Acao39;
    40 : Acao40;
    41 : Acao41;
    42 : Acao42;
    43 : Acao43;
    44 : Acao44;
    45 : Acao45;
  end;
end;

procedure TSemantico.AdicionaLista(gItem: String);
begin
  gLista.Add(gItem);
end;

function TSemantico.PegaUltimoLista: String;
begin
  if gLista.Count > 0 then
    begin
      Result := gLista.Strings[gLista.Count -1];
    end;
end;

procedure TSemantico.RemoveLista;
begin
  if gLista.Count > 0 then
    begin
      gLista.Delete(gLista.Count - 1);
    end;
end;

procedure TSemantico.Acao1; //OK
var
  iTipo1, iTipo2: String;
begin
  iTipo1 := PegaUltimoLista;
  RemoveLista;
  iTipo2 := PegaUltimoLista;
  RemoveLista;
  {if (iTipo1 = 'float64') OR (iTipo2 = 'float64') then
    begin
      gLista.Add('float64');
    end
  else
    begin
      raise ESemanticError.create('Tipos incompativeos em expre��o aritmetica!');
      Abort;
    end;}
  if ((iTipo1 = 'float64') or (iTipo1 = 'int64')) AND ((iTipo2 = 'float64') or (iTipo2 = 'int64')) then
    begin
      if iTipo1 = iTipo2 then
        gLista.Add(iTipo1)
      else
        gLista.Add('float64');  
    end
  else if ((iTipo1 = 'hexa') or (iTipo1 = 'bin')) AND ((iTipo2 = 'hexa') or (iTipo2 = 'bin')) then
    begin
      if iTipo1 = iTipo2 then
        gLista.Add(iTipo1)
      else
        begin
          raise ESemanticError.create('Tipos incompativeos em expre��o aritmetica!');
          //Abort;
        end;
    end
  else
    begin
      raise ESemanticError.create('Tipos incompativeos em expre��o aritmetica!');
      //Abort;
    end;
  gListaArquivo.Add('add');
end;

procedure TSemantico.Acao2; //OK
var
  iTipo1, iTipo2: String;
begin
  iTipo1 := PegaUltimoLista;
  RemoveLista;
  iTipo2 := PegaUltimoLista;
  RemoveLista;
  {if (iTipo1 = 'float64') OR (iTipo2 = 'float64') then
    begin
      gLista.Add('float64');
    end
  else
    begin
      raise ESemanticError.create('Tipos incompativeos em expre��o aritmetica!');
      Abort;
    end;}
  if ((iTipo1 = 'float64') or (iTipo1 = 'int64')) AND ((iTipo2 = 'float64') or (iTipo2 = 'int64')) then
    begin
      if iTipo1 = iTipo2 then
        gLista.Add(iTipo1)
      else
        gLista.Add('float64');  
    end
  else if ((iTipo1 = 'hexa') or (iTipo1 = 'bin')) AND ((iTipo2 = 'hexa') or (iTipo2 = 'bin')) then
    begin
      if iTipo1 = iTipo2 then
        gLista.Add(iTipo1)
      else
        begin
          raise ESemanticError.create('Tipos incompativeos em expre��o aritmetica!');
          //Abort;
        end;
    end
  else
    begin
      raise ESemanticError.create('Tipos incompativeos em expre��o aritmetica!');
      //Abort;
    end;
  gListaArquivo.Add('sub');
end;

procedure TSemantico.Acao3; //OK
var
  iTipo1, iTipo2: String;
begin
  iTipo1 := PegaUltimoLista;
  RemoveLista;
  iTipo2 := PegaUltimoLista;
  RemoveLista;
  if ((iTipo1 = 'float64') or (iTipo1 = 'int64')) AND ((iTipo2 = 'float64') or (iTipo2 = 'int64')) then
    begin
      if iTipo1 = iTipo2 then
        gLista.Add(iTipo1)
      else
        gLista.Add('float64');  
    end
  else if ((iTipo1 = 'hexa') or (iTipo1 = 'bin')) AND ((iTipo2 = 'hexa') or (iTipo2 = 'bin')) then
    begin
      if iTipo1 = iTipo2 then
        gLista.Add(iTipo1)
      else
        begin
          raise ESemanticError.create('Tipos incompativeos em expre��o aritmetica!');
          //Abort;
        end;
    end
  else
    begin
      raise ESemanticError.create('Tipos incompativeos em expre��o aritmetica!');
      //Abort;
    end;
  gListaArquivo.Add('mul');
end;

procedure TSemantico.Acao4; //OK
var
  iTipo1, iTipo2: String;
begin
  iTipo1 := PegaUltimoLista;
  RemoveLista;
  iTipo2 := PegaUltimoLista;
  RemoveLista;
  if ((iTipo1 = 'float64') or (iTipo1 = 'int64')) AND ((iTipo2 = 'float64') or (iTipo2 = 'int64')) then
    begin
      gLista.Add('float64');
    end
  else if ((iTipo1 = 'hexa') or (iTipo1 = 'bin')) AND ((iTipo2 = 'hexa') or (iTipo2 = 'bin')) then
    begin
      if iTipo1 = iTipo2 then
        gLista.Add(iTipo1)
      else
        begin
          raise ESemanticError.create('Tipos incompativeos em expre��o aritmetica!');
          //Abort;
        end;
    end
  else
    begin
      raise ESemanticError.create('Tipos incompativeos em expre��o aritmetica!');
      //Abort;
    end;
  gListaArquivo.Add('div');
end;

procedure TSemantico.Acao5(sToken: TToken); //OK
begin
  gLista.Add('int64');
  gListaArquivo.Add('ldc.i8 ' + sToken.getLexeme);
  gListaArquivo.Add('conv.r8');
end;

procedure TSemantico.Acao6(sToken: TToken); //OK
begin
  gLista.Add('float64');
  gListaArquivo.Add('ldc.i8 ' + sToken.getLexeme);
  //gListaArquivo.Add('conv.r8');
end;

procedure TSemantico.Acao7; //OK
var
  iTipo: String;
begin
  iTipo := PegaUltimoLista;
  RemoveLista;
  if (iTipo = 'float64') OR (iTipo = 'int64') then
    gLista.Add(iTipo)
  else
    begin
      raise ESemanticError.create('Tipos incompativeos em expre��o aritmetica!');
      //Abort;
    end;
end;

procedure TSemantico.Acao8; //OK
var
  iTipo: String;
begin
  iTipo := PegaUltimoLista;
  RemoveLista;
  if (iTipo = 'float64') OR (iTipo = 'int64') then
    gLista.Add(iTipo)
  else
    begin
      raise ESemanticError.create('Tipos incompativeos em expre��o aritmetica!');
      //Abort;
    end;
  gListaArquivo.Add('ldc.i8 -1');
  gListaArquivo.Add('conv.r8');
  gListaArquivo.Add('mul');
end;

procedure TSemantico.Acao9(sToken: TToken); //OK
begin
  gOperadorRelacional := sToken.getLexeme;
end;

procedure TSemantico.Acao10; //OK
var
  iTipo1, iTipo2: String;
begin
  iTipo1 := PegaUltimoLista;
  RemoveLista;
  iTipo2 := PegaUltimoLista;
  RemoveLista;
  if iTipo1 = iTipo2 then
    gLista.Add('bool')
  else
    begin
      raise ESemanticError.create('Tipos incompativeos em expre��o relacional!');
    end;
  Case AnsiIndexStr(gOperadorRelacional, ['>', '<', '=']) Of
    0 : gListaArquivo.Add('cgt');
    1 : gListaArquivo.Add('clt');
    2 : gListaArquivo.Add('ceq');
  end;
end;

procedure TSemantico.Acao11(sToken: TToken); //OK
begin
  gLista.Add('bool');
  gListaArquivo.Add('lcd.i4.1');
end;

procedure TSemantico.Acao12(sToken: TToken); //OK
begin
  gLista.Add('bool');
  gListaArquivo.Add('lcd.i4.0');
end;

procedure TSemantico.Acao13; //OK
var
  iTipo: String;
begin
  iTipo := PegaUltimoLista;
  RemoveLista;
  if iTipo = 'bool' then
    gLista.Add('bool')
  else
    begin
      raise ESemanticError.create('Tipos incompativeis em express�o l�gica!');
    end;
  gListaArquivo.Add('ldc.i4.1');
  gListaArquivo.Add('xor');
end;

procedure TSemantico.Acao14; //OK
var
  iTipo: String;
begin
  iTipo := PegaUltimoLista;
  RemoveLista;
  if (iTipo = 'hexa') or (iTipo = 'bin') then
    begin
      if iTipo = 'hexa' then
        begin
          gListaArquivo.Add('ldstr "#x"');
          gListaArquivo.Add('call void [mscorlib]System.Console::Write(string)');
          gListaArquivo.Add('ldc.i4 16');
        end
      else
        begin
          gListaArquivo.Add('ldstr "#b"');
          gListaArquivo.Add('call void [mscorlib]System.Console::Write(string)');
          gListaArquivo.Add('ldc.i4 2');
        end;
      gListaArquivo.Add('call string [mscorlib]System.Console::Write(int64, int32)');
      gListaArquivo.Add('call void [mscorlib]System.Console::Write(string)');
    end
  else
    begin
      if iTipo = 'int64' then
        gListaArquivo.Add('conv.i8');
      gListaArquivo.Add('call void [mscorlib]System.Console::Write(' + iTipo + ')');
    end;

end;

procedure TSemantico.Acao15(sToken: TToken); //OK
begin
  gListaArquivo.Add('.assembly extern mscorlib {}');
  gListaArquivo.Add('.assembly teste_a{}');
  gListaArquivo.Add('.module teste_a{}');
  gListaArquivo.Add('');
  gListaArquivo.Add('.class public teste_a{');
  gListaArquivo.Add('  .method static public void _principal()');
  gListaArquivo.Add('  { .entrypoint');
end;

procedure TSemantico.Acao16(sToken: TToken); //OK
begin
  gListaArquivo.Add('    ret');
  gListaArquivo.Add('  }');
  gListaArquivo.Add('}');
end;

procedure TSemantico.Acao17; //OK
var
  iTipo1, iTipo2: String;
begin
  iTipo1 := PegaUltimoLista;
  RemoveLista;
  iTipo2 := PegaUltimoLista;
  RemoveLista;
  if (iTipo1 = 'bool') AND (iTipo2 = 'bool') then
    begin
      gLista.Add(iTipo1);
    end
  else
    begin
      raise ESemanticError.create('tipos incompat�veis em express�o l�gica!');
    end;
  gListaArquivo.Add('and');
end;

procedure TSemantico.Acao18; //OK
var
  iTipo1, iTipo2: String;
begin
  iTipo1 := PegaUltimoLista;
  RemoveLista;
  iTipo2 := PegaUltimoLista;
  RemoveLista;
  if (iTipo1 = 'bool') AND (iTipo2 = 'bool') then
    begin
      gLista.Add(iTipo1);
    end
  else
    begin
      raise ESemanticError.create('tipos incompat�veis em express�o l�gica!');
    end;
  gListaArquivo.Add('or');
end;

procedure TSemantico.Acao19; //OK
begin
  gLista.Add('string');
  gListaArquivo.Add('ldstr -');
end;

procedure TSemantico.Acao20(sToken: TToken); //OK
begin
  gLista.Add('bin');
  gListaArquivo.Add('ldstr "' + AnsiReplaceStr(sToken.getLexeme,'#b', '') + '"');
  gListaArquivo.Add('ldc.i4 2');
  gListaArquivo.Add('call int64 [mscorlib]System.Convert::ToInt64(string, int32)');
end;

procedure TSemantico.Acao21(sToken: TToken); //OK
begin
  gLista.Add('hexa');
  gListaArquivo.Add('ldstr "' + AnsiReplaceStr(sToken.getLexeme,'#x', '') + '"');
  gListaArquivo.Add('ldc.i4 16');
  gListaArquivo.Add('call int64 [mscorlib]System.Convert::ToInt64(string, int32)');
end;

procedure TSemantico.Acao22; //VERIFICANDO
var
  iTipo: String;
begin
  iTipo := PegaUltimoLista;
  RemoveLista;
  if (iTipo = 'bin') OR (iTipo = 'hexa') then
    gLista.Add('int64')
  else
    raise ESemanticError.create('Tipo incompativel em opera��o de convers�o de valor!');
  gListaArquivo.Add('conv.r8');
end;

procedure TSemantico.Acao23; //VERIFICANDO
var
  iTipo: String;
begin
  if (iTipo = 'int64') OR (iTipo = 'hexa') then
    gLista.Add('bin')
  else
    raise ESemanticError.create('Tipo incompativel em opera��o de convers�o de valor!');
  gListaArquivo.Add('conv.i8');
end;

procedure TSemantico.Acao24; //VERIFICANDO
var
  iTipo: String;
begin
  if (iTipo = 'int64') OR (iTipo = 'hexa') then
    gLista.Add('bin')
  else
    raise ESemanticError.create('Tipo incompativel em opera��o de convers�o de valor!');
  gListaArquivo.Add('conv.i8');
end;

procedure TSemantico.Acao25;
begin
//
end;

procedure TSemantico.Acao26;
begin
//
end;

procedure TSemantico.Acao27;
begin
//
end;

procedure TSemantico.Acao28;
begin
//
end;

procedure TSemantico.Acao29;
begin
//
end;

procedure TSemantico.Acao30(sToken: TToken);
begin
  Case AnsiIndexStr(sToken.getLexeme, ['int64', 'float64', 'bool', 'string',
                                       'bin', 'hexa']) Of
    0 : gTipo_Var := 'int64';
    1 : gTipo_Var := 'float64';
    2 : gTipo_Var := 'bool';
    3 : gTipo_Var := 'string';
    4 : gTipo_Var := 'bin';
    5 : gTipo_Var := 'hexa';
  end;
end;

procedure TSemantico.Acao31; //OK
var
  iContador, iTamanhoLista: Integer;
begin
  iContador := 0;
  iTamanhoLista := gListaIdentificadores.Count - 1;
  while iContador <= iTamanhoLista do
    begin
      if VerificaTS(gListaIdentificadores.Strings[iContador]) = True then
        raise ESemanticError.create('Identificador j� declarado!')
      gTS.Add('v' + IntToStr(iContador));
      gTS.Add(gTipo_var);
      gListaArquivo.Add('.locals ('+ gTipo_var + ' ' + 'v' + IntToStr(iContador));
      Next;
    end;
  gListaIdentificadores.Clear;
end;

procedure TSemantico.Acao32(sToken: TToken); //OK
begin
  gListaIdentificadores.Add(sToken.getLexeme);
end;

procedure TSemantico.Acao33(sToken: TToken); //OK
var
  iId, iTipoId: String;
begin
  iId := sToken.getLexeme;
  if VerificaTS(iId) = False then
    raise ESemanticError.create('Identificador n�o declarado!')
  iTipoId := PegaTipoTs(iId);
  gLista.Add(iTipoId);
  gListaArquivo.Add('ldloc ' + iId);
  if iTipoId = 'int64' then
    gListaArquivo.Add('conv.r8');
end;

procedure TSemantico.Acao34;
begin
  raise ESemanticError.create('Identificador n�o declarado!');
end;

procedure TSemantico.Acao35;
begin
  raise ESemanticError.create('Identificador n�o declarado!');
end;

procedure TSemantico.Acao36;
begin
//
end;

procedure TSemantico.Acao37;
begin
  raise ESemanticError.create('Identificador j� declarado!');
end;

procedure TSemantico.Acao38;
begin
//
end;

procedure TSemantico.Acao39;
begin
//
end;

procedure TSemantico.Acao40;
begin
//
end;

procedure TSemantico.Acao41;
begin
//
end;

procedure TSemantico.Acao42;
begin
//
end;

procedure TSemantico.Acao43;
begin
//
end;

procedure TSemantico.Acao44;
begin
//
end;

procedure TSemantico.Acao45;
begin
//
end;

{*
  pop = remover;
  push = adicionar;
  peek = pegar ultimo elemento;
*}

function TSemantico.VerificaTS(sTexto: String): Boolean;
var
  iFor: integer;
  iResultado: boolean;
begin
  iResultado := False;
  for iFor := 0 to gTS.Count - 1 do
    begin
      if gTS.Strings[iFor] = sTexto then
        begin
          iResultado := True;
          Break;
        end;
    end;
  Result := iResultado;
end;

function TSemantico.PegaTipoTs(sTexto: String): String;
var
  iFor, iCont: integer;
  iRetorno: String;
begin
  //for iFor := 0 to gTS.Count - 1 then
  while iCont <= gTS.Count - 1 do
    begin
      if gTS.Strings[iFor] = sTexto then
        begin
          iRetorno := gTS.Strings[iFor+1];
          Break;
        end;
      Inc(iCont, 2);
      Next;    
    end;
  Result := iRetorno;  
end;

end.
