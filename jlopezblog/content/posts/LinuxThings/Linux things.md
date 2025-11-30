---
title: "Linux Things"
date: 2025-11-29T00:00:00+00:00
# weight: 1
# aliases: ["/first"]
tags: ["Physics", "Paper"]
author: "jlopez"
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: true
description: "Nice references to keep under your hat"
# canonicalURL: "https://canonical.url/to/page"
#disableHLJS: true # to disable highlightjs
#disableShare: false
#disableHLJS: false
hideSummary: false
searchHidden: false
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
# cover:
#     image: "<image path/url>" # image path/url
#     alt: "<alt text>" # alt text
#     caption: "<text>" # display caption under cover
#     relative: false # when using page bundles set this to true
#     hidden: true # only hide on current single page
# editPost:
#     URL: "https://github.com/kiwamizamurai/content"
#     Text: "Suggest Changes" # edit text
#     appendFilePath: true # to append file path to Edit link
---

# Linux Things

- Interesting little things I've learned as a full-time Linux user

---
# Common Idioms

- The `&&` and `||` chaining idiom is one of those Bash tricks that makes scripts both concise and expressive. It’s basically a poor man’s `if`, but elegant.
- `[` … `]` is the Bash **test** command.
- Here are some flags for this command:
	- `-r` means file **exists** and is **readable**. 
	- `-x` same but executable
	- `-w` same but writable
	- `-d` tests if something is a directory.
	- `-f file` → is a **regular file** (not a directory, socket, etc.)
	- `-e file` → does the file **exist** (any type)?
	- `-s file` → file exists and has **size > 0**
	- `-L file` → file is a **symlink**
	- `-h file` → same as `-L` (historical alias)
	- `-O file` → file is **owned by the current user**
	- `-G file` → file belongs to the user’s **group**
- `!` negates a condition, as always
- `&&` logic `and` between 2 bash test commands
- `||` logic `or` between 2 bash test commands

--
## Examples

- Composed example: check if file exists and is readable, and that there's no `Cactus` directory, then if those 2 conditions are met, it decompresses something.
```bash
[ -r ~etuser/Cactus.tar.gz ] && ! [ -d ~/Cactus ] && tar -xzf ~etuser/Cactus.tar.gz -C ~/
```

- Do something only if a file exists
```bash
[ -f file.txt ] && echo "Found it!"
```

- Do something only if a file does _not_ exist
```bash
[ ! -f file.txt ] && echo "Missing file!"
```

- Do one thing *or* another
```bash
[ -d ~/Cactus ] && echo "Already installed" || echo "Not installed yet"
```

- Chain more than two conditions
```bash
[ -r config.cfg ] && [ -w logs/ ] && run_program
```    

---
# Send mail from terminal

- First u need to set some keys and passwords with Google. Then use
```bash
 echo "message" | mail -s "subject" -A path/to/file something@gmail.com
```

- For example:
```bash
 echo "Here some attached files" | mail -s "Email from main HP laptop" -A ~/Escritorio/money.png jorgelopezr8@gmail.com
```


---
# Download from any public repo

For example, suppose the file you want is:
```
https://github.com/user/repo/blob/main/path/to/file.txt
```

That’s just the HTML page. To get the file contents with `curl`, you should instead use the **raw link**:
```
https://raw.githubusercontent.com/user/repo/main/path/to/file.txt
```

Then you can download it like this:
```bash
curl -LO https://raw.githubusercontent.com/user/repo/main/path/to/file.txt
```

- `-L` → follows redirects (GitHub raw links often redirect).
- `-O` → saves the file with the same name.
- You usually don’t need `-k` (that disables SSL verification, only needed if you have cert issues).

--

If you want to download a **whole repo**, `curl` alone isn’t enough (since GitHub serves it as a zipball/tarball). For that you can do:
```bash
curl -L https://github.com/user/repo/archive/refs/heads/main.zip -o repo.zip
unzip repo.zip
```

or u might as well use `VSCode` to clone it.

---
# Size of a directory

- To calculate the total size of a directory, use `du -sh` (`s` for summary and `h` for human-readable)
```bash
du -sh ~/Documents
```

