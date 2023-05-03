# smaple-chatgpt-api

This is a repo holding some of the chatgpt api calls sample scripts for quick references.

All code can be found in `app` folder.

Code is run in a docker container. Do the following to get the container ready.

```
cp .env.template .env
# update .env

make build
make push
```

To enter the container and run sample code:

```
make debug
```