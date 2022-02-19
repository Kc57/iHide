//#include <Foundation/NSObjCRuntime.h>
//#include <Foundation/NSUserActivity.h>
//#include <Foundation/NSArray.h>
//#include <Foundation/NSURL.h>

// Use this in a hook for a stack trace
// NSLog(@"[iHide] %@",[NSThread callStackSymbols]);

#import <Foundation/Foundation.h>
#include <dirent.h>
#include <spawn.h>
#include "include/cfuncs.h"
#include "include/utility.h"
#import "include/objcutils.h"

#define _PLIST @"/var/mobile/Library/Preferences/com.kc57.ihideprefs.plist"
#define pref_getValue(key) [[NSDictionary dictionaryWithContentsOfFile:_PLIST] valueForKey:key]
#define pref_getBool(key) [pref_getValue(key) boolValue]

static bool isEnabled = NO;
static NSString *nsNotificationString = @"com.kc57.ihideprefs/settingschanged";

// jailbreak enabled/disabled group
%group GROUP_JAILBREAK_DETECTION_BYPASS


%hook UIApplication
- (BOOL)canOpenURL:(NSURL *)url {
  NSArray *url_schemes = @[
  @"cydia",
  @"sileo",
  @"undecimus"];
  for(NSString *str in url_schemes) {
    if ([[url scheme] isEqualToString:str]) {
      NSLog(@"[iHide] Hooked -[UIApplication canOpenURL:] -> %@", [url absoluteString]);
      NSLog(@"[iHide] Patching -[UIApplication canOpenURL:] return: NO");
      return NO;
    }
  }
  return %orig;
}
// -[UIApplication canOpenURL:]
%end


%hook NSURL
+ (instancetype)URLWithString:(NSString *)URLString {
  NSArray *url_schemes = @[
  @"cydia",
  @"sileo",
  @"undecimus"];
  for(NSString *str in url_schemes) {
    if ([URLString hasPrefix:str]) {
      NSLog(@"[iHide] Hooked +[NSURL URLWithString:] -> %@", URLString);
      NSLog(@"[iHide] Patching +[NSURL URLWithString:] return: nil");
      return nil;
    }
  }
  return %orig;
}
// +[NSURL URLWithString:]
%end

%hook NSString
- (BOOL)writeToFile:(NSString *)path
  atomically:(BOOL)useAuxiliaryFile
  encoding:(NSStringEncoding)enc
  error:(NSError * _Nullable *)error {
    NSArray *bad_paths = @[
    @"/private/"
    ];
    for(NSString *str in bad_paths) {
      if ([path hasPrefix:str]) {
        NSLog(@"[iHide] Hooked -[NSString writeToFile:atomically:encoding:error:] -> %@", path);
        NSLog(@"[iHide] Patching -[NSString writeToFile:atomically:encoding:error:] return: NO");
        *error = [[NSError alloc] initWithDomain:@"NSCocoaErrorDomain" code:NSFileWriteNoPermissionError userInfo:@{}];
        return NO;
      }
    }
    //NSLog(@"[iHide] Hooked -[NSString writeToFile:atomically:encoding:error:]\npath: %@ \nreturn: %@", path, retval ? @"Yes" : @"No");
    //NSLog(@"[iHide] -[NSString writeToFile:atomically:encoding:error:] return: %@", retval ? @"Yes" : @"No");
    //NSLog(@"[iHide] -[NSString writeToFile:atomically:encoding:error:] error: %@", [myError localizedDescription]);
    return %orig;
}
// -[NSString writeToFile:atomically:encoding:error:]
%end


%hook NSFileManager
- (BOOL)fileExistsAtPath:(NSString *)path {

  if (objc_isKnownBadPath(path)) {
    NSLog(@"[iHide] Hooked fileExistsAtPath -> %@", path);
    NSLog(@"[iHide] Patching fileExistsAtPath return: NO");
    return NO;
  }

  // If we didn't find any file checks we care about, return the original value
  return %orig;
}
// -[NSFileManager fileExistsAtPath:]
%end

