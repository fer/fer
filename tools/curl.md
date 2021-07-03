# cURL



{% hint style="info" %}
For web debugging, `curl` and `curl -I` are handy, or their `wget` equivalents, or the more modern [`httpie`](https://github.com/jakubroztocil/httpie).
{% endhint %}

## Fetch sessions with cURL

If username and password are entered in a form on a login page, then cURL can "submit" that form like:

```text
curl -d "username=miniape&password=SeCrEt" http://whatever.com/login
```

and if you want to store the cookie that comes back you do so by specifying a cookie file:

```text
curl -c cookies.txt -d "username=miniape&password=SeCrEt" http://whatever.com/login
```

and to use those cookie in later requests you do:

```text
curl -b cookies.txt -d "username=miniape&password=SeCrEt" http://whatever.com/login
```

or do both if you want to both send and receive cookies:

```text
curl -b cookies.txt -c cookies.txt -d "username=miniape&password=SeCrEt" http://whatever.com/login
```

