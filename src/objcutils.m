#import "../include/objcutils.h"

bool objc_isKnownBadPath(NSString *path) {
  NSArray *bad_paths = [NSArray arrayWithObjects:
  @"/.bootstrapped_electra",
  @"/.cydia_no_stash",
  @"/.installed_unc0ver",
  @"/Applications/blackra1n.app",
  @"/Applications/Cydia.app",
  @"/Applications/FakeCarrier.app",
  @"/Applications/Filza.app",
  @"/Applications/Icy.app",
  @"/Applications/IntelliScreen.app",
  @"/Applications/MxTube.app",
  @"/Applications/RockApp.app",
  @"/Applications/SBSettings.app",
  @"/Applications/SBSetttings.app",
  @"/Applications/Sileo.app",
  @"/Applications/Snoop-itConfig.app",
  @"/Applications/TrustMe.app",
  @"/Applications/WinterBoard.app",
  @"/bin/bash",
  @"/bin/sh",
  @"/etc/apt",
  @"/etc/apt/sources.list.d/electra.list",
  @"/etc/apt/sources.list.d/sileo.sources",
  @"/etc/apt/undecimus/undecimus.list",
  @"/etc/ssh/sshd_config",
  @"/jb/amfid_payload.dylib",
  @"/jb/jailbreakd.plist",
  @"/jb/libjailbreak.dylib",
  @"/jb/lzma",
  @"/jb/offsets.plist",
  @"/Library/MobileSubstrate/CydiaSubstrate.dylib",
  @"/Library/MobileSubstrate/DynamicLibraries/Liberty.plist",
  @"/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
  @"/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
  @"/Library/MobileSubstrate/DynamicLibraries/zLiberty.plist",
  @"/Library/MobileSubstrate/DynamicLibraries/zzLiberty.plist",
  @"/Library/MobileSubstrate/DynamicLibraries/zzzLiberty.plist",
  @"/Library/MobileSubstrate/DynamicLibraries/zzzzLiberty.plist",
  @"/Library/MobileSubstrate/DynamicLibraries/zzzzzLiberty.plist",
  @"/Library/MobileSubstrate/MobileSubstrate.dylib",
  @"/Library/PreferenceBundles/ABypassPrefs.bundle",
  @"/Library/PreferenceBundles/FlyJBPrefs.bundle",
  @"/Library/PreferenceBundles/LibertyPref.bundle",
  @"/Library/PreferenceBundles/ShadowPreferences.bundle",
  @"/private/etc/apt",
  @"/private/etc/dpkg/origins/debian",
  @"/private/etc/ssh/sshd_config",
  @"/private/var/cache/apt",
  @"/private/var/lib/apt",
  @"/private/var/lib/cydia",
  @"/private/var/log/syslog",
  @"/private/var/mobile/Library/SBSettings/Themes",
  @"/private/var/stash",
  @"/private/var/tmp/cydia.log",
  @"/private/var/Users",
  @"/System/Library/LaunchDaemons/com.ikey.bbot.plist",
  @"/System/Library/LaunchDaemons/com.saurik.Cy@dia.Startup.plist",
  @"/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
  @"/usr/bin/cycript",
  @"/usr/bin/ssh",
  @"/usr/bin/sshd",
  @"/usr/libexec/cydia",
  @"/usr/libexec/cydia/firmware.sh",
  @"/usr/libexec/sftp-server",
  @"/usr/libexec/ssh-keysign",
  @"/usr/lib/libcycript.dylib",
  @"/usr/lib/libhooker.dylib",
  @"/usr/lib/libjailbreak.dylib",
  @"/usr/lib/libsubstitute.dylib",
  @"/usr/lib/substrate",
  @"/usr/lib/TweakInject",
  @"/usr/local/bin/cycript",
  @"/usr/sbin/frida-server",
  @"/usr/sbin/sshd",
  @"/usr/share/jailbreak/injectme.plist",
  @"/var/binpack",
  @"/var/cache/apt",
  @"/var/checkra1n.dmg",
  @"/var/lib/apt",
  @"/var/lib/cydia",
  @"/var/lib/dpkg/info/mobilesubstrate.md5sums",
  @"/var/log/apt",
  @"/var/log/syslog",
  @"/var/tmp/cydia.log",
  nil];
  for(NSString *str in bad_paths) {
    NSString *strParam = path;
    if([strParam hasSuffix:@"/"]) {
      // Remove trailing '/'
      strParam = [strParam substringToIndex:[strParam length]-1];
    }
    // do a case insensitive comparison against the paths
    if( [str caseInsensitiveCompare:strParam] == NSOrderedSame ) {
      //NSLog(@"[iHide] Hooked fileExistsAtPath -> %@", str);
      //NSLog(@"[iHide] Patching fileExistsAtPath return: NO");
      return true;
    }
  }

  // default return if we don't match any paths
  return false;

}
