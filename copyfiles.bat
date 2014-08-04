@echo off

:: this should be run in the dotfiles directory

IF NOT EXIST .\COPYFILES.BAT GOTO :FAIL

XCOPY /F /Y vimrc %HOMEDRIVE%%HOMEPATH%\_vimrc
robocopy vim %HOMEDRIVE%%HOMEPATH%\vimfiles\ /MIR

GOTO :END

:FAIL
echo "ERROR! Not running from dotfiles directory?"

:END
