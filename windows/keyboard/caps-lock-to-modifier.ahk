#Requires AutoHotkey v2.0

SetCapsLockState "AlwaysOff"

; Tapping CapsLock on its own is esc
CapsLock:: Send "{Esc}"

; Holding CapsLock acts as a modifier key
CapsLock & a:: Send "^z"
CapsLock & o:: Send "^x"
CapsLock & e:: Send "^c"
CapsLock & u:: Send "^v"