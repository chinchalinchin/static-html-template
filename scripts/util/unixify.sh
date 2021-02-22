# Get rid of all those pesky \r errors!
# Use this script thusly,

#   ./scripts/util/unixify.sh "$(pwd)"

#  The script will recursively check for shell scripts in all subdirectories
#   of the specified path (in the above case, your present working directory;
#   presumably the project root due to the relative path for the script itself).
#   If it finds a shell script, it will convert all line endings in that script
#   to Unix-style. 

#   If you get Docker image build or container runtime errors such as 'cannot find
#   \r' or 'cannot find \M', this is due to the line endings in one of the shell
#   scripts. Use this script to convert all line endings to a style Docker likes!

#  Instead of $(pwd), your present working directory, you can provide
#   any absolute path. Be careful using this script outside of the project 
#   directory!

function unixify(){
    for f in $1/*
    do
        if [ -d $f ]
        then 
            unixify $f
        else
            if [ ${f: -3} == ".sh" ]
            then
                dos2unix $f
            fi
        fi
    done
}

unixify $1