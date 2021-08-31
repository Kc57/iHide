#ifndef UTILITY_H
#define UTILITY_H

#include <stdbool.h>
#include <stddef.h>
#include <string.h>

bool isKnownBadPath(const char *path);
bool isKnownSpawnPath(const char *path);
bool isKnownDylib(const char *path);

#endif
