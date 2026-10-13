@echo off
chcp 65001 >nul
title Subir Maquinas a GitHub
setlocal enabledelayedexpansion
cd /d "%~dp0"

set "WEB=https://bernardotorio.github.io/maquinas/"
set "DESC=%USERPROFILE%\Downloads"

echo ============================================
echo   Subir Maquinas Electricas (2MB) a GitHub
echo   Carpeta: %CD%
echo ============================================
echo.

rem --- 1. Buscar maquinas.zip: primero en esta carpeta, luego en Descargas ---
set "ZIP="
for %%f in ("%CD%\maquinas*.zip") do (
  echo %%~nf | findstr /i "_subido" >nul || set "ZIP=%%~ff"
)
if not defined ZIP (
  for %%f in ("%DESC%\maquinas*.zip") do (
    echo %%~nf | findstr /i "_subido" >nul || set "ZIP=%%~ff"
  )
)

for /f %%d in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmm"') do set "STAMP=%%d"

if defined ZIP (
  echo Encontrado: !ZIP!
  echo Contenido del zip:
  tar -tf "!ZIP!"
  echo.
  tar -xf "!ZIP!" -C "%CD%"
  if errorlevel 1 (
    echo ERROR al descomprimir el zip.
    goto fin
  )
  move /y "!ZIP!" "%DESC%\maquinas_subido_!STAMP!.zip" >nul
  echo Zip descomprimido y apartado en Descargas como maquinas_subido_!STAMP!.zip
  echo.
) else (
  echo No hay ningun maquinas.zip nuevo: se sube lo que haya en la carpeta.
  echo.
)

rem --- 2. Ordenar: los PDF van en temas\ y practicas\, no en la raiz ---
rem     Temas: T1_..._Maquinas.pdf   Practicas: P1_Maquinas.pdf, P2_Maquinas.pdf...
if not exist "temas" mkdir "temas"
if not exist "practicas" mkdir "practicas"
for %%f in (T*_Maquinas.pdf) do move /y "%%f" "temas\" >nul
for %%f in (P*_Maquinas.pdf) do move /y "%%f" "practicas\" >nul
if not exist ".nojekyll" type nul > ".nojekyll"

rem --- 3. Nunca subir zips ni docx ---
findstr /x /c:"*.zip" .gitignore >nul 2>&1 || echo *.zip>>.gitignore
findstr /x /c:"*.docx" .gitignore >nul 2>&1 || echo *.docx>>.gitignore
git rm -r --cached -q --ignore-unmatch *.zip *.docx >nul 2>&1

rem --- 4. Commit y push ---
git add -A
git diff --cached --quiet
if not errorlevel 1 (
  echo No hay cambios que subir: todo esta ya en GitHub.
  goto listo
)
echo Archivos que cambian:
git diff --cached --name-status
echo.
git commit -q -m "Actualizacion %date% %time:~0,5%"
git push -u origin main
if errorlevel 1 (
  echo.
  echo *** ERROR al subir. Revisa el mensaje de arriba. ***
  goto fin
)

:listo
echo.
echo Publicado en %WEB%
echo (tarda uno o dos minutos; recarga con Ctrl+F5)
start "" "%WEB%"

:fin
echo.
pause
