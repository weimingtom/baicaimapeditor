# To change this template, choose Tools | Templates
# and open the template in the editor.

__author__="Poplar"
__date__ ="$2010-2-20 2:16:49$"

import urllib2
import urllib
import re
import os
from BeautifulSoup import BeautifulSoup

def main():
    beginurl = 'http://blog.livedoor.jp/zamen1/archives/65303205.html'
    downloadFolder = 'c:/image/'

    try:
        page = urllib2.urlopen(beginurl)
    except:
        print '[ failed ]'
    else:
        print '[ success ]'
        html = page.read()
        html = html.decode('EUC-JP').encode('utf-8')
        soup = BeautifulSoup("".join(html))
        name = soup.find('a', href=re.compile('^http://extlink\.blogsys\.jp/livedoor/zamen1')).string
        if not os.path.isdir(downloadFolder + name):
            os.mkdir(downloadFolder + name)
        for a in soup.findAll('a', target="_blank"):
            url = a['href']
            website = 'http://image.blog.livedoor.jp';
            websiteLen = len(website);
            isInWebsite = cmp(url[0:websiteLen], website[0:websiteLen])
            isPic = cmp(url[-4:-1], '.jpg'[0:3])
            if( isInWebsite == 0 and isPic == 0):
                try:
                    urllib.urlretrieve(url, downloadFolder+name+"/"+url.split('/')[-1]);
                    print url+" ok!"
                except:
                    print url+" not ok!"
        page.close
        
if __name__ == "__main__":
    main()
