set "LabName=LAB"

aws ec2 create-key-pair --key-name keypair --key-type rsa --key-format ppk --query "KeyMaterial" --output text > %USERPROFILE%\Downloads\keypair.ppk

./cf.bat .\ec2.yaml %LabName% c

./pc.bat %LabName%
