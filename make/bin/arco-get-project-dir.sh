#!/bin/bash --
# -*- mode:shell-script; coding:utf-8; tab-width:4 -*-

function get_root_dir() { 
    if [ -f "$1/project.mk" ]; then
		echo "$1" 
		return 0 
    fi
    
    if [ "$1" == "/" ]; then
		return 1; 
    fi
    
    get_root_dir "$(dirname $1)" 
}

get_root_dir $(pwd)
