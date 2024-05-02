#SingleInstance force ; Reload
#Warn  ; Enable warnings to assist with detecting common errors.

A_USERPROFILE := EnvGet("USERPROFILE")

CODE := "C:\Program Files\Microsoft VS Code\Code.exe"
NPP := "C:\Program Files\Notepad++\notepad++.exe"
SUBLIME := "C:\Program Files\Sublime Text\sublime_text.exe"
VIM := "C:\Program Files\Vim\vim91\gvim.exe"

PATH_DROPBOX := A_USERPROFILE "\Dropbox"
PATH_OBSIDIAN := "C:\Users\lorne\AppData\Local\Obsidian\Obsidian.exe"
PATH_ONEDRIVE := A_USERPROFILE "\OneDrive"
PATH_ONEDRIVE_TECHG := A_USERPROFILE "\OneDrive - TechG Solutions"

;Obsidian Vaults
; OBSIDIAN_HACKER := "obsidian://vault/Hacker"
; OBSIDIAN_PERSONAL := "obsidian://vault/Personal"
OBSIDIAN_HACKER := "obsidian:///" PATH_ONEDRIVE "\Obsidian\Hacker"
OBSIDIAN_PERSONAL := "obsidian:///" PATH_ONEDRIVE "\Obsidian\Personal"

;HOTKEYS

;SUPER
#-:: Run(SUBLIME)
#0:: Run(CODE)
#1:: Run(A_USERPROFILE "\OneDrive")
#2:: Run(A_USERPROFILE "\Google Drive")
#3:: Run(A_USERPROFILE "\Dropbox")
#4:: Run(A_USERPROFILE "\Sync")
#5:: Run("Z:\files")
#6:: Run("T:\files")
#9:: Run(PATH_ONEDRIVE "\_Templates")
#=:: Run(VIM)
#Enter:: Run(PATH_OBSIDIAN)
#Numpad0:: Run(CODE)
#Numpad1:: Run(OBSIDIAN_PERSONAL)
#Numpad2:: Run(OBSIDIAN_HACKER)
#Numpad3:: Run("OneNote")
#Numpad4:: Run("C:\Users\lorne\AppData\Local\Programs\todoist\Todoist.exe")
#Numpad5::
#Numpad6::
#Numpad7:: Run("C:\Program Files (x86)\Brother\Ptedit54\ptedit54.exe")
#Numpad8::
#Numpad9:: Run(PATH_ONEDRIVE "\_Templates")
#NumpadEnter::
#NumpadMult:: Run("calc.exe")
#`:: Run(A_USERPROFILE)

;ALT WIN
!#`:: Run(PATH_ONEDRIVE_TECHG "\Network.xlsx")
!#1:: Run(A_USERPROFILE "\OneDrive\Financial Statements.xlsx")
!#2:: Run(PATH_ONEDRIVE_TECHG "\TechG.xlsx")

;CTRL ALT
^!d:: Run(A_USERPROFILE "\Downloads")
^!f:: Run("Z:\files")
^!i:: Run("Y:\iso")
^!k:: Run("C:\Program Files\KeePass Password Safe 2\KeePass.exe")
^!m:: Run("M:\")
^!o:: Run("C:\Opt")
^!r:: Run("R:\")
^!s:: Run("Y:\")
^!t:: Run("wt")
^!u:: Run(A_USERPROFILE "\Dropbox\_tools\_usb")
^!w:: Run("D:\w")
^!x:: EditFileList(VIM, "-O")
^!z:: Run("Z:\")

;CTRL SHIFT
^+=:: Run("OneNote")
^+s:: Run("" A_USERPROFILE "\Dropbox")
^+w:: Run("D:\w.kali")
^+x:: EditFileList(SUBLIME, "")

;ALT SHIFT
!+x:: EditFileList(CODE, "")

;CTRL ALT SHIFT
^!+a:: Run("appwiz.cpl")
^!+e:: Edit()
^!+m:: Run("M:\movies")
^!+r:: Reload()
^!+t:: Run("*runas wt")
^!+u:: Run("C:\Program Files\VS Revo Group\Revo Uninstaller\RevoUnin.exe")
^!+v:: PasteKeystrokes()
^!+w:: Run("X:\work")
^!+x:: EditFileList(CODE, "")

RunProgram(program)
{
    Run(program, , , &PID)
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


;TICKET SYSTEM

:?:\t::
{
    Send("^+{Left}")
    Send("^c")

    input := A_Clipboard

    ; Apply formatting (e.g., adding commas)
    output := FormatTicket(input)
    if !(IsInteger(input)) {
        return
    }

    ; Paste the formatted number wherever needed
    A_Clipboard := output
    SendText(output)
    return
}

;Insert Ticket
::\tt::
{
    input := InputBox("Enter ticket number", "Ticket", ,).value
    if !(IsInteger(input)) {
        return
    }
    ; Apply formatting (e.g., adding commas)
    output := FormatTicket(input)

    ; Paste the formatted number wherever needed
    A_Clipboard := output
    SendText(output)
    return
}

;Format ticket number
FormatTicket(Number) {
    return "[" Format("{:07}", Number) "] : "
}