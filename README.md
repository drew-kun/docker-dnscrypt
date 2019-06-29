# docker-dnscrypt2

[![ko-fi](https://img.shields.io/badge/Support-me-red.svg)](https://ko-fi.com/J3J4Y2R6)

Automatically updating to the latest version of [DNScrypt Proxy 2](https://github.com/jedisct1/dnscrypt-proxy) on launch.

Remember to remove IPv6 blocks from your config if you have only IPv4 enabled (default Unraid setting)!

**Requires your own dnscrypt-proxy.toml at /config**

[This is the official example config](https://github.com/jedisct1/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml)

[More details in the official wiki](https://github.com/jedisct1/dnscrypt-proxy/wiki/Configuration)



```
docker run -d \
  --name="DNScrypt" \
  -v /path/to/config/:/config:rw \
  rix1337/docker-dnscrypt2
  ```
