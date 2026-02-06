@echo off
setlocal

cd /d C:\Users\a7577\Desktop\esp32-uart-automation2

set ARDUINO_CLI=C:\Users\a7577\Desktop\esp32-uart-automation2\arduino-cli.exe
set FQBN=esp32:esp32:esp32
set PORT_SENDER=COM6
set PORT_RECEIVER=COM7

echo Checking Arduino CLI...
"%ARDUINO_CLI%" version || exit /b 1

echo Flashing sender...
"%ARDUINO_CLI%" upload -p %PORT_SENDER% --fqbn %FQBN% sender\sender.ino || exit /b 1

echo Flashing receiver...
"%ARDUINO_CLI%" upload -p %PORT_RECEIVER% --fqbn %FQBN% receiver\receiver.ino || exit /b 1

echo ✅ FLASH SUCCESS
pause
