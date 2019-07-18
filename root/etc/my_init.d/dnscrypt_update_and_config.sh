#!/bin/sh

# get "fallback" resolver from dnscrypt-proxy.toml for updating
FALLBACK=`egrep fallback_resolver /config/dnscrypt-proxy.toml | awk -F \' '{print $2}' | awk -F \: '{print $1}'`
resolv_orig=`cat /etc/resolv.conf`
if [ -n "$FALLBACK" ]; then
	echo "nameserver\t$FALLBACK" >> /etc/resolv.conf
	echo "dnscrypt-proxy.toml fallback resolver found "$FALLBACK""
	echo "adding "$FALLBACK" temporarily to /etc/resolv.conf for update purposes"
fi

DNSCRYPT_PROXY_VERSION=$(python /version.py)
DNSCRYPT_PROXY_DOWNLOAD_URL=https://github.com/jedisct1/dnscrypt-proxy/releases/download/${DNSCRYPT_PROXY_VERSION}/dnscrypt-proxy-linux_x86_64-${DNSCRYPT_PROXY_VERSION}.tar.gz

if [ ! -f /${DNSCRYPT_PROXY_VERSION}.dnscrypt ]; then
	cd /
	rm *.dnscrypt
	echo "Downloading latest dnscrypt-proxy"
	mkdir -p /dnscrypt
	cd /dnscrypt
	wget -O dnscrypt-proxy.tar.gz $DNSCRYPT_PROXY_DOWNLOAD_URL
	tar xzf dnscrypt-proxy.tar.gz
	rm dnscrypt-proxy.tar.gz
	cd linux-x86_64
	touch /${DNSCRYPT_PROXY_VERSION}.dnscrypt
fi

# restore resolv.conf
if [ -n "$FALLBACK" ]; then
	echo "removing temporary "$FALLBACK" resolver from /etc/resolv.conf"
	echo "$resolv_orig" > /etc/resolv.conf
fi

if [ -f /config/dnscrypt-proxy.toml ]; then
	cp -rf /config/dnscrypt-proxy.toml /dnscrypt/linux-x86_64/
	echo "Using your supplied dnscrypt config file"
else
	cp example-dnscrypt-proxy.toml dnscrypt-proxy.toml
	echo "Using the default dnscrypt config file"
fi

cd /dnscrypt/linux-x86_64
echo "Starting dnscrypt"
./dnscrypt-proxy
