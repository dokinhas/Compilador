program FMenu;

uses
  Forms,
  UMenu in 'UMenu.pas' {FMenu1},
  UConstants in 'UConstants.pas',
  UAnalysisError in 'UAnalysisError.pas',
  ULexicalError in 'ULexicalError.pas',
  ULexico in 'ULexico.pas',
  USemanticError in 'USemanticError.pas',
  USyntaticError in 'USyntaticError.pas',
  UToken in 'UToken.pas',
  USintatico in 'USintatico.pas',
  USemantico in 'USemantico.pas',
  UFuncao in 'UFuncao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Compilador Equipe 7';
  Application.CreateForm(TFMenu1, FMenu1);
  Application.Run;
end.
