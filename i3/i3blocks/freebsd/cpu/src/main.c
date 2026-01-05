#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
  (void)argc;
  (void)argv;

  double la[3] = {0};
  if (getloadavg(la, 3) == -1) {
    perror("getloadavg");
    return 1;
  }
  long ncpu = sysconf(_SC_NPROCESSORS_ONLN);
  if (ncpu < 1)
    ncpu = 1;

  static const char *green = "#00db16";
  static const char *yellow = "#ffff40";
  static const char *red = "#c90007";
  double percent = (la[0] / (double)ncpu) * 100.;

  const char *color = green;
  if (percent < 50) {
    color = green;
  } else if (percent < 80) {
    color = yellow;
  } else {
    color = red;
  }
  printf("{\"full_text\": \"CPU: %.2f%%\", \"color\": \"%s\"}\n", percent,
         color);

  return 0;
}
//////////////////////////////////////////////////////////////
