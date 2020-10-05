#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force ; Reload
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

VIM := "C:\Program Files (x86)\Vim\vim82\gvim.exe"
NPP  := "C:\Program Files (x86)\Notepad++\notepad++.exe"

#`:: run "C:\Users\%A_UserName%"                                       ; Home
#0:: run "OneNote"
#1:: run "C:\Users\%A_UserName%\Dropbox"                               ; Dropbox
#2:: run "C:\Users\%A_UserName%\Google Drive"                          ; Google Drive
#3:: run "C:\Users\%A_UserName%\OneDrive"                              ; One Drive
#4:: run "C:\scripts"
#8:: run "V:"                                                          ; VMFS Drive
#9:: run "Z:\_Templates"
#-:: RunProgram(NPP)                                                    ; Notepad
#=:: RunProgram(VIM)                                                   ; Vim
;#5:: run ""
;#6:: run ""
;#7:: run ""
;#9:: run ""

^!+a:: run "appwiz.cpl"                                                ; Appwiz
^!+e:: Edit                                                            ; Edit autohotkey
^!+n:: run "C:\Users\%A_UserName%\Google Drive\notes.org"              ; notes.org
^!+p:: PasteKeystrokes()
^!+r:: Reload                                                          ; Reload autohotkey
^!+w:: run "W:\"                                                        ; Server work

^!d:: run "C:\Users\%A_UserName%\Downloads"                            ; Downloads
^!i:: run "Y:\iso"                                                     ; ISO folder
^!k:: run "C:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe" ; Keepass
^!r:: run "R:\"                                                        ; Repos
^!s:: run "Y:\"                                                        ; Storage
^!t:: run "T:\"                                                        ; TechG
^!w:: run "C:\work"
^!x:: EditFileList(VIM, "-O")        ; Edit files with Vim
^!z:: run "Z:\"                                                        ; Documents

;^+c:: ConvertClipboardToString()                                       ; Convert clipboard to string
^+=:: run "OneNote"
^+s:: run "C:\Users\%A_UserName%\Dropbox"                              ; Dropbox
^+w:: run "Y:\software\windows"                                        ; Local work
^+x:: EditFileList(NPP, "")     ; Edit files with notepass++

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

