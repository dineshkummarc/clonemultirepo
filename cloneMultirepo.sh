repo1="Add your GIT URL"
repo2="Add your GIT URL"

declare -a repolist=("repo1::"$repo1"@@development" "repo2::"$repo2"@@release")

for dir in "${repolist[@]}";
 do 
 	repoName="${dir%%::*}"
    _repoUrl="${dir%%@@*}"
    url="${_repoUrl##*::}"
    branchName="${dir##*@@}"
    #echo "$repoName - $url - $branchName"
    if [ -d "$repoName" ]
	then 
	    if [ "$(ls -A $repoName)" ]; then
         echo "Take action $repoName is not Empty"
         cd $(echo $repoName)
         git checkout $branchName
         git branch --list
         git pull
	    else
        echo "$dir is Empty"
	    fi
	else   
       echo "########STARTED CLONING $repoName########"
       git clone -b $branchName $url
    fi   
done 