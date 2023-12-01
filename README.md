# Fast Google Dorks Scan

The OSINT project, the main idea of which is to collect all the possible Google dorks search combinations and to find the information about the specific web-site: common admin panels, the widespread file types and path traversal. The 100% automated.

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

