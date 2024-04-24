@echo off

if "%~1"=="" (
    echo "Usage: ./pc.bat [StackName]"
    exit /b 1
)
set "StackName=%1"
echo StackName: %StackName%

rem Get id of EC2 instance
for /f "delims=" %%A in ('aws cloudformation describe-stack-resources --stack-name %StackName% --query "StackResources[?ResourceType=='AWS::EC2::Instance' && ResourceStatus!='DELETE_COMPLETE'].PhysicalResourceId" --output text') do (
    set "InstanceId=%%A"
)
echo InstanceId: %InstanceId%

rem Get public IP of EC2 instance
for /f "delims=" %%B in ('aws ec2 describe-instances --instance-ids %InstanceId% --query "Reservations[0].Instances[0].PublicIpAddress" --output text') do (
    set "PublicIp=%%B"
)
echo PublicIp = %PublicIp%

set "KeyPath=%USERPROFILE%\Downloads\keypair.ppk"
echo KeyPath = %KeyPath%

rem Connect using PuTTY
putty.exe -ssh -i "%KeyPath%" ec2-user@%PublicIp%
