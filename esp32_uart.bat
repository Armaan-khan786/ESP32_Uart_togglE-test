@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

REM Move to project root
cd /d C:\Users\a7577\Desktop\esp32-uart-automation2

REM ========= USER CONFIG =========
set ARDUINO_CLI=arduino-cli.exe
set FQBN=esp32:esp32:esp32
set PORT_SENDER=COM6
set PORT_RECEIVER=COM7
set BAUD=115200

REM ========= VERIFY CLI =========
"%ARDUINO_CLI%" version
if errorlevel 1 (
    echo ERROR: Arduino CLI not found
    exit /b 1
)

REM ========= FLASH SENDER =========
echo ======================================
echo Flashing ESP32 Sender
echo ======================================
"%ARDUINO_CLI%" upload -p %PORT_SENDER% --fqbn %FQBN% sender\sender.ino
if errorlevel 1 (
    echo ERROR: Sender flash failed
    exit /b 1
)

REM ========= FLASH RECEIVER =========
echo ======================================
echo Flashing ESP32 Receiver
echo ======================================
"%ARDUINO_CLI%" upload -p %PORT_RECEIVER% --fqbn %FQBN% receiver\receiver.ino
if errorlevel 1 (
    echo ERROR: Receiver flash failed
    exit /b 1
)

REM ========= WAIT FOR BOOT =========
echo Waiting for ESP32 boot...
timeout /t 5 >nul

REM ========= RUN TOGGLE TEST =========
echo ======================================
echo Running UART TOGGLE test
echo ======================================

"%ARDUINO_CLI%" monitor -p %PORT_RECEIVER% -c baudrate=%BAUD% ^
 | findstr /C:"UART TOGGLE TEST PASS"

if errorlevel 1 (
    echo ======================================
    echo UART TOGGLE TEST FAILED
    echo ======================================
    exit /b 1
)

echo ======================================
echo UART TOGGLE TEST PASSED
echo ======================================
exit /b 0
