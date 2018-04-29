PATH="~/.local/bin/:$PATH:/usr/sbin"

# Set mouse speed 
xinput set-prop 9 154 2.400000, 0.000000, 0.000000, 0.000000, 2.400000, 0.000000, 0.000000, 0.000000, 1.000000
bash /home/david/.local/bin/middle-click-scroll 9

if [ -x albert ]; then
    albert & 
fi

