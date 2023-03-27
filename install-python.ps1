$url = "https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe"
$output = "$env:TEMP\python-3.10.0-amd64.exe"
Invoke-WebRequest $url -OutFile $output
Start-Process -Wait -FilePath $output -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=1"
