#!/bin/bash

# This script is used to generate Terraform modules documentation in md format
# as last step during a pipeline execution
#
# The script will iterate over all the folders in the project and for each of those
# it use terraform-docs to generate the markdown file.
# Once done that, will use mkdocs to displey them inside the project's GitLab page 
# 
# IMPORTANT: You need to run this script in local for generate the md pages and later the pipeline will do the rest ;)

declare -a dir_list=("environments" "modules")

root_project_dir=$(pwd)
#echo $root_project_dir
for dir in "${dir_list[@]}"
do
   
   cd "$dir"
   sub_dir=(`ls -d */`)
   # Looping over subfolders
   for subdir in "${sub_dir[@]}"
     do
     subdir=${subdir%?}
     cd $root_project_dir/$dir/$subdir
     terraform-docs markdown table --output-file "${subdir}.md" --output-mode inject "$root_project_dir/$dir/$subdir"
     mv $root_project_dir/$dir/$subdir/"${subdir}".md $root_project_dir/docs/
   done
   cd $root_project_dir 

done
