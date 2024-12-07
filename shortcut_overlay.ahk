;---------------------------------------
; Shortcut Overlay Script for AutoHotkey v2
;---------------------------------------

; Initialize global variables
global OverlayVisible := false
global ShortcutOverlay := ""

; Hotkey to toggle the overlay (Ctrl+Shift+H)
^+1::ToggleOverlay

; Function to toggle the overlay
ToggleOverlay() {
    global OverlayVisible
    if OverlayVisible {
        HideOverlay()
        OverlayVisible := false
    } else {
        ShowOverlay()
        OverlayVisible := true
    }
}

; Function to show the overlay
ShowOverlay() {
    global ShortcutOverlay

    ; Create the GUI if it doesn't exist
    if !IsObject(ShortcutOverlay) {
        ShortcutOverlay := Gui("+AlwaysOnTop -Caption +ToolWindow +Border")
        ShortcutOverlay.BackColor := "Black"
        WinSetTransparent(210,ShortcutOverlay)
        ShortcutOverlay.MarginX := 20
        ShortcutOverlay.MarginY := 20

        ; Set the font
        ShortcutOverlay.SetFont("s12 cWhite", "Cascadia Code")

        ; Add your custom shortcuts here
        ShortcutText := GetShortcutText()
        ShortcutOverlay.AddText("", ShortcutText)
    }

    ; Position the GUI
    ;MonitorWorkArea := SysGet("MonitorWorkArea", 1) ; Get the work area of monitor 1
    ;xPos := MonitorWorkArea.Right - 300  ; Adjust position as needed
    ;yPos := MonitorWorkArea.Top + 100    ; Adjust position as needed

    MonitorGetWorkArea 1, &WL, &WT, &WR, &WB
    xPos := WR - 300  ; Adjust position as needed
    yPos := WT + 100    ; Adjust position as needed
    ; Show the GUI
    ShortcutOverlay.Show("NoActivate")
}

; Function to hide the overlay
HideOverlay() {
    global ShortcutOverlay
    if IsObject(ShortcutOverlay) {
        ShortcutOverlay.Hide()
    }
}

; Function to generate the shortcut text
GetShortcutText() {
    /*
    Define your custom shortcuts here.
    Use triple-quoted strings to maintain formatting.
    */
    return "
    (
    *** KMonad Shortcuts ***
    Layer1                                                                          Layer2 ;; Symbols
      _    _    _    _    _    _    _    _    _    _    _    _    _                   _    _    _    _    _    _    _    _    _    _    _    _    _    
      @qwe _    _    _    _    _    _    _    _    _    _    _    _    XX             _    @ta1 @ta2 _    _    _    _    _    _    _    _    _    _    _
      @ter /    ,    @duh _    _    _    @gom _    _    _    @nso @nsq _              @ter tab  @    #    $    %    ^    &    *    @scc bspc _    _    _
      @kom _    _    _    _    _    _    _    _    _    _    -    _                   @kom @lec =    '    "    `    \    {    }    |    del  _    _     
      _    @act _    _    _    _    _    @mar _    _    _    _         _              _    @cec _    @exp ?    kp+  [    \(   \)   ]    @L3  _         _
      _    _    _              spc            @L2  _    _         _    _    _         _    _    _              @L1            @L4  _    _         _    _    _
                                                                                    
    
    Layer3  Browser                                                               Layer4 ;; Numbers
      _    _    _    _    _    _    _    _    _    _    _    _    _                   _    _    _    _    _    _    _    _    _    _    _    _    _    
      _    _    _    _    _    _    _    _    _    _    _    _    _    _              _    _    _    _    _    _    _    _    _    _    _    _    _    _
      @ter tab  _    @vpu @vtp _    @faf _    @vbu _    _    _    _    _              @ter tab  _    _    _    \_   -    7    8    9    bspc _    _    _
      @kom @lec _    @vpd @vbp _    _    @vbl @vbd @vbr ret    _    _                 @kom @lec _    @he  @le  +    =    4    5    6    del  _    _     
      _    @cec _    _    _    _    _    _    _    @ct  _    _         _              _    @cec *    @je  @ke  .    0    1    2    3    _    _         _
      _    _    _              @L1            @L2  _    _         _    _    _         _    _    _              @L1            @L2  _    _         _    _    _
                                                                                    
    komorebi                                                                        komorebi_ws_move
      _    _    _    _    _    _    _    _    _    _    _    _    _                   _    _    _    _    _    _    _    _    _    _    _    _    _    
      _    _    _    _    _    _    _    _    _    _    _    _    _    _              _    _    _    _    _    _    _    _    _    _    _    _    _    _
      @ter @lec _    _    @prm @swy @mon _    _    _    @kgr _    _    _              @ter @lec _    _    _    _    _    _    _    _    @kmr _    _    _
      XX   @ws1 @ws2 @ws3 @ws4 @ws5 _    @kgl @flt @knw _    _    _                   XX   @mw1 @mw2 @mw3 @mw4 @mw5 _    @kml _    _    _    _    _     
      _    @mwt @sws @kgd @kgu @swx @chl @max _    _    _    _         _              _    _    _    @kmd @kmu _    _    _    _    _    _    _         _
      _    _    _              @L1            @L2  _    _         _    _    _         _    _    _              @L1            @L2  _    _         _    _    _
    
    komorebi_stack                                                                  terminal
      _    _    _    _    _    _    _    _    _    _    _    _    _                   _    _    _    _    _    _    _    _    _    _    _    _    _    
      _    _    _    _    _    _    _    _    _    _    _    _    _    _              _    _    _    _    _    _    _    _    _    _    _    _    _    _
      @ter @lec _    _    _    _    _    _    @ksc _    _    _    _    _              XX   tab  _    @tnu _    _    @ttb _    @tgu _    _    _    _    _
      XX   _    _    _    @kus _    _    @ksl @ksd @ksu @ksr _    _                   @kom @lec @tnl @tnd @tnr _    _    @tgl @tgd @tgr _    _    _     
      _    _    _    _    _    _    _    _    _    _    _    _         _              _    _    _    _    _    _    _    _    @tcw _    @zom _         _
      _    _    _              @L1            @L2  _    _         _    _    _         _    _    _              @L1            @L2  _    _         _    _    _
    
    nvim_marks                                                                      nvim_goto_marks
      _    _    _    _    _    _    _    _    _    _    _    _    _                   _    _    _    _    _    _    _    _    _    _    _    _    _
      _    _    _    _    _    _    _    _    _    _    _    _    _    _              _    _    _    _    _    _    _    _    _    _    _    _    _    _
      _    @mA  @mO  @mE  @mU  _    _    _    _    _    _    _    _    _              _    @gA  @gO  @gE  @gU  _    _    _    _    _    _    _    _    _
      _    @ma  @mo  @me  @mu  _    _    _    _    _    _    _    _                   _    @ga  @go  @ge  @gu  _    _    _    _    _    _    _    _
      _    _    _    _    _    _    _    _    _    _    _    _         _              _    _    _    _    _    _    _    _    _    _    _    _         _
      _    _    _              @L1            @L2  _    _         _    _    _         _    _    _              @L1            @L2  _    _         _    _    _
    
    )"
}

