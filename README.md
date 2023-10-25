# Check-Host

Cross-platform PowerShell Module for check ping, hhtp, tcp, udp and dns to Internet using Check Host via REST API

## Install Windows

```PowerShell
$path = $(($env:PSModulePath -split ";")[0]) + "\Get-CheckHost"
if (Test-Path $path) {
    Remove-Item $path -Force -Recurse
    New-Item -Path $path
} else {
    New-Item -Path $path
}
Invoke-RestMethod https://raw.githubusercontent.com/Lifailon/Check-Host//rsa/Get-CheckHost/Get-CheckHost.psm1 -OutFile "$path\Get-CheckHost.psm1"
```

## Install Linux

```bash
sudo curl -s https://raw.githubusercontent.com/Lifailon/Check-Host//rsa/Get-CheckHost/Get-CheckHost.psm1 -o /usr/bin/Get-CheckHost
sudo chmod +x /usr/bin/Get-CheckHost
```

## Shell

**Bash module version:** **[netcheck](https://github.com/Lifailon/net-tools#netcheck)**

## Format

`Get-CheckHost -Type <ping/http/tcp/udp/dns> -Server <hostname> -Count <nodes>`

### Node list

```PowerShell
PS C:\Users\lifailon\Desktop> Import-Module Get-CheckHost
PS C:\Users\lifailon\Desktop> Get-CheckHost -List

Server                  Address         Location
------                  -------         --------
ae1.node.check-host.net 5.44.42.40      Dubai
at1.node.check-host.net 78.153.130.65   Vienna
bg1.node.check-host.net 93.123.16.89    Sofia
br1.node.check-host.net 209.14.69.16    Sao Paulo
ch1.node.check-host.net 179.43.148.195  Zurich
cz1.node.check-host.net 77.75.230.51    C.Budejovice
de1.node.check-host.net 167.235.135.184 Nuremberg
de4.node.check-host.net 185.37.147.117  Frankfurt
es1.node.check-host.net 185.230.55.13   Barcelona
fi1.node.check-host.net 65.109.182.130  Helsinki
fr2.node.check-host.net 195.154.114.92  Paris
hk1.node.check-host.net 141.98.234.68   Hong Kong
il1.node.check-host.net 181.214.197.192 Tel Aviv
ir1.node.check-host.net 185.105.238.209 Tehran
ir3.node.check-host.net 185.24.253.139  Shiraz
ir4.node.check-host.net 185.255.91.239  Tabriz
ir5.node.check-host.net 5.159.54.120    Esfahan
ir6.node.check-host.net 193.8.95.39     Karaj
it2.node.check-host.net 185.25.204.60   Milan
jp1.node.check-host.net 38.47.52.199    Tokyo
kz1.node.check-host.net 185.120.77.165  Karaganda
lt1.node.check-host.net 88.119.179.10   Vilnius
md1.node.check-host.net 178.17.171.235  Chisinau
nl1.node.check-host.net 185.209.161.169 Amsterdam
pl1.node.check-host.net 178.216.200.169 Poznan
pl2.node.check-host.net 45.146.7.45     Warsaw
pt1.node.check-host.net 185.83.213.25   Viana
rs1.node.check-host.net 194.146.57.64   Belgrade
ru1.node.check-host.net 185.130.104.238 Moscow
ru2.node.check-host.net 194.26.229.20   Moscow
ru3.node.check-host.net 92.223.65.81    Saint Petersburg
ru4.node.check-host.net 185.39.205.237  Ekaterinburg
se1.node.check-host.net 193.233.255.128 Stockholm
tr1.node.check-host.net 185.169.54.231  Istanbul
tr2.node.check-host.net 77.92.151.181   Gebze
ua1.node.check-host.net 185.86.77.126   Khmelnytskyi
ua2.node.check-host.net 91.231.182.39   Kyiv
ua3.node.check-host.net 91.102.183.15   SpaceX Starlink
uk1.node.check-host.net 185.138.164.21  Coventry
us1.node.check-host.net 5.253.30.82     Los Angeles
us3.node.check-host.net 185.143.223.66  Atlanta
```

### Check ping

```PowerShell
PS C:\Users\lifailon\Desktop> Get-CheckHost -Server google.com -Type ping -Count 5

Server                  Location Status Time
------                  -------- ------ ----
at1.node.check-host.net Vienna   OK     0,01
at1.node.check-host.net Vienna   OK     0,01
at1.node.check-host.net Vienna   OK     0,01
at1.node.check-host.net Vienna   OK     0,01
il1.node.check-host.net Tel Aviv OK     0,06
il1.node.check-host.net Tel Aviv OK     0,06
il1.node.check-host.net Tel Aviv OK     0,06
il1.node.check-host.net Tel Aviv OK     0,06
ir5.node.check-host.net Esfahan  OK     0,12
ir5.node.check-host.net Esfahan  OK     0,11
ir5.node.check-host.net Esfahan  OK     0,11
ir5.node.check-host.net Esfahan  OK     0,11
jp1.node.check-host.net Tokyo    OK     0,00
jp1.node.check-host.net Tokyo    OK     0,00
jp1.node.check-host.net Tokyo    OK     0,00
jp1.node.check-host.net Tokyo    OK     0,00
tr1.node.check-host.net Istanbul OK     0,05
tr1.node.check-host.net Istanbul OK     0,05
tr1.node.check-host.net Istanbul OK     0,05
tr1.node.check-host.net Istanbul OK     0,05

PS C:\Users\lifailon\Desktop> Get-CheckHost -Server gooooooooogle.com -Type ping -Count 5

Server                  Location  Status  Time
------                  --------  ------  ----
br1.node.check-host.net Sao Paulo TIMEOUT 3,00
br1.node.check-host.net Sao Paulo TIMEOUT 3,00
br1.node.check-host.net Sao Paulo TIMEOUT 3,00
br1.node.check-host.net Sao Paulo TIMEOUT 3,00
ch1.node.check-host.net Zurich    TIMEOUT 3,00
ch1.node.check-host.net Zurich    TIMEOUT 3,00
ch1.node.check-host.net Zurich    TIMEOUT 3,00
ch1.node.check-host.net Zurich    TIMEOUT 3,00
ir4.node.check-host.net Tabriz    TIMEOUT 3,00
ir4.node.check-host.net Tabriz    TIMEOUT 3,00
ir4.node.check-host.net Tabriz    TIMEOUT 3,00
ir4.node.check-host.net Tabriz    TIMEOUT 3,00
ir5.node.check-host.net Esfahan   TIMEOUT 3,00
ir5.node.check-host.net Esfahan   TIMEOUT 3,00
ir5.node.check-host.net Esfahan   TIMEOUT 3,00
ir5.node.check-host.net Esfahan   TIMEOUT 3,00
pl1.node.check-host.net Poznan    TIMEOUT 3,00
pl1.node.check-host.net Poznan    TIMEOUT 3,00
pl1.node.check-host.net Poznan    TIMEOUT 3,00
pl1.node.check-host.net Poznan    TIMEOUT 3,00
```

### Check http

```PowerShell
PS C:\Users\lifailon\Desktop> Get-CheckHost -Server google.com:443 -Type http -Count 5

Server                  Location     Status Time
------                  --------     ------ ----
br1.node.check-host.net Sao Paulo    True   0,90
de1.node.check-host.net Nuremberg    True   0,04
fi1.node.check-host.net Helsinki     True   0,06
ua1.node.check-host.net Khmelnytskyi True   0,15
ua2.node.check-host.net Kyiv         True   0,17

PS C:\Users\lifailon\Desktop> Get-CheckHost -Server google.com:444 -Type http -Count 5

Server                  Location Status  Time
------                  -------- ------  ----
bg1.node.check-host.net Sofia    False   3,00
ch1.node.check-host.net Zurich   False  18,07
pl1.node.check-host.net Poznan   False  18,06
ru1.node.check-host.net Moscow   False  18,00
```

### Check dns

```PowerShell
PS C:\Users\lifailon\Desktop> Get-CheckHost -Server google.com -Type dns -Count 5

Server                  Location  A_Record
------                  --------  --------                                                          
ae1.node.check-host.net Dubai     142.250.181.110
es1.node.check-host.net Barcelona 142.250.184.14
rs1.node.check-host.net Belgrade  142.251.208.110
se1.node.check-host.net Stockholm
tr2.node.check-host.net Gebze     {173.194.76.139, 173.194.76.102, 173.194.76.100, 173.194.76.138…} 
```

### Check tcp and udp port

```PowerShell
PS C:\Users\lifailon\Desktop> Get-CheckHost -Server google.com:443 -Type tcp -Count 5

Server                  Location         Status
------                  --------         ------
br1.node.check-host.net Sao Paulo          0,22
ir4.node.check-host.net Tabriz             0,06
ru3.node.check-host.net Saint Petersburg   0,01
ru4.node.check-host.net Ekaterinburg       0,10
tr2.node.check-host.net Gebze              0,05

PS C:\Users\lifailon\Desktop> Get-CheckHost -Server google.com:22 -Type tcp -Count 5

Server                  Location Status
------                  -------- ------
ir1.node.check-host.net Tehran   Connection timed out
ir4.node.check-host.net Tabriz   Connection timed out
lt1.node.check-host.net Vilnius  Connection timed out
ua2.node.check-host.net Kyiv     Connection timed out
uk1.node.check-host.net Coventry Connection timed out

PS C:\Users\lifailon\Desktop> Get-CheckHost -Server google.com:22 -Type udp -Count 5

Server                  Location  Timeout
------                  --------  -------
ae1.node.check-host.net Dubai           1
de1.node.check-host.net Nuremberg       1
es1.node.check-host.net Barcelona       1
lt1.node.check-host.net Vilnius         1
rs1.node.check-host.net Belgrade        1
```
