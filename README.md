# barrt-nginx - nginx support for BARRT (A Bash Rspec-like Regression Test framework)

## Use it

Install these two modules from npm:

```sh
npm i --save barrt
npm i --save barrt-nginx
```

Edit the `setup.sh` file in your test suite to include the following:

```sh
#!/bin/bash

modules=$(dirname "$BASH_SOURCE")/node_modules

. "$modules"/barrt/setup.sh
. "$modules"/barrt-nginx/setup.sh

# other setup tasks...
```

Create a `runner.sh` file in your test suite with these contents:

```sh
#!/bin/bash

modules=$(dirname "$BASH_SOURCE")/node_modules

exec "$modules"/barrt/runner.sh
```

## API

The following are provided as bash functions:

### Choosing an nginx scenario

`set_nginx_conf $full_path_to_nginx_conf`

`get_nginx_conf`

### Managing nginx

`check_nginx_conf`

`start_nginx`

`stop_nginx`

`reopen_nginx_logs`

`run_nginx $args_for_nginx...`

## License

MIT
