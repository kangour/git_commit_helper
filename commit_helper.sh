# operate confirm
# $1: tip, -z null adjuctment
function confirm(){
    while(( 1 == 1 ))
    do
        read -p "    $1 y/n/q：" answer
        if [ -z $answer ]
        then
            continue
        fi
        if [ $answer == 'Y' -o $answer == 'y' ]
        then
            echo true
        elif [ $answer == 'N' -o $answer == 'n' ]
        then
            echo false
        elif [ $answer == 'Q' -o $answer == 'q' ]
        then
            exit -1
        else
            continue
        fi
        break
    done
}

# wait enter some content
# $1: description
function input(){
    if [ $# -ne 1 ]    #"$#" Number of parameters
    then
        echo "Parameter is not enough $0"
        exit 1
    fi
    while(( 1 == 1 ))
    do
        read -p "    Input $1：" answer
        if [ "$answer" ]
        then
            echo "$answer"
            break
        else
            continue
        fi
    done
}


current_branch=`git rev-parse --abbrev-ref HEAD`
if [[ $current_branch == 'master' ]]
then
    answer=$(confirm 'In master branch, switch new?')
    echo ''
    if [[ $answer == true ]]
    then
        branch_name=`input 'new branch name'`
        current_branch=$branch_name
        git checkout -b $branch_name
    fi

fi


result=`git status`
has_committed=false
if [[ ! $result =~ 'Changes to be committed' ]]
then
    echo 'Add your changes!'
    exit -1
fi


# file list | Exclude unadded files | Gets a filename with Spaces | removes Spaces | gets the path and filename
result=`git status -s | egrep -v "(^\ |^\?)" | egrep -o "(\ .*)" | sed 's/[ ]//g'`
array=(${result// / })
length=${#array[@]}
body=''
if [[ $length == 1 ]]
then
    array=(${result//\// })
    length=${#array[@]}
    if [[ $length == 1 ]]
    then
        body=$result
    else
        body=${array[length-2]}/${array[length-1]}
    fi
    body=\($body\)
else
    echo 'Multiple file submission'
    body=\($current_branch\)
fi
echo 'body='$body


commit_type=''
options="feature fix refactor style docs test chore Quit"
select option in $options
do
    if [[ $option == "Quit" ]]
    then
        echo done
        exit
    elif [[ $options =~ $option && $option != '' ]]
    then
        commit_type=$option
        break
    else
        echo bad option
    fi
done
echo 'type='$commit_type


commit_note=`input 'commit message'`
git commit -m "$commit_type$body: $commit_note"
git log --oneline -3
echo 'Done!'
