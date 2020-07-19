unit UMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, ClipBrd, StrUtils, Contnrs;

type
  TFMenu1 = class(TForm)
    Panel1: TPanel;
    memEditor: TMemo;
    memLinhas: TMemo;
    stbStatus: TStatusBar;
    btnNovo: TSpeedButton;
    btnAbrir: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnCopiar: TSpeedButton;
    btnColar: TSpeedButton;
    btnRecortar: TSpeedButton;
    btnCompilar: TSpeedButton;
    btnEquipe: TSpeedButton;
    memMensagens: TMemo;
    opDlg: TOpenDialog;
    svDlg: TSaveDialog;
    procedure btnNovoClick(Sender: TObject);
    procedure btnAbrirClick(Sender: TObject);
    procedure preencheMemoLinhas;
    procedure ScrollWndProc(var Message: TMessage);
    procedure btnEquipeClick(Sender: TObject);
    procedure memEditorChange(Sender: TObject);
    procedure btnCompilarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memEditorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memMensagensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memLinhasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCopiarClick(Sender: TObject);
    procedure btnColarClick(Sender: TObject);
    procedure btnRecortarClick(Sender: TObject);
    procedure WMGetMinMaxInfo(var MSG: TMessage); message WM_GetMinMaxInfo;
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    function ContarQuebraLinha(sPosicao: String): String;
    procedure exibirMensagemLexico(sLinha, sClasse, sLexema: String);
    function espacoBranco(sTexto: String; sTipo: Integer): String;
    function pegaClasse(sTexto: String): String;
    function PegaErroSintatico(sPosicao: integer) : String;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    SavedScrollProc :TWndMethod;
  public
    { Public declarations }
  end;  

var
  FMenu1: TFMenu1;
  gCaminho: String;
  gPilha: TObjectStack;
implementation

uses
  ULexico, UToken, UConstants, ULexicalError, USemanticError, USyntaticError, UAnalysisError,
  USintatico, USemantico, UFuncao;

{$R *.dfm}

{ TFMenu1 }

procedure TFMenu1.btnNovoClick(Sender: TObject);
begin
  gCaminho := '';
  memEditor.Lines.Clear;
  memMensagens.Lines.Clear;
  stbStatus.Panels[0].Text := '';
  preencheMemoLinhas;
end;

procedure TFMenu1.btnAbrirClick(Sender: TObject);
var
  iNomeArq, iLinha, iArq, iExtencao: string;
  iFile: TextFile;
  iContador, iNaoTxt: integer;
begin
  //Abre o arquivo
  iNaoTxt := 0;
  iNomeArq := '';
  opDlg.InitialDir := ExtractFilePath(Application.ExeName);
  if opDlg.Execute then
    begin
      iArq := opDlg.FileName;
      try
        iExtencao := copy(iArq, pos('.', iArq),4);
        if iExtencao <> '.txt' then
          begin
            ShowMessage('O arquivo selecionado deve ser um .txt');
            iNaoTxt := 1;
            abort;
          end;
      except
      end;
        if iNaoTxt = 1 then
          abort;
        iNomeArq := ExtractFilePath(iArq) + ExtractFileName(iArq);
    end;

  //Se nenhum arquivo for selecionado, aborta a opera��o
  if iNomeArq = '' then
    abort;

  gCaminho := iNomeArq;  
  //Preenche o editor
  Screen.Cursor := crHourGlass;
  AssignFile(iFile, iNomeArq);
  Reset(iFile);
  ReadLn(iFile, iLinha);
  while not eof(iFile) do
    begin
      inc(iContador);
      memEditor.Lines.Add(iLinha);
      if iContador > 24 then
        begin
          memLinhas.Lines.Add(IntToStr(iContador));
        end;
      ReadLn(iFile, iLinha);
    end;
  memEditor.Lines.Add(iLinha);
  Closefile(iFile);  
  //Limpar barra de mensagens
  memMensagens.Lines.Clear;
  //Atualizar barra de estatus
  stbStatus.Panels[0].Text := '  ' + iNomeArq;
  Screen.Cursor := crDefault;
