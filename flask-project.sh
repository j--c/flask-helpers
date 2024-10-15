#!/bin/bash

project_name=$1


function install_flask_packages(){
    touch flask_install.log
    pip install flask flask-sqlalchemy flask-migrate flask-wtf flask-login email-validator > "flask_install.log"
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

function create_project_file(){
    file_path="$project_name.py"
    touch $file_path
    echo "from app import create_app" >> $file_path 
    echo "" >> $file_path
    echo "" >> $file_path
    echo "app = create_app()" >> $file_path
}

function create_config_file(){
    file_path="config.py"
    touch $file_path
    echo "class Config:" >> $file_path 
    echo "    TEST_VALUE = '123'" >> $file_path
}

function create_app_init_file(){
    app_dir_name="app"
    app_init_file_name="__init__.py"
    file_path="$app_dir_name/$app_init_file_name"
    mkdir $app_dir_name
    touch $file_path
    echo "from flask import Flask" >> $file_path
    echo "from config import Config" >> $file_path
    echo "" >> $file_path
    echo "def create_app(config_class=Config):" >> $file_path
    echo "    app = Flask(__name__)" >> $file_path
    echo "    app.config.from_object(config_class)" >> $file_path
}

function create_basic_files(){
    create_project_file
    create_config_file
    create_app_init_file
}

if [ -z "$project_name" ]; then
    echo "Project name required!"
else
    echo "Creating project directory..."
    mkdir $project_name
    cd $project_name

    echo "Creating virtual environment..."
    python3 -m venv venv
    source venv/bin/activate

    echo "Installing flask packages..."
    install_flask_packages

    echo "Writing .gitignore..."
    write_gitignore

    echo "Creating git repo..."
    git init -b main

    echo "Creating basic files..."
    create_basic_files
fi
