layout: post
title: Arduino Soil Moisture Sensor Basics
date: 2017-02-16 22:02:47
tags:
---
## Introduction

Soil moisture sensors can be used to determine approximately how much moisture is in soil, based on how much electricity the soil conducts.
While these resistive soil moisture sensors are not perfect, they can still be useful.

This post presumes you're familiar with the basics of uploading a sketch to an arduino and viewing the output via serial monitor.
If not then you should check out the [arduino basics](/Blog/2017/02/16/Arduino-Basics/).

## Resources
- [2 pin Soil Moisture Sensor Module Guide](https://randomnerdtutorials.com/guide-for-soil-moisture-sensor-yl-69-or-hl-69-with-the-arduino/)
- [3 pin Soil Moisture Sensor Module Guide](https://learn.sparkfun.com/tutorials/soil-moisture-sensor-hookup-guide)

## Sensor Modules

Multiple types of soil moisture sensor are available:

### Two Pin
![](images/DSC04953.jpg)

A two pin soil moisture sensor needs to be connected via an adapter module:

![](images/DSC04961.jpg)

### Three Pin
![](images/DSC04956.jpg)


## Wiring

| Color       | Arduino        | 2 Pin Sensor    | 3 Pin Sensor    |
| ----------  | -------------- | -----------     | -----------     |     
| blue        | A0             | A0              | S               |
| red         | V (5v)         | VCC             | +               |
| black       | G (GND)        | GND             | -               |

![](images/DSC04946.jpg)

![](images/DSC04940.jpg)

Note: The two pin soil moisture sensor itself has no polarity which is why there are no + and - symbols on it. It can be connected to the adapter module either way.

## Test the Sensor

1) Open the AnalogReadSerial example sketch
    (File -> Examples -> Basic -> AnalogReadSerial in Arduino IDE)

{% codeblock %}
void setup() {
  Serial.begin(9600);
}

void loop() {
  int sensorValue = analogRead(A0);
  Serial.println(sensorValue);
  delay(1);
}
{% endcodeblock %}

2) Click the upload button and wait for it to finish
    
3) Open up the serial monitor and ensure the baud rate is 9600. Depending on which sensor you're using it should show something like this:

Two Pin Sensor (dry)

{% codeblock %}
1022
1023
1022
1023
1023
{% endcodeblock %}

Three Pin Sensor (dry)

{% codeblock %}
0
0
0
0
0
{% endcodeblock %}

4) Put the soil moisture sensor into a glass of water and it should change to something like this:

Two Pin Sensor (wet)

{% codeblock %}
302
302
302
302
302
{% endcodeblock %}

Three Pin Sensor (wet)

{% codeblock %}
757
758
758
758
757
{% endcodeblock %}

The numbers will vary depending on the sensor and various other factors.
It doesn't matter what the numbers are as long as there is a significant difference between dry readings and wet/submerged readings.

[Use software calibration](/Blog/2017/02/17/Arduino-Soil-Moisture-Sensor-Calibration/) to turn these raw values into something more user friendly.