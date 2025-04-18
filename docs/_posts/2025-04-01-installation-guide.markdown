---
layout: post
title:  "Installation Guide"
date:   2025-04-01
categories: instructions
---

## Important disclaimer

Installing the prototype application differs from the usual way you would install applications on your android device. It is not distributed on the Google Play platform. Because of this, it is expected that you encounter one or more warnings from the system. These messages will inform you about the dangers of downloading and installing applications from outside sources due to the possibility of malware. This is why I want to emphasize some key aspects about the prototype application:

The application does not...
* Handle personal data
* Communicate over the internet
* Touch files that do not strictly belong to itself

I have personally tested and ran this application on my own device and scanned it via Google Play Protect (antimalware system) to detect harmful behaviour. However, if you are not comfortable installing the application on your device you can back down now, and not participate in the survey study. 

### Step 1. Download the Android Package Kit (apk) on your device

An apk is a file format used for distribution and installation of android apps. You may have never encountered one, but under the hood Google Play operates on .apk files whenever you install new apps on your device.

On your android device, tap the following link to begin downloading the apk file:
>[procrastinot-prototype-v-1-1-1.apk](https://github.com/Etex99/procrastinot_prototype/releases/download/v1.1.1/procrastinot-prototype-v-1-1-1.apk)

At this point you may receive a pop-up warning that states that the file type may be harmful to your system. This is a standard message the system prints for all apk files whether they are harmful or not. Bypass this message and keep the file anyway. 

### Step 2. Use the apk to install the app on your device

When the download has finished, tap the file named "procrastinot-prototype-v-1-1-1.apk" in the finished download pop-up of the browser or the notification tray banner.

Alternatively, you can find the file in the device's file explorer.
Different manufacturers of android devices use different names for their file explorer apps. For instance, Samsung calls theirs "My Files" while on my Nokia it's called simply "Files".
The folder location of the files may also differ between devices but one common place is a folder called "Downloads".

Tapping the file causes the system to prepare installation of the app. It is at this point that you most likely need to bypass a few warnings set out by the system to proceed.

If you receive "**installation blocked from unknown source**" or similar message, you must temporarily modify the device settings to allow installation of applications from unknown sources. The message should include a link to the correct settings location. On most devices, installation permission is granted for different applications separately. So, if you are installing the application from the "Files" app, you must grant installation from unknown sources permission to "Files". 

You may also receive a message stating that "**Google Play Protect does not recognize the application**". You may bypass this message directly, or let Google Play Protect scan the application to proceed with the installation.

Finally, you should receive a confirmation that the application was installed, and the application icon should have appeared in the app tray and possibly on one of the swipeable home screens. The application name is "Procrastinot Prototype" and the icon resembles the same icon as seen on the .apk file. 

>NOTE: for safety, after successfully installing the application disallow installation of applications from unknown sources again. Also, you may now delete the installed .apk file from the file system as it is no longer needed. 

### Step 3. (Optional but recommended) allow unrestricted battery usage for the app.

Allowing unrestricted battery usage to the app makes the system less prone to error. For instance, alert sounds are not played if the application enters a so called "doze" or "sleep" mode as part of the battery saving routine. This is a known issue in the prototype app.

Navigate to the App's settings. Typically, you can tap and hold the app icon and click a pop-up to see app info. Otherwise, in the "Settings" app the most typical route is "Apps" -> "Procrastinot Prototype".

Here, navigate to "Battery". You should be able to choose between three options: unrestricted, optimized, and restricted (wording may vary between devices). Choose the unrestricted option. 