@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
title ChefMerge - Samsung Galaxy S25 Telefona Yukleme
color 0A

echo =====================================================================
echo           CHEFMERGE: SAMSUNG GALAXY S25 TELEFONA YUKLEME
echo =====================================================================
echo.

REM Otomatik Flutter ve Proje Yolu Tespiti
set "PROJECT_DIR=%~dp0"
set "FLUTTER_EXE="

if exist "%USERPROFILE%\.puro\envs\stable\flutter\bin\flutter.bat" (
    set "FLUTTER_EXE=%USERPROFILE%\.puro\envs\stable\flutter\bin\flutter.bat"
) else if exist "%USERPROFILE%\flutter\bin\flutter.bat" (
    set "FLUTTER_EXE=%USERPROFILE%\flutter\bin\flutter.bat"
) else if exist "C:\Users\Developer6\flutter\bin\flutter.bat" (
    set "FLUTTER_EXE=C:\Users\Developer6\flutter\bin\flutter.bat"
) else if exist "C:\Users\Superuser\flutter\bin\flutter.bat" (
    set "FLUTTER_EXE=C:\Users\Superuser\flutter\bin\flutter.bat"
) else if exist "C:\flutter\bin\flutter.bat" (
    set "FLUTTER_EXE=C:\flutter\bin\flutter.bat"
) else (
    where flutter >nul 2>nul
    if %errorlevel% equ 0 (
        set "FLUTTER_EXE=flutter"
    ) else (
        echo [HATA] Flutter bulunamadi.
        pause
        exit /b 1
    )
)

echo [1/3] Proje dizinine geciliyor...
cd /d "%PROJECT_DIR%"
echo Dizin: %PROJECT_DIR%
echo.

echo [2/3] Bagli cihazlar taranıyor...
call "%FLUTTER_EXE%" devices
echo.

echo [3/3] ChefMerge oyunu Samsung S25 cihazina derlenip yukleniyor...
echo (Bu islem Gradle derlemesi nedeniyle 1-2 dakika surebilir, lutfen bekleyiniz...)
echo.

call "%FLUTTER_EXE%" run -d RFCY41DK45X

if %errorlevel% neq 0 (
    echo.
    echo [BILGI] Spesifik cihaz kimligi yerine genel Android baglantisi deneniyor...
    call "%FLUTTER_EXE%" run -d android
)

echo.
echo =====================================================================
echo Islem tamamlandi. Pencereyi kapatmak icin herhangi bir tusa basin...
echo =====================================================================
pause
