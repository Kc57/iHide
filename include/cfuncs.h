#ifndef CFUNCS_H
#define CFUNCS_H

//#include <stdbool.h>
//#include <stddef.h>
//#include <string.h>
#include <sys/stat.h>
#include <dlfcn.h>

int stat(const char *restrict path, struct stat *restrict buf);
DIR * opendir(const char *dirname);
int posix_spawn(pid_t *restrict pid, const char *restrict path,
  const posix_spawn_file_actions_t *file_actions,
  const posix_spawnattr_t *restrict attrp, char *const argv[restrict],
  char *const envp[restrict]);

FILE * fopen(const char *restrict filename, const char *restrict mode);

const char* _dyld_get_image_name(uint32_t image_index);
int dladdr(const void *, Dl_info *);

#endif
