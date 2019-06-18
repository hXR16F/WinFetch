:: Programmed by hXR16F
:: hXR16F.ar@gmail.com

@echo off
if defined __ goto :main
set __=.
call %0 %* | darkbox
set __=
goto :eof

:main
	setlocal EnableDelayedExpansion
	
	:: Get informations
	for /f "tokens=6,8,10 delims= " %%i in ('uptime.exe') do (set var=%%id %%jh %%km)
	for /f "usebackq tokens=3,4,5" %%i in (`reg query "hklm\software\microsoft\windows NT\CurrentVersion" /v ProductName`) do set "osname=%%i %%j %%k"
	if /i "%osname:~0,9%" equ "Microsoft" (set "osname_additional=") else (set "osname_additional=Microsoft ")
	if defined ProgramFiles(x86) (set "ostype=x64") else (set "ostype=x86")
	for /f "tokens=4-7 delims=[.] " %%i in ('ver') do (if /i "%%i" equ "Version" (set "osver=%%j.%%k.%%l.%%m") else (set "osver=%%i.%%j.%%k.%%l"))
	for /f "usebackq delims=" %%i in ('%comspec%') do (set "shell=%%~nxi")
	for /f "delims=" %%i in ('wmic desktopmonitor get screenheight') do (call :wmicset %%i height)
	for /f "delims=" %%i in ('wmic desktopmonitor get screenwidth') do (call :wmicset %%i width)
	for /f "delims=" %%i in ('wmic cpu get name') do ((echo %%i>> "temp.txt")&set line=1&for /f "tokens=*" %%a in (temp.txt) do ((if !line! equ 2 set "cpuname=%%a")&(set /a line+=1)))
	
	:: Find wrong informations
	(echo %width%x%height%> "res.tmp") & (findstr /i /c:"screen desktop monitor" res.tmp && (set "resolution=n/a") || (set "resolution=%width%x%height%"))
	
	:: Display
	echo -cn 0x07
	echo -cdcdcdcdn 0x0c "         ,.=:!!t3Z3z.,                   " 0x07 "%userprofile:~9%" 0x0f "@" 0x07 "%computername%"
	echo -cdcdcdn 0x0c "        :tt:::tt333EE3                 " 0x07 "OS: " 0x0f "%osname_additional%%osname%"
	echo -cdcdcdcdn 0x0c "        Et:::ztt33EEE  " 0x0a "@Ee.,      ..,  " 0x07 "OS Version: " 0x0f "%osver%"
	echo -cdcdcdcdn 0x0c "       ;tt:::tt333EE7 " 0x0a ";EEEEEEttttt33#  " 0x07 "Uptime: " 0x0f "%var%"
	echo -cdcdcdcdn 0x0c "      :Et:::zt333EEQ. " 0x0a "SEEEEEttttt33QL  " 0x07 "Shell: " 0x0f "%shell%"
	echo -cdcdcdcdn 0x0c "      it::::tt333EEF " 0x0a "@EEEEEEttttt33F   " 0x07 "Resolution: " 0x0f "%resolution%"
	echo -cdcdcdcdn 0x0c "     ;3=*^```'*4EEV " 0x0a ":EEEEEEttttt33@. " 0x07 "  OS Type: " 0x0f "%ostype%"
	echo -cdcdcdcdcdn 0x09 "     ,.=::::it=., " 0x0c "` " 0x0a "@EEEEEEtttz33QF    " 0x07 "System Drive: " 0x0f "%systemdrive%"
	echo -cdcdcdcdn 0x09 "    ;::::::::zt33)   " 0x0a "'4EEEtttji3P*     " 0x07 "CPU Name: " 0x0f "%cpuname%"
	echo -cdcdcdcdcdcdn 0x09 "   :t::::::::tt33." 0x0e ":Z3z..  " 0x0a "``" 0x0e ",..g.      " 0x07 "CPU Cores: " 0x0f "%number_of_processors%"
	echo -cdcdcdcdn 0x09 "   i::::::::zt33F " 0x0e "AEEEtttt::::ztF      " 0x07 "CPU Type: " 0x0f "%processor_architecture%"
	echo -cdcdn 0x09 "  ;:::::::::t33V " 0x0e ";EEEttttt::::t3     "
	echo -cdcdn 0x09 "  E::::::::zt33L " 0x0e "@EEEtttt::::z3F     "
	echo -cdcdn 0x09 " {3=*^```'*4E3) " 0x0e ";EEEtttt:::::tZ`     "
	echo -cdcdn 0x09 "             `" 0x0e " :EEEEtttt::::z7      "
	echo -cdcdn 0x09 "                " 0x0e " 'VEzjt:;;z>*`      "
	
	:: Delete temporary files
	del /f /q "temp.txt" >nul 2>&1
	del /f /q "res.tmp" >nul 2>&1
	
	:: Close darkbox and exit
	echo -cq 0x07
	exit /b

:: Functions
:wmicset
	if not "%~1" equ "" (2>nul set %~2=%1)
	goto :eof
	