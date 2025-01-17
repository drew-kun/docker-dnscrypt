#!/bin/sh

# get "fallback" resolver from dnscrypt-proxy.toml for updating
FALLBACK=`egrep fallback_resolver /config/dnscrypt-proxy.toml | awk -F \' '{print $2}' | awk -F \: '{print $1}'`
resolv_orig=`cat /etc/resolv.conf`
if [ -n "$FALLBACK" ]; then
	echo "nameserver\t$FALLBACK" >> /etc/resolv.conf
	echo "dnscrypt-proxy.toml fallback resolver found "$FALLBACK""
	echo "adding "$FALLBACK" temporarily to /etc/resolv.conf for update purposes"
fi

if [ -n "$VERSION" ]; then
	echo "Using set version "$VERSION" to install DNSCrypt Proxy"
	DNSCRYPT_PROXY_VERSION=$VERSION
else
	DNSCRYPT_PROXY_VERSION=$(curl -s https://api.github.com/repos/DNSCrypt/dnscrypt-proxy/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
fi

if [ -n "$DNSCRYPT_PROXY_VERSION" ]; then
	DNSCRYPT_PROXY_DOWNLOAD_URL=https://github.com/jedisct1/dnscrypt-proxy/releases/download/${DNSCRYPT_PROXY_VERSION}/dnscrypt-proxy-linux_arm64-${DNSCRYPT_PROXY_VERSION}.tar.gz
	if [ ! -f /${DNSCRYPT_PROXY_VERSION}.dnscrypt ]; then
		cd /
		rm *.dnscrypt &>/dev/null
		echo "Downloading latest dnscrypt-proxy"
		mkdir -p /dnscrypt
		cd /dnscrypt
		wget -O dnscrypt-proxy.tar.gz $DNSCRYPT_PROXY_DOWNLOAD_URL
		tar xzf dnscrypt-proxy.tar.gz
		rm dnscrypt-proxy.tar.gz
		cd linux-arm64
		touch /${DNSCRYPT_PROXY_VERSION}.dnscrypt
	fi
fi

# restore resolv.conf
if [ -n "$FALLBACK" ]; then
	echo "removing temporary "$FALLBACK" resolver from /etc/resolv.conf"
	echo "$resolv_orig" > /etc/resolv.conf
fi

if [ ! "$BUILDING_IMAGE" = true ] ; then
	if [ -f /config/dnscrypt-proxy.toml ]; then
		cp -rf /config/dnscrypt-proxy.toml /dnscrypt/linux-arm64/
		echo "Using your supplied dnscrypt config file"
	else
		cp example-dnscrypt-proxy.toml dnscrypt-proxy.toml
		echo "Using the default dnscrypt config file"
	fi

	cd /dnscrypt/linux-arm64
	echo "Starting dnscrypt"
	./dnscrypt-proxy
else
	echo "Initial docker build finished using version "$DNSCRYPT_PROXY_VERSION" of DNSCrypt Proxy!"
fi
