# Windows Setup

## Keyboard: CapsLock to Modifier Keys

`keyboard/caps-lock-to-modifier.ahk` remaps CapsLock so that holding it turns certain keys into shortcuts:

| CapsLock + | Action         |
| ---------- | -------------- |
| A          | Ctrl+Z (Undo)  |
| O          | Ctrl+X (Cut)   |
| E          | Ctrl+C (Copy)  |
| U          | Ctrl+V (Paste) |

### Setup

1. **Install AutoHotkey v2**: Download and install from https://www.autohotkey.com/

2. **Run on startup**:
   - Press `Win + R`, type `shell:startup`, and press Enter — this opens the Startup folder (should look something like this `C:\Users\YourUserName\AppData\Roaming\Microsoft\Windows\Start Menu\Programs`)
   - Copy `keyboard/caps-lock-to-modifier.ahk` into that folder
   - The script will now run automatically every time you log in
