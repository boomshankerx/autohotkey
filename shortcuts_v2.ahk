#SingleInstance force ; Reload
#Warn  ; Enable warnings to assist with detecting common errors.

A_USERPROFILE := EnvGet("USERPROFILE")

CODE     := "C:\Program Files\Microsoft VS Code\Code.exe"
DROPBOX  := A_USERPROFILE "\Dropbox"
NPP      := "C:\Program Files\Notepad++\notepad++.exe"
OBSIDIAN := "C:\Users\lorne\AppData\Local\Obsidian\Obsidian.exe"
ONEDRIVE := A_USERPROFILE "\OneDrive"
SUBLIME  := "C:\Program Files\Sublime Text\sublime_text.exe"
VIM      := "C:\Program Files\Vim\vim91\gvim.exe"


;WIN
#1::Run(A_USERPROFILE "\OneDrive")
#2::Run(A_USERPROFILE "\Google Drive")
#3::Run(A_USERPROFILE "\Dropbox")
#4::Run(A_USERPROFILE "\Sync")
#5::Run("Z:\files")
#6::Run("T:\files")
#9::Run(ONEDRIVE "\_Templates")
#0::Run(CODE)
#-::Run(SUBLIME)
#=::Run(VIM)
#Enter::Run(OBSIDIAN)
#NumpadMult::Run("calc.exe")
#`::Run(A_USERPROFILE)
#t::Run("wt")

;ALT WIN
!#1::Run(A_USERPROFILE "\OneDrive\Financial Statements.xlsx")
!#2::Run("T:\TechG.xlsx")
!#`::Run("T:\Network.xlsx")

;CTRL ALT
^!d::Run(A_USERPROFILE "\Downloads")
^!f::Run("Z:\files")
^!i::Run("Y:\iso")
^!k::Run("C:\Program Files\KeePass Password Safe 2\KeePass.exe")
^!m::Run("M:\")
^!o::Run("C:\Opt")
^!r::Run("R:\")
^!s::Run("Y:\")
^!t::Run("wt")
^!u::Run(A_USERPROFILE "\Dropbox\_tools\_usb")
^!w::Run("D:\w")
^!x:: EditFileList(VIM, "-O")
^!z::Run("Z:\")

;CTRL SHIFT
^+=::Run("OneNote")
^+s::Run("" A_USERPROFILE "\Dropbox")
^+w::Run("D:\w.kali")
^+x:: EditFileList(SUBLIME, "")

;CTRL ALT SHIFT
^!+a::Run("appwiz.cpl")
^!+e::Edit()
^!+m::Run("M:\movies")
^!+r::Reload()
^!+t::Run("*runas wt")
^!+u::Run("C:\Program Files\VS Revo Group\Revo Uninstaller\RevoUnin.exe")
^!+v:: PasteKeystrokes()
^!+w::Run("X:\work")
^!+x:: EditFileList(CODE, "")

;FUNCTIONS
RunProgram(program)
{
    Run(program, , "Max", &PID)
    WinWait("ahk_pid " PID)
    WinActivate("ahk_pid " PID)
    return
}

GetClipboard()
{
    ClipSaved := ClipboardAll()
    A_Clipboard := ""
    Send("^c")
    Errorlevel := !ClipWait()
    content := A_Clipboard
    A_Clipboard := ClipSaved
    return content
}

ConvertClipboardToString()
{
    A_Clipboard := GetClipboard()
    return
}

EditFileList(editor, seperator)
{
    files := GetClipboard()
    filelist := ""
    cmd := editor 
    Loop Parse, files, "`n", "`r"
    {
        if !FileExist(A_Loopfield)
            continue
        If (filelist != "")
            filelist .= A_SPACE . seperator . A_SPACE
        filelist .= "`"" . A_Loopfield . "`"" . A_SPACE
    }
    cmd .= A_SPACE . filelist
    RunProgram(cmd)
}

PasteKeystrokes()
{
    Send("{Raw}" A_Clipboard)
}
