#Requires AutoHotkey v2.0                        

#HotIf GetKeyState("CapsLock", "P")
    a::ModifyKey('z')
    o::ModifyKey('x')
    e::ModifyKey('c')
    u::ModifyKey('v')
#HotIf

ModifyKey(key)
{
    Send '^{' . key . '}'
    SetCapsLockState 0
}


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
