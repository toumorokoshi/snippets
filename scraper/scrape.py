from BeautifulSoup import BeautifulSoup
import urllib2
import requests
import re
import os

photo_url_match = re.compile("^http://.*photos.*amazonaws.*photos.*png")
target_directory = "/tmp/"

html = urllib2.urlopen("YOURIPHONEPROJECT_URL_HERE").read()
parsed = BeautifulSoup(html)

links = parsed.findAll("a")


def download_file(url, output_url):
    r = requests.get(url)
    target_path = os.path.join(target_directory, output_url)
    print "Downloading %s to %s..." % (url, target_path)
    with open(target_path, "w+") as image:
        image.write(r.content)

i = 1
for l in links:
    if l.get('class') == "lightbox":
        download_file(l.get('href'), "%s.png" % str(i))
        i += 1
