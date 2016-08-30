#!/bin/bash

modules=$(dirname "$(caller | awk '{ print $2; }')")/node_modules

if test ! -f "$modules"/barrt/setup.sh; then echo "Error: peer dependency 'barrt' not installed"; exit 1; fi
if ! define_side_a 2>/dev/null; then echo "Error: 'barrt' was not sourced yet"; exit 1; fi

nginx_acccess_log=
nginx_error_log=
nginx_conf=

function set_nginx_conf() {
    nginx_conf=$1
}

function get_nginx_conf() {
    echo "$nginx_conf"
}

function set_nginx_access_log() {
    nginx_access_log=$1
}

function get_nginx_access_log() {
    echo "$nginx_access_log"
}

function set_nginx_error_log() {
    nginx_error_log=$1
}

function get_nginx_error_log() {
    echo "$nginx_error_log"
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

function truncate_nginx_logs() {
    : > "$nginx_access_log"
    : > "$nginx_error_log"
    reopen_nginx_logs
}

function expect_nginx_access_log() {
    local file=$(get_nginx_access_log)
    local contents=$(cat "$file")
    define_side_a "$contents"
    define_side_a_text "nginx access log $file"
    define_addl_text "Log contents:\n$contents"
}

function expect_nginx_error_log() {
    local file=$(get_nginx_error_log)
    local contents=$(cat "$file")
    define_side_a "$contents"
    define_side_a_text "nginx error log $file"
    define_addl_text "Log contents:\n$contents"
}

function expect_nginx_exit_code() {
    local exit_code=$1
    local out=$2
    define_side_a "$exit_code"
    define_side_a_text "nginx exit code of \"$exit_code\""
    define_addl_text "nginx output:\n$out"
}
