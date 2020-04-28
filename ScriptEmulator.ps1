Echo "[*] Starting Script"
Start-Sleep 4

$myshell = New-Object -com "Wscript.Shell"

$Acci = "A","C","x","y","z","e","E","a","u","U","i","I","k","s","o"

$digits = 12,14,18,24,32,38,40
$DigitsInt = 50, 100, 200, 400, 500, 1000, 1100
$digits1 = "50","100","200","400","500","1000","1100"

function Enumerate-Files {
        $cont = Get-ChildItem "." | Get-Random
        Write-Host "[*] File: $cont"
        return $cont
        }

function Create-CanvasSpace {
        Write-Host "[*] Creating Open Canvas"
        $randint = Get-Random -Minimum 50 -Maximum 1000
        Start-Sleep -Milliseconds $randint
        $myshell.sendkeys("{ENTER}{ENTER}{ENTER}")
        $randint = Get-Random -Minimum 1 -Maximum 3
        Start-Sleep $randint
        $myshell.sendkeys("{ENTER}{ENTER}{ENTER}{ENTER}")
        $randint = Get-Random -Minimum 1 -Maximum 3
        Start-Sleep $randint
        $myshell.sendkeys("{UP}{UP}{UP}{UP}{UP}{UP}{LEFT}")
        Write-Host "[*] Canvas Space Created"
        }

function Random-Acci {
        $SentAcci = $Acci | Get-Random
        $myshell.sendkeys($SentAcci)
        $randint = $DigitsInt | Get-Random
        Start-Sleep -Milliseconds $randint
        $myshell.sendkeys("{BKSP}")
        Start-Sleep -Milliseconds $randint
        }

function Convert-SpecialAcci {
        param(
        [Parameter()]
        [string]$SpecialAcci
                )
        $SpecialAsciiArray = "+", "{", "}", "(", ")", "%"
        # Check For Special ASCII
        if ("$SpecialAcci" -eq "("){
                Write-Host "Parenthesis Found"
                $myshell.sendkeys("{(}")
                }
        ElseIf ("$SpecialAcci" -eq ")"){
                Write-Host "Parenthesis Found"
                $myshell.sendkeys("{)}")
                }
        ElseIf ("$SpecialAcci" -eq "%"){
                Write-Host "Percent Found"
                $myshell.sendkeys("{%}")
                }
        ElseIf ("$SpecialAcci" -eq "{"){
                Write-Host "Braces Found"
                $myshell.sendkeys("{{}")
                }
        ElseIf ("$SpecialAcci" -eq "}"){
                Write-Host "Braces Found"
                $myshell.sendkeys("{}}")
                }
        ElseIf ("$SpecialAcci" -eq "+"){
                Write-Host -NoNewLine "Add Found"
                $myshell.sendkeys("{+}")
                }
        if ($SpecialAcci -in $SpecialAsciiArray){
                return $true
                }
        }

$CompArray = @(Get-Content $(Enumerate-Files))

Start-Process "C:\windows\system32\notepad.exe"

#Main
for ($i=0;$i-le $CompArray.Length;$i++) {
        # Print Line
        #$CompArray[$i]
        $LineArray = $CompArray[$i].ToCharArray()
        foreach($element in $LineArray){
                Write-Host -NoNewLine "${element}"
                $randint = Get-Random $digits1
                $integer = [int]$randint
                Start-Sleep -Milliseconds $integer
                # Check ASCII
                $IsSpecialAscii = (Convert-SpecialAcci -SpecialAcci "${element}")
                
                if ( $IsSpecialAscii -eq $true){
                        #pass
                        }
                else{
                        $myshell.sendkeys("${element}")
                        }

                # Random Acci Characters
                $DecideAcci=Get-Random -Maximum 9
                if ($DecideAcci -eq 1) {
                        Random-Acci
                                }
                }

        # Add New-Line #Right is needed to clear Auto-Complete in some IDEs
        $myshell.sendkeys("{ENTER}")
        # Carriage-Return
        Write-Host "`r"
        Start-Sleep -Seconds 1

        #Create Space in Window
        $DecideAcci=Get-Random -Maximum 5
                if ($DecideAcci -eq 1) {
                        Create-CanvasSpace
                        }
        }
