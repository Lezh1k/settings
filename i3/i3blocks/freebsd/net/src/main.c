#include <arpa/inet.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <netinet/in.h>
#include <stdio.h>
#include <sys/socket.h>

void print_sockaddr(const struct sockaddr *sa) {
  char ip_str[INET6_ADDRSTRLEN];
  void *addr;

  if (sa->sa_family == AF_INET) {
    struct sockaddr_in *ipv4 = (struct sockaddr_in *)sa;
    addr = &(ipv4->sin_addr);
    inet_ntop(AF_INET, addr, ip_str, INET_ADDRSTRLEN);
    printf("%s\n", ip_str);
  } else if (sa->sa_family == AF_INET6) {
    struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)sa;
    addr = &(ipv6->sin6_addr);
    inet_ntop(AF_INET6, addr, ip_str, INET6_ADDRSTRLEN);
    printf("%s\n", ip_str);
  }
}
//////////////////////////////////////////////////////////////

int main(int argc, char *argv[]) {
  // todo parse them
  (void)argc;
  (void)argv;
  struct ifaddrs *lst_addr;
  struct ifaddrs *p_addr;
  int rc = getifaddrs(&lst_addr);

  if (rc) {
    fprintf(stderr, "getifaddrs failed. err: %d\n", rc);
    printf("N/A: %d\n", rc);
    return rc;
  }

  for (p_addr = lst_addr; p_addr; p_addr = p_addr->ifa_next) {
    if (p_addr->ifa_addr->sa_family != AF_INET) {
      continue; // we don't care
    }

    if (!(p_addr->ifa_flags & IFF_DRV_RUNNING)) {
      continue;
    }

    if (p_addr->ifa_flags & IFF_LOOPBACK) {
      continue; //
    }

    print_sockaddr(p_addr->ifa_addr);

    // struct if_data *ifa_data = (struct if_data *)p_addr->ifa_data;
    // printf("\tflags:\t%x\n", p_addr->ifa_flags);
    //
    // printf("type:       \t%d\n", ifa_data->ifi_type);
    // printf("physical:   \t%d\n", ifa_data->ifi_physical);
    // printf("addrlen:    \t%d\n", ifa_data->ifi_addrlen);
    // printf("hdrlen:     \t%d\n", ifa_data->ifi_hdrlen);
    // printf("link_state: \t%d\n", ifa_data->ifi_link_state);
    // printf("vhid:       \t%x\n", ifa_data->ifi_vhid);
    // printf("datalen:    \t%d\n", ifa_data->ifi_datalen);
    // printf("mtu:        \t%d\n", ifa_data->ifi_mtu);
    // printf("metric:     \t%d\n", ifa_data->ifi_metric);
    // printf("baudrate:   \t%lu\n", ifa_data->ifi_baudrate);
    //
    // printf("ipackets:   \t%lu\n", ifa_data->ifi_ipackets);
    // printf("ierrors:    \t%lu\n", ifa_data->ifi_ierrors);
    // printf("opackets:   \t%lu\n", ifa_data->ifi_opackets);
    // printf("oerrors:    \t%lu\n", ifa_data->ifi_oerrors);
    // printf("collisions: \t%lu\n", ifa_data->ifi_collisions);
    // printf("ibytes:     \t%lu\n", ifa_data->ifi_ibytes);
    // printf("obytes:     \t%lu\n", ifa_data->ifi_obytes);
  }

  freeifaddrs(lst_addr);
  return 0;
}
//////////////////////////////////////////////////////////////
