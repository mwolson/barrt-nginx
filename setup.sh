#!/bin/bash

modules=$(dirname "$(caller | awk '{ print $2; }')")/node_modules

if test ! -f "$modules"/barrt/setup.sh; then echo "Error: peer dependency 'barrt' not installed"; exit 1; fi
if ! define_side_a 2>/dev/null; then echo "Error: 'barrt' was not sourced yet"; exit 1; fi

nginx_conf=

function set_nginx_conf() {
    nginx_conf=$1
}

function get_nginx_conf() {
    echo "$nginx_conf"
}

function run_nginx() {
    local out=
    out=$(nginx "$@" -c "$nginx_conf" 2>&1)
    local exit_code=$?
    out=$(<<< "$out" grep -v '/var/log/nginx/error.log')
    expect_nginx_exit_code $exit_code "$out"; to_equal 0
}

function check_nginx_conf() {
    run_nginx -t
}

function start_nginx() {
    run_nginx
}

function stop_nginx() {
    run_nginx -s stop
}

function reopen_nginx_logs() {
    run_nginx -s reopen
}