end;

procedure TFMenu1.preencheMemoLinhas;
var
  iFor: integer;
begin
  memLinhas.Lines.Clear;
  for iFor := 1 to 24 do
    begin
      memLinhas.Lines.Add(IntToStr(iFor));
    end;
  SendMessage(memLinhas.Handle, WM_VSCROLL, SB_TOP, 0);
end;

procedure TFMenu1.ScrollWndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_HSCROLL,  // ver help API - Scroll Bar Reference
    WM_VSCROLL,
    SBM_SETRANGE,
    SBM_SETRANGEREDRAW,
    SBM_SETPOS :
      memLinhas.Dispatch(Message);  // transfere mensagens para memo2
  end;
  SavedScrollProc(Message);  // chama o WindowProc padr�o do memo1
end;

procedure TFMenu1.btnEquipeClick(Sender: TObject);
begin
  memMensagens.Lines.Add('Artur Dallagnelo' + #13#10 + 'Camila Carolina Bowens' + #13#10 + 'Maik Henrique Carminati');
end;

procedure TFMenu1.memEditorChange(Sender: TObject);
begin
  if not Assigned(SavedScrollProc) then
    begin
      SavedScrollProc := memEditor.WindowProc;  //Salva WindowProc do memo1
      memEditor.WindowProc := ScrollWndProc;  //Atribui novo procedimento
     //Para que o scroll horizontal se reflita no memo2
      ShowScrollBar(memLinhas.handle, SB_HORZ, False);
    end;
end;

procedure TFMenu1.btnCompilarClick(Sender: TObject);
var
  lexico : TLexico;
  sintatico: TSintatico;
  semantico: TSemantico;
  t, e: TToken;
begin
  memMensagens.Clear;
  //memMensagens.Lines.Add('Compila��o de programas ainda n�o foi implementada!');
  //...
  lexico := TLexico.create;
  sintatico := TSintatico.create;
  //...
  lexico.setInput( memEditor.Text (* entrada *));
  //memMensagens.Lines.Add('linha   classe                    lexema');
  //...
  try
    sintatico.parse(lexico, semantico);
  except
    on e : ESyntaticError do
      begin
        memMensagens.Lines.Text := 'Erro na linha ' + ContarQuebraLinha(IntToStr(e.getPosition)) + ' - Encontrado ' + PegaErroSintatico(e.getPosition){+ t.getLexeme} + '    ' + e.getMessage;
        Abort;
      end;
    on e : ELexicalError do
      begin
        memMensagens.Lines.Text := 'Erro na linha ' + ContarQuebraLinha(IntToStr(e.getPosition)) + ' - ' {+ t.getLexeme} + ' ' + e.getMessage;
        Abort;
      end;
  end;
  memMensagens.Lines.Text := 'Programa compilado com sucesso ';
  {try
    t := lexico.nextToken;
    while (t <> nil) do
      begin
        //exibirMensagemLexico(intToStr(t.getPosition), IntToStr(t.getId), t.getLexeme);
        t.Destroy;
        t := lexico.nextToken;
      end;
    memMensagens.Lines.Add('Programa compilado com sucesso');
  except on e : ELexicalError do
      memMensagens.Lines.Text := 'Erro na linha ' + ContarQuebraLinha(IntToStr(e.getPosition)) + ' - ' + t.getLexeme + ' ' + e.getMessage;
  end; }
  //...
  lexico.destroy;
end;

procedure TFMenu1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F1:
      begin
        btnEquipeClick(Self);
      end;
    VK_F9:
      begin
        btnCompilarClick(Self);
      end;
  end;
  //ctrl + n
  if (ssCtrl in Shift) AND ((key = 78) OR (key = 110)) then
    begin
      btnNovoClick(Self);
    end;
  //ctrl + o
  if (ssCtrl in Shift) AND ((key = 79) OR (key = 111)) then
    begin
      btnAbrirClick(Self);
    end;
  //ctrl + s
  if (ssCtrl in Shift) AND ((key = 83) OR (key = 115)) then
    begin
      btnSalvarClick(Self);
    end;
  //ctrl + c
  if (ssCtrl in Shift) AND ((key = 67) OR (key = 99)) then
    begin
      btnCopiarClick(Self);
    end;
  //ctrl + v
  if (ssCtrl in Shift) AND ((key = 86) OR (key = 118)) then
    begin
      btnColarClick(Self);
    end;
  //ctrl + x
  if (ssCtrl in Shift) AND ((key = 88) OR (key = 120)) then
    begin
      btnRecortarClick(Self);
    end;
end;

procedure TFMenu1.memEditorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FMenu1.KeyDown(key, shift);  
end;

procedure TFMenu1.memMensagensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FMenu1.KeyDown(key, shift); 
end;

procedure TFMenu1.memLinhasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FMenu1.KeyDown(key, shift); 
end;

procedure TFMenu1.btnSalvarClick(Sender: TObject);
var
  iNomeArq, iArq: String;
  iFile: TextFile;
  iFor: integer;
begin
  if gCaminho <> '' then
    begin
      Windows.DeleteFile(PChar(gCaminho));//Arquivo antigo
      AssignFile(iFile, gCaminho);
      //Abre o arquivo para escrita
      Rewrite(iFile);
      //for iFor := 0 to memEditor.Lines.Count - 1 do
        //begin
          //Grava ad linhas do memEditor
          Writeln(iFile, memEditor.Lines.Text);
        //end;
      //Fecha o handle de arquivo
      Closefile(iFile);

      memMensagens.Lines.Clear;
    end
  else
    begin
      iNomeArq := '';
      if svDlg.Execute then
        begin
          iArq := svDlg.FileName;
          iNomeArq := ExtractFilePath(iArq) + ExtractFileName(iArq) + '.txt';
        end;

      if iNomeArq = '' then
        abort;

      AssignFile(iFile, iNomeArq);
      //Abre o arquivo para escrita
      Rewrite(iFile);
      //for iFor := 0 to memEditor.Lines.Count - 1 do
        //begin
          //Grava ad linhas do memEditor
          Write(iFile, memEditor.Lines.Text);
        //end;
      //Fecha o handle de arquivo
      Closefile(iFile);

      memMensagens.Lines.Clear;
      stbStatus.Panels[0].Text := iNomeArq;
    end;
end;

procedure TFMenu1.btnCopiarClick(Sender: TObject);
begin
  Clipboard.AsText := memEditor.SelText;
end;

procedure TFMenu1.btnColarClick(Sender: TObject);
begin
  memEditor.SelText := Clipboard.AsText;
end;

procedure TFMenu1.btnRecortarClick(Sender: TObject);
begin
  Clipboard.AsText := memEditor.SelText;
  memEditor.SelText := '';
end;

procedure TFMenu1.WMGetMinMaxInfo(var MSG: TMessage);
begin
  inherited;
  with PMinMaxInfo(MSG.lparam)^ do
    begin
      ptMinTRackSize.X := 800;
      ptMinTRackSize.Y := 502;
      ptMaxTRackSize.X := 931;
      ptMaxTRackSize.Y := 633;
    end;
end;

procedure TFMenu1.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  I: Integer;
begin
  Handled := PtInRect(memEditor.ClientRect, memEditor.ScreenToClient(MousePos));
  if Handled then
    for I := 1 to Mouse.WheelScrollLines do
      try
        if WheelDelta > 0 then
          begin
            memEditor.Perform(WM_VSCROLL, SB_LINEUP, 0) ;
            memLinhas.Perform(WM_VSCROLL, SB_LINEUP, 0)  ;
          end
        else
          begin
            memEditor.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
            memLinhas.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
          end;
      finally
        begin
          memEditor.Perform(WM_VSCROLL, SB_ENDSCROLL, 0);
          memLinhas.Perform(WM_VSCROLL, SB_ENDSCROLL, 0);
        end;
    end;
end;

function TFMenu1.ContarQuebraLinha(sPosicao: String): String;
var
  iQuebras, iFor, iTexto: integer;
  iLista: TCaption;
begin
  iQuebras := 0;
  //Contar quebras de linhas
  iLista := Copy(memEditor.Text, 0, StrToInt(sPosicao));
  for iFor := 0 to StrToInt(sPosicao) do
    begin
      if iLista[iFor] = #13 then
        iQuebras := iQuebras + 1;
    end;
  iQuebras := iQuebras + 1;  
  Result := IntToStr(iQuebras);
end;

procedure TFMenu1.exibirMensagemLexico(sLinha, sClasse, sLexema: String);
var
  iMensagem: String;
begin
  iMensagem := '';
  iMensagem := EspacoBranco(ContarQuebraLinha(sLinha), 1);
  //iMensagem := iMensagem + espacoBranco(pegaClasse(sClasse), 2);
  iMensagem := iMensagem + pegaClasse(sClasse);
  iMensagem := iMensagem + sLexema;
  memMensagens.Lines.Add(iMensagem);
  memMensagens.SetFocus;
end;

function TFMenu1.EspacoBranco(sTexto: String; sTipo: Integer): String;
begin
  //Espa�o branco
  //N�o est� mais sendo utilizado
  if sTipo = 1 then
    begin
      while Length(sTexto) <> 9 do
        begin
          sTexto := sTexto + ' ';
        end;
    end
  else if sTipo = 2 then
    begin
      while Length(sTexto) <> 22 do
        begin
          sTexto := sTexto + ' ';
        end;
    end;
  Result := sTexto;
end;

function TFMenu1.pegaClasse(sTexto: String): String;
begin
  //Classe das mensagens
  Case StrToInt(sTexto) of
    2:
      begin
        Result := 'identificador            ';
      end;
    3:
      begin
        Result := 'Constante inteira     ';
      end;
    4:
      begin
        Result := 'constante real         ';
      end;
    5:
      begin
        Result := 'contante binaria      ';
      end;
    6:
      begin
        Result := 'constante exadecimal  ';
      end;
    7:
      begin
        Result := 'constante string      ';
      end;
    8..28:
      begin
        Result := 'palavra reservada     ';
      end;
    29..48:
      begin
        Result := 's�mbolo especial     ';
      end
    else
      begin
        Result := 'n�o especificado     ';
      end;
  end;
end;

function TFMenu1.PegaErroSintatico(sPosicao: integer): String;
var
  iFor, iContador, iTamanho: integer;
  iTexto, iAtual, iAntigo: String;
begin
  iTexto := '';
  iContador := 0;
  while iContador <> memEditor.Lines.Count do
    begin
      iTexto := memEditor.Lines.Strings[iContador];
      iTamanho := Length(memEditor.Lines.Strings[iContador]);
      if iTamanho >= sPosicao then
        begin
          For iFor := 0 to sPosicao do
            begin
              if iTexto[iFor] = ' ' then
                begin
                  iAntigo := iAtual;
                  iAtual := '';
                end
              else
                begin
                  iAtual := iAtual + iTexto[iFor];
                end;
            end;
          sPosicao := sPosicao - iTamanho -1;
        end
      else
        begin
          sPosicao := sPosicao - iTamanho -1;  
        end;
      Inc(iContador);    
    end;
  Result := iAtual;
end;

procedure TFMenu1.FormCreate(Sender: TObject);
begin
  {UFuncao.}gPilha := TObjectStack.Create;
end;

end.
