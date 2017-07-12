Improbability
=============

Test repository in order to get things started.

Added this line while logged onto github. Put an extra blank line in.

After I cloned to machine on LAN, I added this line.

## From LAN client
Now playing with _markdown_ in this README. Have added some additional files here so I can work on them whilst not at home.
These include currently,
* hello.rc
* filtertest.rc
* sandbox.rc
* sendmail.sh
* sendmailtest.sh
* test_filter.rc
* theatrixPostInstall.sh

#TESTING

### *Board Connection Table*

| __Function_> ||RX|TX|INT0|INT1|4|PWM|PWM|7|8|PWM|SS|MOSI|MISO|||||SDA|SCL
----|----------||---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---
| Digital pins ||0|1|2|3|4|5|6|7|8|9|10|11|12|13|(14)|(15)|(16)|(17)|(18)|(19)
| Analogue pins || | | | | | | | | | |  |  |  |0|1|2|3|4|5
pButton | PushButton ||||X|||||||||||||||||
oneWire | DS18B20 temperature sensor(s) ||0|1|2|3|4|X|6|7|8|9|10|11|12|13|(14)|(15)|(16)|(17)|(18)|(19)
SSR_PIN | Control output ||0|1|2|3|4|5|X|7|8|9|10|11|12|13|(14)|(15)|(16)|(17)|(18)|(19)
pushFb | LED in switch ||0|1|2|3|4|5|6|7|8|9|10|11|12|13|(14)|(15)|(16)|(17)|(18)|(19)
SS~ | Ethernet ||0|1|2|3|4|5|6|7|8|9|X|11|12|13|(14)|(15)|(16)|(17)|(18)|(19)
MOSI~ | Ethernet ||0|1|2|3|4|5|6|7|8|9|10|X|12|13|(14)|(15)|(16)|(17)|(18)|(19)
MISO | Ethernet ||0|1|2|3|4|5|6|7|8|9|10|11|X|13|(14)|(15)|(16)|(17)|(18)|(19)
SCK | Ethernet ||0|1|2|3|4|5|6|7|8|9|10|11|12|X|(14)|(15)|(16)|(17)|(18)|(19)
LOAD | CSLT Hall Effect current sensor? ||0|1|2|3|4|5|6|7|8|9|10|11|12|13|X|(15)|(16)|(17)|(18)|(19)
RED_PIN | Red LED ||0|1|2|3|4|5|6|7|8|9|10|11|12|13|(14)|X|(16)|(17)|(18)|(19)
GREEN_PIN | Green LED ||0|1|2|3|4|5|6|7|8|9|10|11|12|13|(14)|(15)|X|(17)|(18)|(19)
BLUE_PIN | Blue LED ||0|1|2|3|4|5|6|7|8|9|10|11|12|13|(14)|(15)|(16)|X|(18)|(19)

