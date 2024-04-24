@echo off
rem Check if the number of arguments is 1
if "%~1"=="" (
    echo "Usage: ./start.bat [LabName]"
    exit /b 1
)

./keypair.bat c

./cloudformation.bat .\ec2.yaml %1 c

./putty_connect.bat %1
