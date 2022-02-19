#include "../include/utility.h"

const char *statPaths[] = {
  "/Applications/Cydia.app",
  "/Applications/FakeCarrier.app",
  "/Applications/Icy.app",
  "/Applications/IntelliScreen.app",
  "/Applications/Loader.app",
  "/Applications/MxTube.app",
  "/Applications/RockApp.app",
  "/Applications/SBSettings.app",
  "/Applications/WinterBoard.app",
  "/Applications/blackra1n.app",
  "/Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate",
  "/Library/Frameworks/CydiaSubstrate.framework/Libraries/SubstrateLoader.dylib",
  "/Library/LaunchDaemons/com.openssh.sshd.plist",
  "/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
  "/Library/MobileSubstrate",
  "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
  "/Library/MobileSubstrate/DynamicLibraries/ProtectMyPrivacy.dylib",
  "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
  "/Library/MobileSubstrate/DynamicLibraries/WeeLoader.dylib",
  "/Library/MobileSubstrate/DynamicLibraries/xCon.dylib",
  "/Library/MobileSubstrate/MobileSubstrate.dylib",
  "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
  "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
  "/bin/bash",
  "/bin/mv",
  "/bin/sh",
  "/boot",
  "/dev",
  "/etc/apt",
  "/etc/ssh/sshd_config",
  "/private/var/lib/apt",
  "/private/var/lib/cydia",
  "/private/var/mobile/Library/SBSettings/Themes",
  "/private/var/mobileLibrary/SBSettingsThemes",
  "/private/var/stash",
  "/private/var/tmp/cydia.log",
  "/system/app/Superuser.apk",
  "/usr/bin/cycript",
  "/usr/bin/ssh",
  "/usr/bin/sshd",
  "/usr/binsshd",
  "/usr/lib/apt",
  "/usr/lib/libapt-inst.dylib",
  "/usr/lib/libcycript.dylib",
  "/usr/lib/tweakloader.dylib",
  "/usr/libexec/cydia",
  "/usr/libexec/sftp-server",
  "/usr/libexec/ssh-keysign",
  "/usr/local/bin/cycript",
  "/usr/sbin/frida-server",
  "/usr/sbin/sshd",
  "/usr/sbinsshd",
  "/var/cache/apt",
  "/var/lib/apt",
  "/var/lib/cydia",
  "/var/log/syslog",
  "/var/root",
  "/var/tmp/cydia.log",
  "/Library/MobileSubstrate/DynamicLibraries/ihide.dylib"
};

const char *spawnPaths[] = {
  "/bin/df",
  "/bin/ps",
  "/usr/bin/taskinfo",
  "/usr/bin/vm_stat",
  "/usr/sbin/ipconfig",
  "/usr/sbin/syslogd",
  "/usr/sbin/mDNSResponder"
};

const char *dylibList[] = {
  "AppList",
  "CustomWidgetIcons",
  "CydiaSubstrate",
  "MobileSafety",
  "MobileSubstrate",
  "OpenSiri",
  "PreferenceLoader",
  "RocketBootstrap",
  "SSLKillSwitch",
  "SSLKillSwitch2",
  "SubstrateLoader",
  "WeeLoader",
  "cydia",
  "cynject",
  "libapt-inst",
  "libcycrypt",
  "libjailbreak",
  "libsubstrate",
  "patcyh",
  "substrate",
  "tweakloader"
};

bool isKnownBadPath(const char *path)
{
  size_t i = 0;
  for( i = 0; i < sizeof(statPaths) / sizeof(statPaths[0]); i++)
  {
    if (strcmp(path, statPaths[i]) == 0)
    {
      return true;
    }
  }
  return false;
}

bool isKnownSpawnPath(const char *path)
{
  size_t i = 0;
  for( i = 0; i < sizeof(spawnPaths) / sizeof(spawnPaths[0]); i++)
  {
    if (strcmp(path, spawnPaths[i]) == 0)
    {
      return true;
    }
  }
  return false;
}

bool isKnownDylib(const char *path)
{
  size_t i = 0;
  for( i = 0; i < sizeof(dylibList) / sizeof(dylibList[0]); i++)
  {
    if (strstr(path, dylibList[i]) != NULL)
    {
      return true;
    }
  }
  return false;
}
