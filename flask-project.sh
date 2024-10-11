#!/bin/bash

project_name=$1


function install_flask_packages(){
    touch flask_install.log
    pip install flask flask-sqlalchemy flask-migrate flask-wtf flask-login > "flask_install.log"
}

function write_gitignore(){
    touch .gitignore
    echo "# Byte-compiled / optimized / DLL files" >> .gitignore
    echo "__pycache__/" >> .gitignore
    echo "*.py[cod]" >> .gitignore
    echo "*.py.class" >> .gitignore
    echo "# Virtual environment" >> .gitignore
    echo "venv/" >> .gitignore
}


if [ -z "$project_name" ]; then
    echo "Project name required!"
else
    echo "Creating project directory..."
    mkdir $1
    cd $1

    echo "Creating virtual environment..."
    python3 -m venv venv
    source venv/bin/activate

    echo "Installing flask packages..."
    install_flask_packages

    echo "Writing .gitignore..."
    write_gitignore

    echo "Creating git repo..."
    git init -b main
fi
