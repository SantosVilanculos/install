## Microsoft Windows 10/11

### PowerShell

```ps1
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/santosvilanculos/install/main/nt.ps1'))
```

---

## Debian 12 LTS/Ubuntu 22.04-24.04 LTS

### Bash

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/santosvilanculos/install/main/debian.sh)"
```
