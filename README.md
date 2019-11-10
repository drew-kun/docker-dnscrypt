# docker-dnscrypt2

[![Github Sponsorship](https://img.shields.io/badge/support-me-red.svg)](https://github.com/users/rix1337/sponsorship)

Automatically updating to the latest version of [DNScrypt Proxy 2](https://github.com/jedisct1/dnscrypt-proxy) on launch.

Remember to remove IPv6 blocks from your config if you have only IPv4 enabled (default Unraid setting)!

**Requires your own dnscrypt-proxy.toml at /config**

[This is the official example config](https://github.com/jedisct1/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml)

[More details in the official wiki](https://github.com/jedisct1/dnscrypt-proxy/wiki/Configuration)


# Run

```
docker run -d \
  --name="DNScrypt" \
  -v /path/to/config/:/config:rw \
  -e VERSION=VERSION_TO_INSTALL \
  rix1337/docker-dnscrypt2
```

# Optional parameters
 - `-e VERSION` (only set if you wish to install a specific version instead of autoupdating)
