#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force ; Reload
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#1:: run "C:\Users\%A_UserName%\Dropbox"                               ; Dropbox
#2:: run "C:\Users\%A_UserName%\Google Drive"                          ; Google Drive
#3:: run "C:\Users\%A_UserName%\OneDrive"                              ; One Drive
#8:: run "V:"                                                          ; VMFS Drive
#`:: run "C:\Users\%A_UserName%"                                       ; Home
;#4:: run ""
;#5:: run ""
;#6:: run ""
;#7:: run ""
#9:: run "Firefox"
#0:: run "Chrome"
#-:: RunProgram("C:\Program Files\Notepad++\notepad++.exe")            ; Notepad
#=:: RunProgram("C:\Program Files (x86)\Vim\vim80\gvim.exe")           ; Vim
;#0:: run "C:\work"

^#=:: RunProgram("C:\Program Files (x86)\Vim\vim80\gvim.exe -O C:\Users\%A_UserName%\Dropbox\choco.base.bat")           ; Vim

^!+a:: run "appwiz.cpl"                                                ; Appwiz
^!+n:: run "C:\Users\%A_UserName%\Google Drive\notes.org"              ; notes.org
^!+r:: Reload                                                          ; Reload autohotkey
^!+e:: Edit                                                            ; Edit autohotkey
^!+w:: run "C:\work"

^!d:: run "C:\Users\%A_UserName%\Downloads"                            ; Downloads
^!i:: run "Y:\iso"                                                     ; ISO folder
^!k:: run "C:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe" ; Keepass
^!r:: run "R:\"                                                        ; Repos
^!t:: run "T:\"                                                        ; TechG
^!s:: run "Y:\"                                                        ; Storage
^!w:: run "W:\"                                                        ; Server work
^!x:: EditFileList("C:\Program Files (x86)\Vim\vim80\gvim.exe", "-O")  ; Edit files with Vim
^!z:: run "Z:\"                                                        ; Documents

^+c:: ConvertClipboardToString()                                       ; Convert clipboard to string
^+s:: run "C:\Users\%A_UserName%\Dropbox"                              ; Dropbox
^+w:: run "Y:\software\windows"                                        ; Local work
^+x:: EditFileList("C:\Program Files\Notepad++\notepad++.exe", "")     ; Edit files with notepass++

;***FOLDER GROUPS***
;Media Files
^!+m::
    ;run "E:\_movies"
    ;run "E:\tv"
    ;run "Y:\media\"
    run "\\vmint\Downloads"
return

;REMAP Capslock in vim
classname = ""
keystate = ""

*Capslock::
    WinGetClass, classname, A
    if (classname = "Vim")
    {
    SetCapsLockState, Off
    Send, {ESC}
    }
    else
    {
    GetKeyState, keystate, CapsLock, T
    if (keystate = "D")
      SetCapsLockState, Off
    else
      SetCapsLockState, On
    return
    }
return

;FUNCTIONS
RunProgram(program)
{
    ;MsgBox %program%
    Run, %program%,,Max,PID
    WinWait, ahk_pid %PID%
    WinActivate, ahk_pid %PID%
    return
}

GetClipboard()
{
    ClipSaved := ClipboardAll
    Clipboard =
    Send ^c
    ClipWait
    content := Clipboard
    Clipboard := ClipSaved
    return content
}

ConvertClipboardToString()
{
    Clipboard := GetClipboard()
    return
}

EditFileList(editor, seperator)
{
    files := GetClipboard()
    filelist := ""
    cmd := editor 
    Loop, parse, files, `n, `r
    {
        IfNotExist, %A_Loopfield%
            continue
        If (filelist <> "")
            filelist .= A_SPACE . seperator . A_SPACE
        filelist .= """" . A_Loopfield . """" . A_SPACE
    }
    cmd .= A_SPACE . filelist
    RunProgram(cmd)
}

