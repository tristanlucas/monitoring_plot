#!/usr/bin/gnuplot -persist

# CPU Usage Data Collection (replace with your Bash script logic)
datafile = "cpu_usage.dat"
set output datafile
do for [i=0:100] {
  current_time = strftime("%S")
  cpu_usage = rand(100)  # Replace with actual CPU usage calculation
  print current_time, cpu_usage
  pause 1
}
set output

# Plotting Section
reset
set term x11
set title "Real-Time CPU Usage (Live)"
set xlabel "Time (seconds)"
set ylabel "CPU Usage (%)"
set grid

set xdata time
set timefmt "%S"
set xrange [time - 20:time]  # Initial x-axis range (20 seconds)

set key left box
plot datafile using 1:2 with lines title "CPU Usage" noautoscale x

do for [i=0:100] {
  pause 1
  reread
  set xrange [time - 20:time]
}
