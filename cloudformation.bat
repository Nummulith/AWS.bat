@echo off

rem Check if the number of arguments is 3
if "%~3"=="" (
    echo "Usage: ./cf.bat [TemplateFile] [StackName] [c|d|r]"
    exit /b 1
)

rem Extract the arguments
set "TemplateFile=%1"
set "StackName=%2"

rem Action
set "ActionDelete=false"
set "ActionCreate=false"
if "%3"=="c" (
    set "ActionCreate=true"
) else if "%3"=="d" (
    set "ActionDelete=true"
) else if "%3"=="r" (
    set "ActionDelete=true"
    set "ActionCreate=true"
) else (
    echo Invalid option: %3
    echo "Usage: ./cf.bat [TemplateFile] [StackName] [c|d|r]"
    exit /b 1
)

rem Perform action based on the provided option
if "%ActionDelete%"=="true" (
    echo Wait for %StackName% to be deleted...
    aws cloudformation delete-stack --stack-name %StackName%
    aws cloudformation wait stack-delete-complete --stack-name %StackName%
    echo Done
)
if "%ActionCreate%"=="true" (
    echo Wait for %StackName% to be created...
    aws cloudformation create-stack --stack-name %StackName% --template-body file://%TemplateFile%
    aws cloudformation wait stack-create-complete --stack-name %StackName%
    echo Done
)
