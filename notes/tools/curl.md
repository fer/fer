# cURL

#### Fetch sessions with cURL

If username and password are entered in a form on a login page, then cURL can "submit" that form like:

```
curl -d "username=miniape&password=SeCrEt" http://whatever.com/login
```

and if you want to store the cookie that comes back you do so by specifying a cookie file:

```
curl -c cookies.txt -d "username=miniape&password=SeCrEt" http://whatever.com/login
```

and to use those cookie in later requests you do:

```
curl -b cookies.txt -d "username=miniape&password=SeCrEt" http://whatever.com/login
```

or do both if you want to both send and receive cookies:

```
curl -b cookies.txt -c cookies.txt -d "username=miniape&password=SeCrEt" http://whatever.com/login
```