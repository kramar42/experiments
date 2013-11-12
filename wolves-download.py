#!/usr/bin/env python
# -*- coding: utf-8 -*- 

import urllib, urllib2, cookielib

cookie = cookielib.CookieJar()
opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cookie))
 
data = {
    'fld1' : '',
    'fld2' : '',
    'login': 'Войти'
}
data = urllib.urlencode(data)
url = 'http://wolves.roleforum.ru/login.php?action=in'

response = opener.open(url, data)
response = opener.open(url, data)
response = opener.open('http://wolves.roleforum.ru/')
print response.read()
