#!/bin/bash

usage() { 
    scriptname=`basename $0` 
    echo
    echo "USAGE:" 
    echo "$scriptname EPIC"
    echo
    echo "Example:"
    echo "$scriptname ENBL-123"
}

epic=$1
if [ -z $epic ]; then echo "error: no EPIC specified"; usage; exit 1; fi


test_count=$(cat stories.yml | yq '.epic | length')

for(( i=0; i < $test_count; i++))
do
    name=$(yq ".epic[$i].name" stories.yml)
    description=$(yq ".epic[$i].value" stories.yml)
    cat story.txt | jira issue create --no-input -P$epic -tStory -laws -C Engineering -s"$name" 
done


















# Scribbly notes below here



# jira issue move ENBL-1618 Done -R"Won't Do" --comment "just a test ticket"

# istart=1627
# iend=1640
# for (( i=$istart; i<=$iend; i++))  do jira issue move $i Done -R"Won't Do" --comment "just a test ticket";done



# cat <<EOF > story.txt
# AS A: ExampleCo Team
# WE WANT: To document the differences between AWS foundation and delivery orgs (for $name)
# SO THAT: We ensure we can assess the current state of AWS Organizations, identify differences, and develop a strategy for transitioning the Organizations into a best practices framework

# Documentation needs for "$name" 
# $description

# Documentation Workspace
# https://hyland.atlassian.net/wiki/spaces/CE/pages/1434029600/ENBL-1626+AWS+Org+Comparison

# Acceptance Criteria:
# Category "$name": Is assigned a red/green/yellow light for differences between the foundation and delivery orgs
# Category "$name": Has documented analysis supporting the red/yellow/green light rating

# EOF
