#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

battery_percent()
{
  echo $(pmset -g batt | grep -Eo '[0-9]?[0-9]?[0-9]%')
}

battery_status()
{
  status=$(pmset -g batt | sed -n 2p | cut -d ';' -f 2 | tr -d " ")

  tmp_bat_perc=$(battery_percent)
  bat_perc="${tmp_bat_perc%\%}"

  case $status in
    discharging|Discharging)
      # discharging, no AC
      declare -A battery_labels=(
        [0]="󰂎"
        [10]="󰁺"
        [20]="󰁻"
        [30]="󰁼"
        [40]="󰁽"
        [50]="󰁾"
        [60]="󰁿"
        [70]="󰂀"
        [80]="󰂁"
        [90]="󰂂"
        [100]="󰁹"
      )
      echo "${battery_labels[$((bat_perc/10*10))]:-󰂃}"
      ;;
    high|charged|Full)
      echo "󰁹"
      ;;
    charging|Charging)
      # charging from AC
      declare -A battery_labels=(
        [0]="󰢟"
        [10]="󰢜"
        [20]="󰂆"
        [30]="󰂇"
        [40]="󰂈"
        [50]="󰢝"
        [60]="󰂉"
        [70]="󰢞"
        [80]="󰂊"
        [90]="󰂋"
        [100]="󰂅"
      )
      echo "${battery_labels[$((bat_perc/10*10))]:-󰂃}"
      ;;
    ACattached)
      # drawing from AC but not charging
      echo ''
      ;;
    finishingcharge)
      echo '󰂅'
      ;;
    *)
      # something wrong...
      echo ''
      ;;
  esac
}

main()
{
  bat_stat=$(battery_status)

  bat_perc=$(battery_percent)

  echo "$bat_stat $bat_perc"
}

#run main driver program
main
