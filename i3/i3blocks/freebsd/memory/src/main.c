#include <stdint.h>
#include <stdio.h>
#include <sys/sysctl.h>
#include <sys/types.h>

int main(int argc, char *argv[]) {
  (void)argc;
  (void)argv;

  int rc;
  size_t u64_size = sizeof(uint64_t);
  size_t uint_size = sizeof(u_int);

  uint64_t mem_phys, pagesize;
  int mib_phys[2] = {CTL_HW, HW_PHYSMEM};
  int mib_pagesize[2] = {CTL_HW, HW_PAGESIZE};

  u_int mem_active = 0;
  u_int mem_wire = 0;

  rc = sysctl(mib_phys, 2, &mem_phys, &u64_size, NULL, 0);
  if (rc) {
    printf("HW_PHYSMEM failed: %d\n", rc);
    return rc;
  }

  rc = sysctl(mib_pagesize, 2, &pagesize, &u64_size, NULL, 0);
  if (rc) {
    printf("HW_PAGESIZE failed: %d\n", rc);
    return rc;
  }

  rc = sysctlbyname("vm.stats.vm.v_active_count", &mem_active, &uint_size, NULL,
                    0);
  if (rc) {
    printf("vm.stats.vm.v_active_count failed: %d\n", rc);
    return rc;
  }
  mem_active *= pagesize;

  rc = sysctlbyname("vm.stats.vm.v_wire_count", &mem_wire, &uint_size, NULL, 0);
  if (rc) {
    printf("vm.stats.vm.v_wire_count failed: %d\n", rc);
    return rc;
  }
  mem_wire *= pagesize;

  static const char *green = "#00db16";
  static const char *yellow = "#ffff40";
  static const char *red = "#c90007";
  static const char *suffixes[] = {"B", "K", "M", "G", "T", NULL};
  const char **p_mus = suffixes;
  const char **p_mts = suffixes;
  const char *color = green;
  double mem_used = mem_wire + mem_active;
  double mem_total = mem_phys;
  int percent = (int)(mem_used / mem_total * 100.);

  if (percent < 60) {
    color = green;
  } else if (percent < 85) {
    color = yellow;
  } else {
    color = red;
  }

  for (; mem_used > 1000.0 && *p_mus; ++p_mus) {
    mem_used /= 1024.0;
  }
  for (; mem_total > 1000.0 && *p_mts; ++p_mts) {
    mem_total /= 1024.0;
  }

  printf("{\"full_text\":\"RAM: %.2f%s/%.2f%s\", \"color\": \"%s\"}\n",
         mem_used, *p_mus, mem_total, *p_mts, color);

  return 0;
}
//////////////////////////////////////////////////////////////
