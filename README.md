# docker-dnscrypt2
Automatically updating to the latest version of [DNScrypt Proxy 2](https://github.com/jedisct1/dnscrypt-proxy) on launch.

Supply your own dnscrypt-proxy.toml at /config

```
docker run -d \
  --name="DNScrypt" \
  -v /path/to/config/:/config:rw \
  rix1337/docker-dnscrypt2
  ```