---
# Create directory skeleton in one line

- To create a directory and its parent at the same time, use `mkdir -p`
- [...]

---
# Write document within the terminal

- **here-document** in Bash: the syntax is as follows
```bash
cat >par/tov_ET.par <<"stop_str"
> this is line 1
> this is line 2
> stop_str  (Here it'll stop)
```

- `cat >par/tov_ET.par`: opens the file for writing (overwriting if it exists).
- `<<"stop_str"`: begins a **here-document**, which tells `cat` to read the following lines as standard input until it sees a line exactly matching `stop_str`. Notice that we can use any string as our `stop_str`

---
# Saving terminal outputs

- The classical way is to redirect the output to a `.log` or `.txt` file using `>` or `>>`
	- It redirects the standard output (**stdout**) of the command to a file.

- Another interesting option is to record the terminal session, including everything u see in the terminal: commands, outputs, vi, nano, etc. 
- This recording not only allows u to see the 
- Record session with
```bash
asciinema rec 
```

and to play a `.cast` file
```bash
asciinema play file_name.cast
```

--
- A powerful redirection combination is `2>&1`
	- `2` refers to the file descriptor for **standard error (stderr)**, which is where error messages are typically sent.
	- `&1` refers to the file descriptor for **standard output**. The ampersand (`&`) is crucial here: it tells the shell to treat `1` as a file descriptor, not just a literal number.
	- Putting it all together, `2>&1` means *redirect standard error to the same location as standard output*. 
	
```bash
	python extract_wrf_2015.py > wrf_extract_2015_test2.log 2>&1 &
```
- this sends both the standard output and any error messages to the **same log** file. 

or If u want to send them to different files: 

```bash
command > stdout.log 2> stderr.log
```


---
# Host information

- To get general info: `hostnamectl`

```bash
   Static hostname: jorge-HP-Laptop
         Icon name: computer-laptop
           Chassis: laptop
        Machine ID: 4407183167844338923bca9c0003d374
           Boot ID: 7eec4bfee50345bba14922b05b856cb4
  Operating System: Ubuntu 20.04.6 LTS
            Kernel: Linux 5.4.0-72-generic
      Architecture: x86-64
```

---
# Copy from terminal

- This command allows u to copy text from the terminal to your clipboard so u can safely paste it wherever u want
```bash
pbcopy < path_to_text
```

- Or just use `ctrl` + `shift` + `c` and `ctrl` + `shift` + `v` 

---
# Loops in terminal

- U can run a `for` loop in the terminal like this:
```bash
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```
- Pretty intuitive


---
# Find files and directories

- The `find` command is pretty good and flexible, check manual for details but for now here's the basic syntax:
```bash
find [starting point] -maxdepth [level] -name [known part of the path]
```
For example, if u know the file's name is something like *data whatever*  u can use regular expressions, and u know is at most 3 directories within `~/Documents`, u do:
```
find ~/Documents -maxdepth 3 -name *data*
```

---
# Find command in history

- The most interactive way is using `ctrl + R` 
	- The most useful feature of this one is that it's like u're actually going through the commands using your [up] and [down] arrows, so when u find it, it's already written (especially useful for long commands)
- But if u're a classic kinda guy, create an alias like this in your `~/.bashrc`
```bash
alias cfind='hisory 500 | grep'
```
- And for special occasions when u want to search over the entire history, just use `history | grep` directly in the terminal

---
# Modification date

- Get the modification date of a file

```bash
date --reference=path/to/file
```

---
# Stronger commands

- Use `nohup` prior to your command if u want it be immune to you closing the session
- Use `&` at the end of your command to be able to keep using that terminal session immediately 

```bash
nohup extract_wrf_var.py 2021 WSWDIR &  
```


# Resume SCP 

- See [StackOverFlow](https://stackoverflow.com/questions/26411225/how-to-resume-scp-with-partially-copied-files)
- Partially transfer files from server
- I haven't try this myself, nor can I say is the best thing to do 

```bash
rsync -P -e ssh remoteuser@remotehost:/remote/path /local/path
```
