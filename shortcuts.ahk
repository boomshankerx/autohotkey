#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force ; Reload
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

VIM := "C:\Program Files\Vim\vim82\gvim.exe"
NPP := "C:\Program Files (x86)\Notepad++\notepad++.exe"

#`:: run "C:\Users\%A_UserName%"                                       ; Home
#1:: run "C:\Users\%A_UserName%\OneDrive"                              ; One Drive
#2:: run "C:\Users\%A_UserName%\Google Drive"                          ; Google Drive
#3:: run "C:\Users\%A_UserName%\Dropbox"                               ; Dropbox
#4:: run "Z:\files"
#5:: run "T:\files"
#6:: run "C:\scripts"
#9:: run "Z:\_Templates"
#0:: run "OneNote"
#-:: RunProgram(NPP)                                                   ; Notepad
#=:: RunProgram(VIM)                                                   ; Vim
#NumpadMult:: run "calc.exe"
#Enter:: run "OneNote"

!#`:: run "C:\Users\lorne\OneDrive\TechG\Network.xlsx" 
!#1:: run "C:\Users\lorne\OneDrive\Financial Statements.xlsx"
!#2:: run "C:\Users\lorne\OneDrive\TechG\TechG.xlsx"

^!+a:: run "appwiz.cpl"                                                ; Appwiz
^!+e:: Edit                                                            ; Edit autohotkey
^!+r:: Reload                                                          ; Reload autohotkey
^!+v:: PasteKeystrokes()
^!+w:: run "W:\"                                                       ; Server work

^!d:: run "C:\Users\%A_UserName%\Downloads"                            ; Downloads
^!f:: run "Z:\files"
^!i:: run "Y:\iso"                                                     ; ISO folder
^!k:: run "C:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe" ; Keepass
^!m:: run "M:\"
^!o:: run "C:\Opt"
^!r:: run "R:\"                                                        ; Repos
^!s:: run "Y:\"                                                        ; Storage
^!t:: run "T:\"                                                        ; TechG
^!w:: run "C:\w"
^!x:: EditFileList(VIM, "-O")                                          ; Edit files with Vim
^!z:: run "Z:\"                                                        ; Documents

;^+c:: ConvertClipboardToString()                                      ; Convert clipboard to string
^+=:: run "OneNote"
^+s:: run "C:\Users\%A_UserName%\Dropbox"                              ; Dropbox
^+w:: run "Y:\software\windows"                                        ; Local work
^+x:: EditFileList(NPP, "")                                            ; Edit files with notepad++

;***FOLDER GROUPS***
;Media Files
^!+m:: run "\\vmint\Downloads"

;REMAP Capslock in vim
*Capslock::
    classname = ""
    keystate = ""
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

PasteKeystrokes()
{
    SendRaw %clipboard%
}

