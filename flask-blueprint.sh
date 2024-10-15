#!/bin/bash

blueprint_name=$1

function create_init_file(){
    file_path='__init__.py'
    touch $file_path 
    echo "from flask import Blueprint" >> $file_path
    echo "" >> $file_path
    echo "" >> $file_path
    echo "bp = Blueprint('$blueprint_name', __name__, template_folder='templates')" >> $file_path
    echo "" >> $file_path
    echo "" >> $file_path
    echo "from app.$blueprint_name import routes" >> $file_path
}

function create_routes_file(){
    file_path='routes.py'
    touch $file_path 
    echo "from flask import render_template" >> $file_path
    echo "from app.$blueprint_name import bp" >> $file_path
    echo "" >> $file_path
    echo "" >> $file_path
    echo "@bp.route('/', methods['GET'])" >> $file_path
    echo "def index():" >> $file_path
    echo "    return render_template('$blueprint_name/index.html')" >> $file_path
}

function create_template_files(){
    template_dir="templates/$blueprint_name"
    index_file="index.html"
    file_path=$template_dir/$index_file
    mkdir -p $template_dir
    touch $file_path 
    echo "{% extends 'base.html' %}" >> $file_path
    echo "{% block content %}" >> $file_path
    echo "    this is $blueprint_name index" >> $file_path
    echo "{% endblock %}" >> $file_path
}


function create_basic_files(){
    create_template_files
    create_routes_file
    create_init_file
}

if [ -z "$blueprint_name" ]; then
    echo "Blueprint name required!"
else
    echo "Creating blueprint directory..."
    mkdir $blueprint_name
    cd $blueprint_name

    echo "Creating basic files..."
    create_basic_files
fi
