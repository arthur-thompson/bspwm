#!/usr/bin/env sh

MAINFONT="-*-terminus-medium-*-*-*-14-*-*-*-*-*-*-*"
BARHEIGHT=16
FGCOLOR="#ffffff"
BGCOLOR="#000000"

color3="#8b8680"
color7="#ffffff"

clock() {
	TIME=`date +"%a %b %d %I:%M %p"`
	echo "$TIME"
}

#battery() {
#	
#	BAT=`acpi -b | awk -F ': ' '{print $2}'`
#
#echo "$BAT"
#}

Workspaces() {
	ACTUAL=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')
	case $ACTUAL in
		0)
			echo -n "%{F$color7} I%{F$color3} II III IV V%{F$color7}"
		;;

		1)
			echo -n "%{F$color3} I %{F$color7}II%{F$color3} III IV V%{F$color7}"
		;;

		2)
			echo -n "%{F$color3} I II%{F$color7} III%{F$color3} IV V%{F$color7}"
		;;
		3)
			echo -n "%{F$color3} I II III%{F$color7} IV %{F$color3}V%{F$color7}"
		;;

		4)
			echo -n "%{F$color3} I II III IV %{F$color7}V%{F$color7}"
		;;
	esac
}

if pgrep lemonbar > /dev/null; then
    killall lemonbar
fi

while true; do
    # panel_layout="%{l}$(groups)  $(title)  %{r} $(tasks) | $(battery) | $(clock) "

        # panel_layout="%{l}$(groups)  $(title)  %{r} $(tasks) | $(battery) | $(clock) "
	panel_layout="%{l} $(Workspaces) %{r} $(clock)"
        echo "${panel_layout} "

	sleep 5
done | lemonbar -d -g x"${BARHEIGHT}" -B "${BGCOLOR}" -F "${FGCOLOR}" -f "$MAINFONT" | sh > /dev/null 2>&1
