#ifndef OBJCUTILS_H
#define OBJCUTILS_H

#import <Foundation/Foundation.h>

bool objc_isKnownBadPath(NSString *path);
void updateMethodDict(NSMutableDictionary * dictMethods);

#endif
