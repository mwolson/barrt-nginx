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

### Setting up an nginx scenario

`set_nginx_conf $full_path_to_nginx_conf`

`get_nginx_conf`

`set_nginx_access_log $full_path_to_nginx_access_log`

`get_nginx_access_log`

`set_nginx_error_log $full_path_to_nginx_error_log`

`get_nginx_error_log`

### Managing nginx

`check_nginx_conf`

`start_nginx`

`stop_nginx`

`reopen_nginx_logs`

`truncate_nginx_logs`

`run_nginx $args_for_nginx...`

### Expectations

`expect_nginx_access_log`

`expect_nginx_error_log`

`expect_nginx_exit_code`

## License

MIT
