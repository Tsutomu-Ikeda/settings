#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#HotkeyModifierTimeout 100

; 別途Change KeyでCapsLockをF24キー(スキャンコード: 0x0076)に割り当てる
; https://forest.watch.impress.co.jp/library/software/changekey/

GroupAdd Dev, ahk_class CASCADIA_HOSTING_WINDOW_CLASS ; Windows Terminal
GroupAdd Dev, ahk_exe Code.exe ; Visual Studio Code

; Emacsライクな部分
F24 & a::
    IfWinActive ahk_class CASCADIA_HOSTING_WINDOW_CLASS
        Send, ^a
    Else
        Send, {Blind}{Home}
    Return
F24 & u::
    IfWinActive ahk_group Dev
        Send, ^u
    Else
        Send, +{Home}{Delete}
    Return
F24 & w::
    IfWinActive ahk_group Dev
        Send, ^w
    Else
        Send, {Blind}^{BS}
    Return
F24 & e::
    IfWinActive ahk_class CASCADIA_HOSTING_WINDOW_CLASS
        Send, ^e
    Else
        Send, {Blind}{End}
    Return

; Vimライクな部分
F24 & h::Send, {Blind}{Left}
F24 & j::Send, {Blind}{Down}
F24 & k::Send, {Blind}{Up}
F24 & l::Send, {Blind}{Right}

; 個人的な設定
F24 & `;::Send, {Blind}{Enter}
F24 & /::Send, {Blind}{BS}
F24 & [::Send, {Blind}{Esc}

; その他のキー
F24 & b::Send, ^b
F24 & c::Send, ^c
F24 & d::Send, ^d
F24 & f::Send, ^f
F24 & g::Send, ^g
F24 & i::Send, ^i
F24 & m::Send, ^m
F24 & n::Send, ^n
F24 & o::Send, ^o
F24 & p::Send, ^p
F24 & q::Send, ^q
F24 & r::Send, ^r
F24 & s::Send, ^s
F24 & t::Send, ^t
F24 & v::Send, ^v
F24 & x::Send, ^x
F24 & y::Send, ^y
F24 & z::Send, ^z

IME_GetConverting(WinTitle="A", ConvCls="", CandCls="")
{
    ; IME毎の 入力窓/候補窓Class一覧 ("|" 区切りで適当に足してけばOK)
    ConvCls .= (ConvCls ? "|" : "")                 ;--- 入力窓 ---
    .  "ATOK\d+CompStr"                     ; ATOK系
    .  "|imejpstcnv\d+"                     ; MS-IME系
    .  "|WXGIMEConv"                        ; WXG
    .  "|SKKIME\d+\.*\d+UCompStr"           ; SKKIME Unicode
    .  "|MSCTFIME Composition"              ; Google日本語入力

    CandCls .= (CandCls ? "|" : "")                 ;--- 候補窓 ---
    .  "ATOK\d+Cand"                        ; ATOK系
    .  "|imejpstCandList\d+|imejpstcand\d+" ; MS-IME 2002(8.1)XP付属
    .  "|mscandui\d+\.candidate"            ; MS Office IME-2007
    .  "|WXGIMECand"                        ; WXG
    .  "|SKKIME\d+\.*\d+UCand"              ; SKKIME Unicode
    CandGCls := "GoogleJapaneseInputCandidateWindow" ;Google日本語入力

    VarSetCapacity(stGTI, 48, 0)
    NumPut(48, stGTI, 0, "UInt")   ;   DWORD   cbSize;
    hwndFocus := DllCall("GetGUIThreadInfo", Uint, 0, Uint, &stGTI)
    ? NumGet(stGTI, 12, "UInt") : WinExist(WinTitle)

    WinGet, pid, PID, % "ahk_id " hwndFocus
    tmm:=A_TitleMatchMode
    SetTitleMatchMode, RegEx
    ret := WinExist("ahk_class " . CandCls . " ahk_pid " pid) ? 2
    :  WinExist("ahk_class " . CandGCls                 ) ? 2
    :  WinExist("ahk_class " . ConvCls . " ahk_pid " pid) ? 1
    :  0
    SetTitleMatchMode, %tmm%
    return ret
}

IME_GET(WinTitle="A")
{
    ControlGet, hwnd, HWND, , , %WinTitle%
    if (WinActive(WinTitle)) {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
        NumPut(cbSize, stGTI, 0, "UInt")   ;    DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", Uint, 0, Uint, &stGTI)
        ? NumGet(stGTI, 8+PtrSize, "UInt") : hwnd
    }

    return DllCall("SendMessage"
    , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint, hwnd)
    , UInt, 0x0283  ;Message : WM_IME_CONTROL
    , Int, 0x0005  ;wParam  : IMC_GETOPENSTATUS
    , Int, 0)      ;lParam  : 0
}

IME_SET(SetSts, WinTitle="A")
{
    ControlGet, hwnd, HWND, , , %WinTitle%
    if (WinActive(WinTitle)) {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
        NumPut(cbSize, stGTI, 0, "UInt")   ;    DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", Uint, 0, Uint, &stGTI)
        ? NumGet(stGTI, 8+PtrSize, "UInt") : hwnd
    }

    return DllCall("SendMessage"
    , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint, hwnd)
    , UInt, 0x0283  ;Message : WM_IME_CONTROL
    , Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
    , Int, SetSts) ;lParam  : 0 or 1
}

; 単押しのときはアルファベット/日本語切り替えとして動かす
F24 up::
    if (IME_GET()) {
        if (IME_GetConverting() >= 1) {
            Send, {Blind}{Enter}
        }
        IME_SET(0)
    } else {
        IME_SET(1)
    }
Return
