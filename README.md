# Fast Google Dorks Scan

The OSINT project, the main idea of which is to collect all the possible Google dorks search combinations and to find the information about the specific web-site: common admin panels, the widespread file types and path traversal. The 100% automated.

Usage example:
--------------
```
chmod +x FGDS.sh
./FGDS.sh hydrattack.com
```
or
```
bash ./FGDS.sh hydrattack.com
```

with proxy

```
bash ./FGDS.sh hydrattack.com 192.168.1.1 8080
```

This will work beatifully on Kali but an ultimately universal way is through Docker. Just run 

```
docker build -t fgds .
```

and then run it with your argument for the URL such as this:

```
docker run -it --rm fgds hydrattack.com
```

Screenshots:
------------
![](https://github.com/IvanGlinkin/media_support/blob/main/FGDS-2025-06-20.png?raw=true)


An original article:
--------------------
[https://www.ivanglinkin.com/fast-google-dorks-scan/](https://www.ivanglinkin.com/fast-google-dorks-scan/)

