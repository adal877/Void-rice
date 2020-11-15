;==========================================================
;
;
;   ██████╗  ██████╗ ██╗  ██╗   ██╗██████╗  █████╗ ██████╗
;   ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝██╔══██╗██╔══██╗██╔══██╗
;   ██████╔╝██║   ██║██║   ╚████╔╝ ██████╔╝███████║██████╔╝
;   ██╔═══╝ ██║   ██║██║    ╚██╔╝  ██╔══██╗██╔══██║██╔══██╗
;   ██║     ╚██████╔╝███████╗██║   ██████╔╝██║  ██║██║  ██║
;   ╚═╝      ╚═════╝ ╚══════╝╚═╝   ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
;
;
;   To learn more about how to configure Polybar
;   go to https://github.com/polybar/polybar
;
;   The README contains a lot of information
;
;==========================================================

[colors]
background = #000
background-alt = #444
foreground = #dfdfdf
foreground-alt = #555
primary = #ffb52a
secondary = #e60053
alert = #bd2c40

[bar/dual]
monitor = DP1
width = 100%
height = 27
;offset-x = 1%
;offset-y = 1%
radius = 0.0
fixed-center = false

background = ${colors.background}
foreground = ${colors.foreground}

line-size = 3
line-color = #f00

border-size = 0
border-color = #00000000

padding-left = 0
padding-right = 2

module-margin-left = 1
module-margin-right = 2

font-0 = fixed:pixelsize=10;1
font-1 = unifont:fontformat=truetype:size=8:antialias=false;0
font-2 = siji:pixelsize=20;1

modules-left = i3 xkeyboard 
modules-center = xwindow 
modules-right =  temperature cpu battery powermenu

tray-position = right
tray-padding = 2

cursor-click = pointer
cursor-scroll = ns-resize

[module/xwindow]
type = internal/xwindow
label = %title:0:30:...%

[module/xkeyboard]
type = internal/xkeyboard
blacklist-0 = num lock

format-prefix = " "
format-prefix-foreground = #ffffff
format-prefix-underline = ${colors.secondary}

label-layout = %layout%
label-layout-underline = ${colors.secondary}

label-indicator-padding = 2
label-indicator-margin = 1
label-indicator-background = ${colors.secondary}
label-indicator-underline = ${colors.secondary}

[module/i3]
type = internal/i3
format = <label-state> <label-mode>
index-sort = true
wrapping-scroll = false

; Only show workspaces on the same output as the bar
pin-workspaces = false

label-mode-padding = 2
label-mode-foreground = #000
label-mode-background = #263238

; focused = Active workspace on focused monitor
label-focused = %index%
label-focused-background = #263238
label-focused-underline= #263238
label-focused-padding = 2

; unfocused = Inactive workspace on any monitor
label-unfocused = %index%
label-unfocused-padding = 2

; visible = Active workspace on unfocused monitor
label-visible = %index%
label-visible-background = ${self.label-focused-background}
label-visible-underline = ${self.label-focused-underline}
label-visible-padding = ${self.label-focused-padding}

; urgent = Workspace with urgency hint set
label-urgent = %index%
label-urgent-background = ${colors.alert}
label-urgent-padding = 2

; Separator in between workspaces
label-separator = ●
label-separator-background = #263238

[module/battery]
type = internal/battery
battery = BAT0
adapter = ADP1
full-at = 98

format-charging = <animation-charging> <label-charging>
format-charging-foreground = #ffffff
format-charging-underline = #00c206

format-discharging = <animation-discharging> <label-discharging>
format-discharging-foreground = #ffffff
format-discharging-underline = #fae500

format-full-prefix = " "
format-full-foreground = #ffffff
format-full-prefix-foreground = ${colors.foreground-alt}
format-full-underline = #ffffff

ramp-capacity-0 = 
ramp-capacity-1 = 
ramp-capacity-2 = 
ramp-capacity-foreground = #ffffff

animation-charging-0 = 
animation-charging-1 = 
animation-charging-2 = 
animation-charging-foreground = #ffffff
animation-charging-framerate = 750

animation-discharging-0 = 
animation-discharging-1 = 
animation-discharging-2 = 
animation-discharging-foreground = #ffffff
animation-discharging-framerate = 750

[module/temperature]
type = internal/temperature
thermal-zone = 0
warn-temperature = 60

format = <ramp> <label>
format-foreground = #ffffff
format-underline = #f50a4d
format-warn = <ramp> <label-warn>
format-warn-underline = ${self.format-underline}

label = %temperature-c%
label-warn = %temperature-c%
label-warn-foreground = ${colors.secondary}

ramp-0 = 
ramp-1 = 
ramp-2 = 
ramp-foreground = #ffffff

[module/powermenu]
type = custom/menu

expand-right = true

label-open = "  "
label-open-font = 4
label-open-foreground = #ffffff
label-open-background = #478061
label-close = "  cancel "
label-close-foreground = #ffffff
label-close-background = #478061
label-separator = ●
label-separator-foreground = #ffffff
label-separator-background = #478061

menu-0-0 = " ∇reboot "
menu-0-0-exec = sudo reboot now
menu-0-0-foreground = #ffffff
menu-0-0-background = #478061

menu-0-1 = " exit"
menu-0-1-exec = i3-msg exit
menu-0-1-foreground = #ffffff
menu-0-1-background = #478061

menu-0-2 = " ∆power off "
menu-0-2-exec =sudo  shutdown now
menu-0-2-foreground = #ffffff
menu-0-2-background = #478061

[settings]
screenchange-reload = true

[global/wm]
margin-top = 5
margin-bottom = 5

; vim:ft=dosini
