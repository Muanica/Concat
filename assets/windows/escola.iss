; O instalador do Concat para a escola: um só .exe.
;
; Leva dentro a pasta que o fluxo escola.yml monta - o programa, as
; definições já escolhidas e os modelos das legendas - e põe-na onde o
; utilizador pode escrever, sem pedir administrador: os computadores de
; uma escola não o dão às crianças, e o Concat precisa de escrever ao lado
; do executável para guardar as suas definições (pasta `portable`).
;
; Corre com o Inno Setup, a partir de escola.yml:
;
;   iscc /DVersion=7 /DStage=C:\...\pacote /DOut=C:\...\saida assets\windows\escola.iss
;
; É uma instalação à parte do Concat normal (outro AppId, outra pasta): as
; duas convivem, e a da escola não toca nas definições de quem já tem o
; Concat instalado.
;
; Um ficheiro instalado por este programa não leva a marca "veio da
; internet" que o Windows põe no que se descarrega, ao contrário do que
; acontece com um ZIP extraído. Só o próprio instalador a leva, e é por
; ela que o Windows mostra o aviso azul da primeira vez.

#ifndef Version
  #error Version is required
#endif
#ifndef Stage
  #error Stage is required: the folder to install
#endif
#ifndef Out
  #define Out "."
#endif

[Setup]
AppId={{5D2C8B7E-6A41-4E3B-8F0D-9C1B7A3E5F26}
AppName=Concat Escola
AppVersion={#Version}
AppVerName=Concat Escola {#Version}
AppPublisher=Concat contributors
AppPublisherURL=https://github.com/jub0t/Concat
DefaultDirName={userpf}\Concat Escola
DefaultGroupName=Concat Escola
DisableProgramGroupPage=yes
DisableDirPage=yes
DisableReadyPage=yes
OutputDir={#Out}
OutputBaseFilename=Concat-Escola-Setup
SetupIconFile=..\icons\concat.ico
UninstallDisplayIcon={app}\concat.ico
UninstallDisplayName=Concat Escola
; Os modelos das legendas já vêm comprimidos e o resto é um programa: o
; modo rápido poupa minutos à compilação e quase nada ao tamanho.
Compression=lzma2/fast
SolidCompression=yes
WizardStyle=modern
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
; Só para o utilizador, e sem a pergunta que a instalação normal faz.
PrivilegesRequired=lowest
ShowLanguageDialog=no
CloseApplications=yes

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
; Tudo menos as definições, que vão à parte: ao reinstalar por cima, as
; definições que o professor mudou ficam como estão.
Source: "{#Stage}\*"; DestDir: "{app}"; Excludes: "portable\settings.json"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#Stage}\portable\settings.json"; DestDir: "{app}\portable"; Flags: onlyifdoesntexist
Source: "..\icons\concat.ico"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{autoprograms}\Concat Escola"; Filename: "{app}\concat.exe"; IconFilename: "{app}\concat.ico"
; A saída quando o controlador gráfico desenha a janela aos quadrados:
; desliga o desenho na placa gráfica, e a janela que o liga não se vê.
Name: "{autoprograms}\Concat Escola (gráficos seguros)"; Filename: "{app}\concat.exe"; Parameters: "--software"; IconFilename: "{app}\concat.ico"
Name: "{autodesktop}\Concat Escola"; Filename: "{app}\concat.exe"; IconFilename: "{app}\concat.ico"; Tasks: desktopicon

[Run]
Filename: "{app}\concat.exe"; Description: "{cm:LaunchProgram,Concat Escola}"; Flags: nowait postinstall skipifsilent
