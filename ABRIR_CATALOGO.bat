@echo off
cd /d "%~dp0"

set PUERTO=8000
set URL=http://localhost:%PUERTO%/index.html

echo.
echo Abriendo catalogo local...
echo %URL%
echo.
echo Esta ventana tiene que quedar abierta mientras probas el catalogo.
echo Para cerrar la prueba, volve a esta ventana y presiona Ctrl + C.
echo.

where py >nul 2>nul
if %ERRORLEVEL%==0 (
    start "" "%URL%"
    py -m http.server %PUERTO%
    goto fin
)

where python >nul 2>nul
if %ERRORLEVEL%==0 (
    start "" "%URL%"
    python -m http.server %PUERTO%
    goto fin
)

where python3 >nul 2>nul
if %ERRORLEVEL%==0 (
    start "" "%URL%"
    python3 -m http.server %PUERTO%
    goto fin
)

echo No encontre Python instalado en esta computadora.
echo Instala Python o avisame y te preparo otra alternativa.
echo.
pause

:fin
