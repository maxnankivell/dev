#Requires AutoHotkey v2.0

#HotIf GetKeyState("CapsLock", "P")
a:: ModifyKey('z')
o:: ModifyKey('x')
e:: ModifyKey('c')
u:: ModifyKey('v')
#HotIf

ModifyKey(key) {
    Send '^{' . key . '}'
    SetCapsLockState 0
}

;ADD ESCAPE

; #Requires AutoHotkey v2.0

; ; Prevent Caps Lock from acting like a normal toggle key
; SetCapsLockState("AlwaysOff")

; ; Handle the Tap for Escape behavior
; *CapsLock::
; {
;     KeyWait("CapsLock")

;     ; If no other key was pressed while Caps Lock was held, send Escape
;     if (A_PriorKey = "CapsLock")
;     {
;         Send("{Escape}")
;     }
; }

; ; Handle the Hold for Modifier behavior
; #HotIf GetKeyState("CapsLock", "P")
;     a::ModifyKey('z')
;     o::ModifyKey('x')
;     e::ModifyKey('c')
;     u::ModifyKey('v')
; #HotIf

; ModifyKey(key)
; {
;     Send('^{' . key . '}')
; }

;ANOTHER ADD ESCAPE METHOD

; #Requires AutoHotkey v2.0

; capsHeldDown := false

; *CapsLock::
; {
;     global capsHeldDown
;     capsHeldDown := false
;     KeyWait "CapsLock"
;     if (!capsHeldDown) {
;         Send "{Escape}"
;     }
; }

; #HotIf GetKeyState("CapsLock", "P")
;     a::ModifyKey('z')
;     o::ModifyKey('x')
;     e::ModifyKey('c')
;     u::ModifyKey('v')
; #HotIf

; ModifyKey(key)
; {
;     global capsHeldDown
;     capsHeldDown := true
;     Send '^{' . key . '}'
;     SetCapsLockState 0
; }

;OLD

; capslockDown := 0

; CapsLock:: {
;     global
;     capslockDown := 1
;     SetCapsLockState !GetKeyState("CapsLock", "T")
; }
; CapsLock UP:: {
;     global
;     capslockDown := 0
; }
; *CapsLock:: return

; #HotIf capslockDown
;     a:: {
;         Send '^{z}'
;         SetCapsLockState 0
;     }
;     o:: {
;         Send '^{x}'
;         SetCapsLockState 0
;     }
;     e:: {
;         Send '^{c}'
;         SetCapsLockState 0
;     }
;     u:: {
;         Send '^{v}'
;         SetCapsLockState 0
;     }
; #HotIf
