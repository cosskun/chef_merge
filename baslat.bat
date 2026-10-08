@echo off
setlocal EnableDelayedExpansion
title ChefMerge - Lezzet Birlestir Baslatici
cd /d "%~dp0"

REM Flutter komutunu tespit et
set "FLUTTER_CMD="
if exist "%USERPROFILE%\.puro\envs\stable\flutter\bin\flutter.bat" (
    set "FLUTTER_CMD=%USERPROFILE%\.puro\envs\stable\flutter\bin\flutter.bat"
) else (
    where flutter >nul 2>nul
    if %errorlevel% equ 0 (
        set "FLUTTER_CMD=flutter"
    ) else (
        where puro >nul 2>nul
        if %errorlevel% equ 0 (
            set "FLUTTER_CMD=puro flutter"
        ) else if exist "%USERPROFILE%\flutter\bin\flutter.bat" (
            set "FLUTTER_CMD=%USERPROFILE%\flutter\bin\flutter.bat"
        ) else if exist "C:\Users\Developer6\flutter\bin\flutter.bat" (
            set "FLUTTER_CMD=C:\Users\Developer6\flutter\bin\flutter.bat"
        ) else if exist "C:\flutter\bin\flutter.bat" (
            set "FLUTTER_CMD=C:\flutter\bin\flutter.bat"
        ) else (
            set "FLUTTER_CMD=flutter"
        )
    )
)

:MENU
cls
echo ===============================================================
echo            CHEFMERGE - LEZZET BIRLESTIR OYUNU
echo ===============================================================
echo.
echo  [1] Web Tarayicida Baslat (TAVSIYE EDILEN - Hizli ve Kesintisiz)
echo  [2] Web Surumunu Yeniden Derle ve Baslat (Guncel Kodlar/Resimler)
echo  [3] Bagli Telefona Yukle ve Calistir (flutter run)
echo  [4] Android APK Paketi Olustur (flutter build apk)
echo  [5] Bagli Cihazlari Listele (flutter devices)
echo  [6] Paketleri Yenile (flutter pub get)
echo  [7] Projeyi Temizle (flutter clean)
echo  [0] Cikis
echo.
echo ===============================================================
set "SECIM=1"
set /p "SECIM=Lutfen bir secim yapin [Varsayilan: 1]: "

if "%SECIM%"=="1" goto RUN_WEB_FAST
if "%SECIM%"=="2" goto REBUILD_AND_RUN_WEB
if "%SECIM%"=="3" goto RUN_DEVICE
if "%SECIM%"=="4" goto BUILD_APK
if "%SECIM%"=="5" goto LIST_DEVICES
if "%SECIM%"=="6" goto PUB_GET
if "%SECIM%"=="7" goto CLEAN_PROJECT
if "%SECIM%"=="0" goto CIKIS
goto GECERSIZ

:RUN_WEB_FAST
echo.
if not exist "build\web\index.html" (
    echo [*] Ilk kurulum: Web surumu derleniyor, lutfen bekleyin...
    call "%FLUTTER_CMD%" build web --no-tree-shake-icons
)
echo [*] ChefMerge Sunucusu baslatiliyor (http://localhost:8088)...
echo [*] Tarayiciniz otomatik olarak acilacaktir...
echo.
node server.js
goto BITTI

:REBUILD_AND_RUN_WEB
echo.
echo [*] Web paketi en guncel kaynak kodlarla derleniyor...
call "%FLUTTER_CMD%" build web --no-tree-shake-icons
echo.
echo [*] ChefMerge Sunucusu baslatiliyor (http://localhost:8088)...
node server.js
goto BITTI

:RUN_DEVICE
echo.
echo [*] Bagli telefon / cihaz tespit ediliyor ve oyun yukleniyor...
echo.
call "%FLUTTER_CMD%" run
goto BITTI

:BUILD_APK
echo.
echo [*] Android APK dosyasi derleniyor (Release mod)...
echo.
call "%FLUTTER_CMD%" build apk --release
echo.
echo [*] APK olusturuldu! Konum: build\app\outputs\flutter-apk\app-release.apk
echo.
pause
goto MENU

:LIST_DEVICES
echo.
echo [*] Bagli cihazlar ve emulatorler araniyor...
echo.
call "%FLUTTER_CMD%" devices
echo.
pause
goto MENU

:PUB_GET
echo.
echo [*] Paketler guncelleniyor...
echo.
call "%FLUTTER_CMD%" pub get
echo.
pause
goto MENU

:CLEAN_PROJECT
echo.
call "%FLUTTER_CMD%" clean
echo.
pause
goto MENU

:GECERSIZ
echo.
echo [!] Gecersiz bir secim yaptiniz. Lutfen tekrar deneyin.
timeout /t 2 >nul
goto MENU

:BITTI
echo.
echo ===============================================================
echo  Oyun oturumu tamamlandi veya kapatildi.
echo ===============================================================
echo.
pause
goto MENU

:CIKIS
exit /b 0