// ============ System calls ============

%hookf(int, stat, const char *restrict path, struct stat *restrict buf) {
  if(isKnownBadPath(path))
  {
    NSLog(@"[iHide] hooking stat path: %s", path);
    return -1;
  }
  // Call the original implementation of this function
  return %orig;
}

%hookf(int, lstat, const char *restrict path, struct stat *restrict buf) {
  if(isKnownBadPath(path))
  {
    NSLog(@"[iHide] hooking lstat path: %s", path);
    return -1;
  }
  // Call the original implementation of this function
  return %orig;
}

%hookf(DIR *, opendir, const char *dirname) {
  if (isKnownBadPath(dirname))
  {
    NSLog(@"[iHide] hooking opendir dirname: %s", dirname);
    return NULL;
    //NSLog(@"[iHide] %@",[NSThread callStackSymbols]);
  }
  // Call the original implementation of this function
  return %orig;
}

%hookf(DIR *, fopen, const char *restrict filename, const char *restrict mode) {
  if (isKnownBadPath(filename))
  {
    NSLog(@"[iHide] hooking fopen filename: %s", filename);
    return NULL;
    //NSLog(@"[iHide] %@",[NSThread callStackSymbols]);
  }
  // Call the original implementation of this function
  return %orig;
}


%hookf(int, posix_spawn, pid_t *restrict pid, const char *restrict path, const posix_spawn_file_actions_t *file_actions, const posix_spawnattr_t *restrict attrp, char *const argv[restrict], char *const envp[restrict]) {
  if(isKnownSpawnPath(path))
  {
    NSLog(@"[iHide] hooking posix_spawn path: %s", path);
    return -1;
  }
  // Call the original implementation of this function
  return %orig;
}

%hookf(const char*, _dyld_get_image_name, uint32_t image_index) {
  // Call the original implementation of this function and store the return
  const char* retval = %orig;

  // Check the return for known files to hide
  if(isKnownDylib(retval))
  {
    NSLog(@"[iHide] hooking _dyld_get_image_name(%d): %s", image_index, retval);
    const char* newRetVal = "";
    return newRetVal;
  }
  return retval;
}

// end GROUP_JAILBREAK_DETECTION_BYPASS
%end

static void loadPrefs()
{
  NSLog(@"[iHide] loadPrefs called");
  isEnabled = pref_getBool(@"AwesomeSwitch1") ?: isEnabled;

  if(isEnabled)
  {
    NSLog(@"[iHide] isEnabled: YES");
  } else {
    NSLog(@"[iHide] isEnabled: NO");
  }

}

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  NSLog(@"[iHide] notificationCallback called");
  loadPrefs();
}

%ctor {
    NSLog(@"[iHide] ctor enter...");
    loadPrefs();

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, notificationCallback, (CFStringRef)nsNotificationString, NULL, CFNotificationSuspensionBehaviorCoalesce);

    // If the tweak is not enabled then return
    if (!isEnabled) {
      NSLog(@"[iHide] not enabled, leaving...");
      return;
    }
    else {
      NSLog(@"[iHide] enabled!");
    }

    NSBundle* mainBundle = [NSBundle mainBundle];
    if (mainBundle) {
		    NSString* bundleIdentifier = mainBundle.bundleIdentifier;

        if (bundleIdentifier) {
          NSLog(@"[iHide] Checking if filter enabled for bundle: %@", bundleIdentifier);

          if (pref_getBool([@"EnabledApps-" stringByAppendingString:bundleIdentifier])) {
            NSLog(@"[iHide] Enabled for bundle: %@", bundleIdentifier);
            %init(GROUP_JAILBREAK_DETECTION_BYPASS);
          }
          else {
              NSLog(@"[iHide] Disabled for bundle: %@", bundleIdentifier);
          }

        }
      }

      NSLog(@"[iHide] ctor leave...");
}
