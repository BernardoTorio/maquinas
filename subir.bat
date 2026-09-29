@echo off
chcp 65001 >nul
title Subir animaciones de Maquinas a GitHub
setlocal
cd /d "%~dp0"

set "REPO=BernardoTorio/maquinas"
set "WEB=https://bernardotorio.github.io/maquinas/"
set "ZIP=%USERPROFILE%\Downloads\maquinas.zip"

echo ============================================
echo   Subir animaciones de Maquinas a GitHub
echo   Carpeta: %CD%
echo ============================================
echo.

rem --- 1. Si hay un maquinas.zip nuevo en Descargas, se descomprime aqui ---
if not exist "%ZIP%" goto sinzip
echo Encontrado maquinas.zip en Descargas: descomprimiendo...
tar -xf "%ZIP%" -C "%CD%"
if errorlevel 1 (
  echo ERROR al descomprimir el zip.
  goto fin
)
for /f %%d in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmm"') do set "STAMP=%%d"
ren "%ZIP%" "maquinas_subido_%STAMP%.zip"
echo Zip descomprimido. En Descargas queda como maquinas_subido_%STAMP%.zip
echo.
:sinzip

rem --- 2. Primera vez: crear el repositorio y activar GitHub Pages ---
if not exist ".git" (
  echo Primera vez: creando el repositorio %REPO%...
  git init -b main
  if not exist ".nojekyll" type nul > .nojekyll
  git add -A
  git commit -m "Primera subida de las animaciones de Maquinas Electricas"
  gh repo create %REPO% --public --source=. --remote=origin --push --description "Animaciones de Maquinas Electricas (2MB) - I.E.S. Trinidad Arroyo"
  if errorlevel 1 (
    echo ERROR al crear el repositorio. Comprueba "gh auth status".
    goto fin
  )
  gh api -X POST repos/%REPO%/pages -f "source[branch]=main" -f "source[path]=/" >nul 2>&1
  echo Repositorio creado y GitHub Pages activado.
  goto listo
)

rem --- 3. Subida normal: añadir, commit y push ---
git add -A
git diff --cached --quiet
if not errorlevel 1 (
  echo No hay cambios que subir: todo esta ya en GitHub.
  goto listo
)
echo Archivos que cambian:
git diff --cached --name-status
echo.
for /f "delims=" %%d in ('powershell -NoProfile -Command "Get-Date -Format 'yyyy-MM-dd HH:mm'"') do set "FECHA=%%d"
git commit -m "Actualizacion de animaciones %FECHA%"
git push
if errorlevel 1 (
  echo.
  echo ERROR al hacer push. Revisa la conexion o "gh auth status".
  goto fin
)

:listo
echo.
echo ============================================
echo   Hecho. En 1 o 2 minutos estara en:
echo   %WEB%
echo   (si ves la version vieja, recarga con Ctrl+F5)
echo ============================================
start "" "%WEB%"

:fin
echo.
pause
