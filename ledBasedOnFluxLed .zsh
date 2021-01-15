#!/bin/bash

echo "-----------"

while :
do
echo "1)color
2)poweroff
3)on
4)off
5)diy
6)404
7)scan
8)alarm
9)timeroff"
echo "-----------"
var_IP="192.168.3.59"
  read INPUT_STRING
  case $INPUT_STRING in
  color|1)
    echo "red >>"
    read red
    echo "green >>"
    read green
    echo "blue >>"
    read blue
    python -m flux_led $var_IP -c $red,$green,$blue

    ;;
  poweroff|2)
    echo time = hhmm
    echo ">>"
    read time
    python -m flux_led $var_IP -T 1 poweroff "time:$time"

    ;;
  on|3)
   python -m flux_led $var_IP --on
   ;;
   off|4)
   python -m flux_led $var_IP --off
   ;;
   diy|5)
     echo diy 1,2,3,4
      read var
     if [ "$var" = "1" ]
      then
        python -m flux_led $var_IP -c 123,16,255
     fi
     if [ "$var" = "2" ]
      then
        python -m flux_led $var_IP -c 130,92,200
     fi
     if [ "$var" = "3" ]
 then
        python -m flux_led $var_IP -c 0,136,255
     fi
      ;;
   error|404|6)
        read timerror
   sleep $timerror
   python -m flux_led $var_IP -C gradual 100 "(255,0,0) (0,0,0)"
   ;;
   scan|7)
    python -m flux_led -sSti
   ;;
   alarm|8)
        echo "Введите время первого будильника"
        read time1
        echo "Введите время второго будильника"
        read time2
    python -m flux_led $var_IP -T 1 preset "time:$time1;code:49;speed:100"

    python -m flux_led $var_IP -T 2 preset "time:$time2;code:48;speed:100"
    ;;
   timeroff|9)
    echo "Number of timer >>"
    read timer
   python -m flux_led $var_IP -T "$timer" inactive ""
  ;;
  *)
    echo "Sorry, I don't understand"
    ;;
 esac
done
echo
echo "That's all folks!"
fi
