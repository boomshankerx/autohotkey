#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force ; Reload
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CODE := "C:\Program Files\Microsoft VS Code\Code.exe"
NPP  := "C:\Program Files\Notepad++\notepad++.exe"
SUB  := "C:\Program Files\Sublime Text\sublime_text.exe"
VIM  := "C:\Program Files\Vim\vim90\gvim.exe"

;WIN
#1:: run "C:\Users\%A_UserName%\OneDrive"
#2:: run "C:\Users\%A_UserName%\Google Drive"
#3:: run "C:\Users\%A_UserName%\Dropbox"
#4:: run "C:\Users\%A_UserName%\Sync"
#5:: run "Z:\files"
#6:: run "T:\files"
#9:: run "Z:\_Templates"
#-:: run % SUB 
#=:: run % VIM
#0:: run % CODE
#Enter:: run "OneNote"
#NumpadMult:: run "calc.exe"
#`:: run "C:\Users\%A_UserName%"
#t:: run "wt"

;ALT WIN
!#1:: run "C:\Users\lorne\OneDrive\Financial Statements.xlsx"
!#2:: run "C:\Users\lorne\TechG Solutions\TechG Solutions - Documents\TechG.xlsx"
!#`:: run "C:\Users\lorne\TechG Solutions\TechG Solutions - Documents\Network.xlsx" 

;CTRL ALT
^!d:: run "C:\Users\%A_UserName%\Downloads"
^!f:: run "Z:\files"
^!i:: run "Y:\iso"
^!k:: run "C:\Program Files\KeePass Password Safe 2\KeePass.exe"
^!m:: run "M:\"
^!o:: run "C:\Opt"
^!r:: run "R:\"
^!s:: run "Y:\"
^!t:: run "wt"
^!w:: run "C:\w.kali"
^!x:: EditFileList(VIM, "-O")
^!z:: run "Z:\"

;CTRL SHIFT
^+=:: run "OneNote"
^+s:: run "C:\Users\%A_UserName%\Dropbox"
^+w:: run "Y:\software\windows"
^+x:: EditFileList(SUB, "")

;CTRL ALT SHIFT
^!+a:: run "appwiz.cpl"
^!+e:: Edit
^!+m:: run "M:\movies"
^!+r:: Reload
^!+t:: run *runas "wt"
^!+u:: run "C:\Program Files\VS Revo Group\Revo Uninstaller\RevoUnin.exe"
^!+v:: PasteKeystrokes()
^!+w:: run "W:\"
^!+x:: EditFileList(CODE, "")

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

