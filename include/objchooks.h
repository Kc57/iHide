#ifndef OBJCHOOKS_H
#define OBJCHOOKS_H

#import <Foundation/Foundation.h>

BOOL st_fileExistsAtPath(void* self, SEL _cmd, NSString* path);

void initObjCHooks();

#endif
