## This stack overflow saved me...
```bash
hciconfig hci0 sspmode 1
hciconfig hci0 sspmode

hciconfig hci0 piscan
sdptool add SP
hcitool scan
rfcomm /dev/rfcomm0 <Address that was the output of the previos command> 1 &

```