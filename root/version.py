import re
import urllib2

regex = r'<title>Release ((\d+\.)?(\d+\.)?(\*|\d+))\s'

SearchString = urllib2.urlopen('https://github.com/jedisct1/dnscrypt-proxy/releases/latest').read()

matches = re.search(regex, SearchString)
print matches.group(1)
