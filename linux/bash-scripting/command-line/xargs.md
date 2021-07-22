# xargs

Use `xargs` or `parallel` whenever you can. Note you can control how many items execute per line \(`-L`\) as well as parallelism \(`-P`\). If you're not sure if it'll do the right thing, use xargs echo first. Also, `-I{}` is handy. 

```bash
find . -name '*.py' | xargs grep some_function
cat hosts | xargs -I{} ssh root@{} hostname
```

