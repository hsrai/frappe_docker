## As user

#### Pre-requisute:

A linux based computer with docker installed.

### Installation

1. Download file
https://raw.githubusercontent.com/hsrai/frappe_docker/refs/heads/education/rai/erpnextPlusApps.yml
1. Line number 68 list all available apps, and all will be installed. If you
don't like to install any app, say, foo, then remove "--install foo".
1. Repeat above step for any other app. Replace foo with payments or
helpdesk.
1. This file will create site with name `frontend`. Replace it with any name
you like at line number 68 and 100.
1. Issue command: `docker compose -f erpnextPlusApps.yml up -d`
1. Wait for about 5 to 10 minutes.
1. Site will be available at http://ipAddressofYourServer:8080
1. Default credentials are:- user:administrator password:admin

## As developer

Here developer mean who creates the custom docker image for erpnext with
additional apps.

#### Pre-requisute:

A linux based computer with docker and git installed installed.

Steps to make custom docker:

### Clone frappe_docker and switch directory
```sh
git clone https://github.com/frappe/frappe_docker
cd frappe_docker
```

### List apps in json format

Put the list of desired apps in json format in a file, say apps.json

You need to add dependent app, if there is any. If `education` app needed
`erpnext`, then we can't have education app without erpnext.

```sh
[
  {
    "url": "https://github.com/frappe/erpnext",
    "branch": "version-15"
  },
  {
    "url": "https://github.com/frappe/payments",
    "branch": "version-15"
  },
  {
    "url": "https://{{ PAT }}@git.example.com/project/repository.git",
    "branch": "main"
  }
]
```

### Base64 encoded

Generate base64 string from json file:

```sh
export APPS_JSON_BASE64=$(base64 -w 0 /path/to/apps.json)

```

In case apps.json is in the same folder, from where you run export command,
then

```sh
export APPS_JSON_BASE64=$(base64 -w 0 ./apps.json)

```

### Script to make docker

Create a file, say `makeDocker.sh`, with the contentt:

```sh
docker build \
  --build-arg=FRAPPE_PATH=https://github.com/frappe/frappe \
  --build-arg=FRAPPE_BRANCH=version-15 \
  --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 \
  --tag=hsrai/frappe_docker:educationV0.1.0 \
  --file=images/layered/Containerfile .
``` 

Where `hsrai/frappe_docker:educationV0.1.0` for `--tag` means:

1. `hsrai` is your `username` at https://www.docker.com/ If you don't have
account there, then create one.
1. `frappe_docker` is the name you wish to give your custom docker.
1. `educationV0.1.0` is the tag, mostly verstion, like 2.0.0 or any other
string.

### Execute the script

```sh
bash makeDocker.sh
```

### Push image

Push image to use in yaml files.

1. Login to docker

```sh
docker login
```

follow on-screen instructions.

1. Push image

```sh
docker push hsrai/frappe_docker:educationV0.1.0
```
Above is example of:

``sh
docker push <username>/<imagename>:<tag>

Now use it in yaml as explained in the beginning of the file.
 