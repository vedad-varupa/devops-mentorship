# All commands

# `ssh`       -a tool through which we connect to a remote server
# `ls`        -a list of what we have inside the root directory
# `ls -la`    - all files and folders inside the central directory
# `cat`       - to view the content of `readme` file
# `ls -lah`   - to list all files including hidden ones
# `cat ./-`   - to display contents in `-` file
# `exit`      - to exit current SSH session
# `find`      - The find command allows you to search a specific file by its name

    `find /home/bandit5/inhere -type f -readable -size 1033c ! -executable`

    `-type f` indicates our interest in files.
    `-readable` indicates that file must be human-readable.
    `-size 1033c` indicates that file must be 1033 kb in size.
    `!-executable` indicates that file must not be executable.

# `grep milionth data.txt`   - a use case for grep is to search for a specific word within a text file.
# `sort data.txt | uniq -u`  - for the unique output
# `cat data.txt | base64 -d`        - to decode the base64 data in the file
