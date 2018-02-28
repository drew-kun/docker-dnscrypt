import re
import urllib2

print re.search('\/tag\/(\d{1,2}\.\d{1,2}\.\d{1,2})\"', urllib2.urlopen('https://github.com/jedisct1/dnscrypt-proxy/releases/latest').read()).group(1)
