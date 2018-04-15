# docker-dnscrypt2
Automatically updating to the latest version of [DNScrypt Proxy 2](https://github.com/jedisct1/dnscrypt-proxy) on launch.

Remember to remove IPv6 blocks from your config if you have only IPv4 enabled (default Unraid setting)!

Supply your own dnscrypt-proxy.toml at /config

```
docker run -d \
  --name="DNScrypt" \
  -v /path/to/config/:/config:rw \
  rix1337/docker-dnscrypt2
  ```
