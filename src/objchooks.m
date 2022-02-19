#import "../include/objchooks.h"
#import "../include/objcutils.h"
#include <CydiaSubstrate.h>

BOOL (*old_fileExistsAtPath)(void* self, SEL _cmd, NSString* path) = NULL;
BOOL st_fileExistsAtPath(void* self, SEL _cmd, NSString* path){
  if (objc_isKnownBadPath(path)) {
    NSLog(@"[iHide] Hooked fileExistsAtPath -> %@", path);
    NSLog(@"[iHide] Patching fileExistsAtPath return: NO");
    return NO;
  }
  return old_fileExistsAtPath(self,_cmd,path);
}



void initObjCHooks() {
  MSHookMessageEx([NSFileManager class], @selector(fileExistsAtPath:), (IMP)st_fileExistsAtPath, (IMP *)&old_fileExistsAtPath);
}
