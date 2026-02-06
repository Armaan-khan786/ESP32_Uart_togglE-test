@echo off
setlocal

REM ===== MOVE TO PROJECT ROOT =====
cd /d C:\Users\a7577\Desktop\esp32-uart-automation2

REM ===== ABSOLUTE PATH TO CLI =====
set ARDUINO_CLI=C:\Users\a7577\Desktop\esp32-uart-automation2\arduino-cli.exe

REM ===== CONFIG =====
set FQBN=esp32:esp32:esp32
set PORT_SENDER=COM6
set PORT_RECEIVER=COM7

echo Checking Arduino CLI...
"%ARDUINO_CLI%" version
if errorlevel 1 (
    echo ❌ Arduino CLI not reachable
    pause
    exit /b 1
)

echo ===============================
echo Flashing SENDER
echo ===============================
"%ARDUINO_CLI%" upload -p %PORT_SENDER% --fqbn %FQBN% sender\sender.ino
if errorlevel 1 exit /b 1

echo ===============================
echo Flashing RECEIVER
echo ===============================
"%ARDUINO_CLI%" upload -p %PORT_RECEIVER% --fqbn %FQBN% receiver\receiver.ino
if errorlevel 1 exit /b 1

echo ===============================
echo DONE ✅
pause
