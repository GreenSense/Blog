layout: post
title: Arduino Soil Moisture Sensor Calibration
date: 2017-02-17 22:44:29
tags:
---

## Basics

If you're not familiar with arduino based soil moisture sensors check out the [soil moisture sensor basics](/Blog/2017/02/16/Arduino-Soil-Moisture-Sensor-Basics/).

## The Problem

Soil moisture sensors return somewhat arbitrary values which need to be converted into something user friendly.

Example readings:

| Sensor         | Dry           | Wet         |
| -------------- | -----------   | ----------- |     
| 2 Pin          | 1023          | 292         |
| 3 Pin          | 0             | 773         |

In theory the full range for an arduino based soil moisture sensor is 0 to 1023. In practice some of that range is lost however shouldn't matter.

For a percentage output it's preferrable to have a difference between wet and dry readings of at least 100.

## Calibration

Calibration can be done using the map() function:

{% codeblock %}
int friendlyValue = map(rawValue, dryValue, wetValue, friendlyDryValue, friendlyWetValue);
{% endcodeblock %}

## Example Sketch

{% codeblock %}
int dryValue = 0;
int wetValue = 1023;

int friendlyDryValue = 0;
int friendlyWetValue = 100;

void setup() {
  Serial.begin(9600);
}

void loop() {
  int rawValue = analogRead(A0);

  Serial.print("Raw: ");
  Serial.print(rawValue);

  Serial.print(" | ");
  
  int friendlyValue = map(rawValue, dryValue, wetValue, friendlyDryValue, friendlyWetValue);
  
  Serial.print("Friendly: ");
  Serial.print(friendlyValue);
  Serial.println("%");
  
  delay(500);
}
{% endcodeblock %}

That sketch should produce the following result with a dry soil moisture sensor.

2 pin sensor:
{% codeblock %}
Raw: 1021 | Friendly: 99%
Raw: 1021 | Friendly: 99%
Raw: 1022 | Friendly: 99%
Raw: 1023 | Friendly: 99%
Raw: 1021 | Friendly: 99%
{% endcodeblock %}

3 pin sensor:
{% codeblock %}
Raw: 0 | Friendly: 0%
Raw: 0 | Friendly: 0%
Raw: 0 | Friendly: 0%
Raw: 0 | Friendly: 0%
Raw: 0 | Friendly: 0%
{% endcodeblock %}

## Reverse Values

As you can see the result above is backwards for the 2 pin sensor (ie. it shows 99% when it should show 0%). The easiest way to fix that is swap the values around so this:

{% codeblock %}
int dryValue = 0;
int wetValue = 1023;
{% endcodeblock %}

...becomes...

{% codeblock %}
int dryValue = 1023;
int wetValue = 0;
{% endcodeblock %}

Swapping these values around should make it show 0% when dry, however this doesn't fully calibrate the sensor.

Submerge the sensor in water and you might see something like this when it is supposed to show 100%:

{% codeblock %}
Raw: 660 | Friendly: 64%
Raw: 662 | Friendly: 64%
Raw: 663 | Friendly: 64%
Raw: 664 | Friendly: 64%
Raw: 664 | Friendly: 64%
{% endcodeblock %}

## Custom Calibration

To properly calibrate the soil moisture sensor you need to first find the minimum and maximum values for the sensor and the soil. Different soil types may have different conductivity levels and therefore may need to be calibrated differently.

### Find wet and dry values

1) Place the soil moisture sensor in dry soil and note down the raw value.

2) Place the soil moisture sensor in wet soil and note down the raw value.

### Edit the sketch

Edit the following values in the sketch to match your minimum and maxium sensor readings:

{% codeblock %}
int dryValue = 0;
int wetValue = 1023;
{% endcodeblock %}

So they look like this:

{% codeblock %}
int dryValue = 0;
int wetValue = 758;
{% endcodeblock %}

... or like this ...

{% codeblock %}
int dryValue = 1023;
int wetValue = 302;
{% endcodeblock %}

Note: Make sure you use values which match your sensor. If these values provided don't work for your sensor then you will need to adjust them.

Upload/run the modified sketch and now you should get values from 0 to 100 (or close). If you don't then check the minimum and maximum readings and adjust the code again.