# Create a Plot or User and System CPU Usage, update every 5 seconds
#
set title "GnuPlot - Fan Speed  and CPU Temperature"
set yrange [2650:2700] 
set ylabel "Fan Speed"
set y2range [43:49] 
set y2label "CPU Temp (C)"
set y2tics
set xdata time
set timefmt "%H:%M:%S"
set format x "%H:%M:%S"

system "sensors |grep RPM | awk '{print strftime(\"%H:%M:%S \", systime()) $3}' > fan.dat"
system "sensors | grep CPU | awk '{print strftime(\"%H:%M:%S \",systime()) substr($2,2,4)}'  > cpu.dat"

plot "fan.dat" using 1:2  with lines axes x1y1 title "fan speed (RPM)",  "cpu.dat" using 1:2 with lines axes x1y2 title "CPU Temp (C)"
while (1) {
	pause 5
	system "sensors |grep RPM | awk '{print strftime(\"%H:%M:%S \", systime()) $3}' >> fan.dat"
	system "sensors | grep CPU | awk '{print strftime(\"%H:%M:%S \", systime()) substr($2,2,4)}'  >> cpu.dat"
	replot
}