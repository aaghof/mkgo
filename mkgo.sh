#!/bin/bash
###############################################################################
#
# Script for create and load dynamic environment go project
# Author: aaghof
#
#------------------------------------------------------------------------------
#
# This script will create :
# create dynamic env go project
# create new go project
#------------------------------------------------------------------------------
#
# Build script:
# chmod u+x mkgo
# echo "export PATH=$HOME/myscript/bin" >> ~/.bashrc
# source ~/.bashrc
#------------------------------------------------------------------------------
#
# Usage:
# mkgo <project_name>
###############################################################################

namespace="github.com/aaghof"

# todo: 
# check is direnv installed?
# if not installed, do install direnv
# if installed, run bellow script

create_project() {
    project_dir="$project/src/$namespace/$project"

    # create project directory
    mkdir -p $project_dir

    # init git repository
    git init -q $project_dir

    # set env
    echo "export GOPATH=$PWD" >> $project/.envrc
    echo "export GOBIN=$GOPATH/bin" >> $project/.envrc

    # load env
    direnv allow $project

    # create go entry point
    touch "$project_dir/main.go"

    # write main function
    echo -e "package main" >> "$project_dir/main.go"
    echo -e "import \"fmt\"" >> "$project_dir/main.go"
    echo -e "func main() {" >> "$project_dir/main.go"
    echo -e "  fmt.Println(\"Hello world\")" >> "$project_dir/main.go"
    echo -e "}" >> "$project_dir/main.go"

    # show finish message
    echo -e "\n# $project go project created"
    echo -e "# to start coding, please go to project directory"
    echo -e "cd $project/src/$namespace/$project\n"
}

response=
if [ "$1" != "" ]; then
    project=$1
    create_project
else
    echo -n "What is your GO project name?"
    read response
    if [ -n "$response" ]; then
        project=$response
        create_project
    fi
fi
