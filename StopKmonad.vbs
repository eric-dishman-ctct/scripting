Set objShell = CreateObject("Wscript.Shell")
objShell.Run "powershell.exe -Command ""Stop-Process -Name 'kmonad'""", 0, False
