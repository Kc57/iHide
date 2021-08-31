# iHide
A utility for hiding jailbreak from iOS applications

![iHide Banner](_docs/images/banner.png?raw=true)

## Description
Once installed, iHide will add a new entry in the iOS settings pane that can be used to enable/disable bypassing common jailbreak detection methods. Simply enable iHide, select any applications to enable it for, and iHide will attempt to bypass common jailbreak detection techniques.

## Easy Installation
You can install iHide by adding the repo [https://repo.kc57.com](https://repo.kc57.com) in Cydia or Sileo.

## Manual Installation
On iOS, iHide can be installed as a Cydia Subtrate tweak on a jailbroken device.

The following dependencies should be installed using Cydia:

* mobilesubstrate
* applist
* com.rpetrich.rocketbootstrap
* preferenceloader

Then, download the latest pre-compiled package available in the release tab of
the iHide GitHub page. Copy it to the device, install it and
respring the device:
```
dpkg -i <package>.deb
killall -HUP SpringBoard
```
There should be a new menu in the device's Settings where you can
enable the extension.

The tweak can later be uninstalled using:
```
dpkg -r com.kc57.ihide
```

## Author
Rob Simon - @_Kc57
