@echo off

rem Check if the number of arguments is 1
if "%~1"=="" (
    echo "Usage: ./keypair.bat [c|d|g]"
    exit /b 1
)

set "KeyPairName=keypair"

if "%1"=="c" (
    aws ec2 create-key-pair --key-name %KeyPairName% --key-type rsa --key-format ppk --query "KeyMaterial" --output text > %USERPROFILE%\Downloads\keypair.ppk
) else if "%1"=="d" (
    aws ec2 delete-key-pair --key-name %KeyPairName%
) else if "%1"=="g" (
    aws ec2 get-key-pair --key-name %KeyPairName% --key-format ppk --query "KeyMaterial" --output text > %USERPROFILE%\Downloads\keypair.ppk
) else (
    echo Invalid option: %1
    echo "Usage: ./keypair.bat [c|d|g]"
    exit /b 1
)
