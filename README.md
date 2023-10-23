# Fast Google Dorks Scan

The OSINT project, the main idea of which is to collect all the possible Google dorks search combinations and to find the information about the specific web-site: common admin panels, the widespread file types and path traversal. The 100% automated.

# Sponsor
[![rds-cost](https://raw.githubusercontent.com/IvanGlinkin/media_support/main/Logo%20ProxyculrArtboard%201.png)](https://nubela.co/proxycurl/?utm_campaign=influencer_marketing&utm_source=github&utm_medium=social&utm_content=ivan_glinkin_google_dorks_scan)

Scrape public LinkedIn profile data at scale with [Proxycurl APIs](https://nubela.co/proxycurl/?utm_campaign=influencer_marketing&utm_source=github&utm_medium=social&utm_content=ivan_glinkin_google_dorks_scan).

• Scraping Public profiles are battle tested in court in HiQ VS LinkedIn case.<br/>
• GDPR, CCPA, SOC2 compliant<br/>
• High rate limit - 300 requests/minute<br/>
• Fast - APIs respond in ~2s<br/>
• Fresh data - 88% of data is scraped real-time, other 12% are not older than 29 days<br/>
• High accuracy<br/>
• Tons of data points returned per profile

Built for developers, by developers.


Usage example:
--------------
```
chmod +x FGDS.sh
./FGDS.sh megacorp.one
```
or
```
bash ./FGDS.sh megacorp.one
```

with proxy

```
bash ./FGDS.sh megacorp.one 192.168.1.1 8080
```

This will work beatifully on Kali but an ultimately universal way is through Docker. Just run 

```
docker build -t FOO .
```

and then run it with your argument for the URL such as this:

```
docker run -it --rm FOO mysite.com
```

Video example:
--------------
![](https://github.com/IvanGlinkin/media_support/blob/main/Fast-Google-Dorks-Scan_Video.gif?raw=true)

Screenshots:
------------
![](https://github.com/IvanGlinkin/media_support/blob/main/Fast-Google-Dorks-Scan_image_2.335.png?raw=true)


An original article:
--------------------
[https://www.ivanglinkin.com/fast-google-dorks-scan/](https://www.ivanglinkin.com/fast-google-dorks-scan/)

