@echo off
cd /d "%~dp0"
title Publish Dashboard SE2026 ke GitHub
where python >nul 2>nul
if %errorlevel%==0 (set PY=python) else (set PY=py)

echo ============================================================
echo   PUBLISH DASHBOARD SE2026 KE GITHUB PAGES
echo ============================================================
echo.
echo [1/3] Membangun index.html dari SQLPad.xlsx ...
%PY% "_build\gen_data.py"
if errorlevel 1 goto err
%PY% "_build\assemble.py"
if errorlevel 1 goto err
echo.

echo [2/3] Memastikan koneksi GitHub (auto-perbaiki bila pindah komputer) ...
%PY% "_build\ensure_git.py"
if errorlevel 1 goto err
echo.

echo [3/3] Commit ^& Push ke GitHub ...
git add -A
git commit -m "Update data %date% %time%"
git push
if errorlevel 1 goto err

echo.
echo ============================================================
echo   SELESAI. Situs ter-update dalam ~1-2 menit di GitHub Pages.
echo ============================================================
pause
exit /b 0

:err
echo.
echo *** GAGAL. Periksa pesan error di atas. ***
echo   - Pastikan SQLPad.xlsx ada di folder ini.
echo   - Pastikan 'git remote' & GitHub Pages sudah disetel (lihat README.md).
echo.
pause
exit /b 1
