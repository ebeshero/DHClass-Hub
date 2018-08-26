# Using Git through Command Line
  
*To download a file without cloning or pulling in changes locally, navigate to the file on GitHub and on the right side near the top of the file's content click the button that gives you the "Raw" view of the file. From there you can copy and paste or right click and save.*
  
## Quick reference
* Open terminal / command line shell
* Navigate to repo.
* `git pull`
* Make changes.
* `git status` -- list of changes should be red
* `git add -A` OR `git add .`
* `git status` -- list of changes should be green
* `git commit -m "message here"`
* `git push`
  
## Detailed walk-through

1) The key thing to working with Git is **always knowing where to find your files in the Finder (on Mac) / File Explorer (on Windows) and in the Terminal/Command Line Shell**. So you need to save them in a place where you can easily see them. 
* In the Finder/File Explorer, make yourself a "GitHub" directory that lives inside "Documents" (or on your desktop if that is a more logical place for you). Inside the "GitHub" directory you will clone each of your project repositories.
* In the Terminal/Command Line Shell), you can navigate to your "GitHub" directory from the computer's root by typing:
`cd Documents/GitHub/` if stored in documents or `cd Desktop/GitHub/` if stored on your desktop
**`cd` means "change directories"** and in the above command you are *stepping down* into Documents (or Desktop) and into the GitHub folder. Use **`ls`** to list out the contents of the directory you have stepped down into.

* If you need to **clone** a repository, do so here, because then the new repository will sit as a *child* inside your GitHub directory. Go to the git remote website and get its "Download/Clone" URL by copying it (green icon on right side of the repo's main page). 
Then, in the Terminal/Command Line Shell, type `git clone` and paste in the the URL after that. So it looks like this for our DHClass-Hub:
````
git clone https://github.com/ebeshero/DHClass-Hub.git
````
Hit enter, and watch the lines scroll away in the command line terminal as the repository clones itself on your local computer inside your GitHub directory. 

2) You interact with your local directory the way you would any other. You can drag files into it using the Finder/File Explorer, save files into it, and check in with the remote repository to **pull** new files in.  
So this is what you should do:
Open Terminal/Command Line Shell, and step down into your GitHub directory, and then down into the DHClass-Hub (or desired repo), and check that you are where you want to be **by typing `ls`.** The ls command will **show the contents of the directory** in which you've positioned yourself. You can **`cd`** up or down (cd means change directory), by moving like this:
````
cd ..
````
This moves up to a parent directory.

````
cd directoryName
````
This moves down into a directory. 

* To make sure you're in the right directory, the top level of the DHClass-Hub, also check to see the directory name at the terminal prompt. Yours should look similar to this, and the key part is "DHClass-Hub":
`gbg-wireless-pittnet-150-212-105-8:DHClass-Hub ebb8$ `

Then to pull in any changes from the remote "mothership" repo, type:
````
git pull
```` 

3) When you want to share you local changes to the repo with the remote mothership and other collaborators, you need to **add**, **commit**, and **push** those changes. Here's how you do it:

* Make sure you're in the DHClass-Hub repo at the top level
* Then type:
````
git add .
````
The period means *all* -- as in add *all* new files to be tracked by Git.

* If you type `git status` at this point, you see highlighted in green the new files being added! 
* Now, you need to **commit** those changes. You type the commit, and write a message, because Git *always* makes you document changes to the repo:
````
git commit -m "your detailed commit message should go in here"
````
Think of these commit messages as breadcrumbs for you and others to use in recording your project's progress! Check out our issue on [Effective Git Commit Messages](https://github.com/ebeshero/DHClass-Hub/issues/217).

* Next, you push the commit through, with:
````
git push
````
And gears turn and lines of text whirl on the screen, and your changes go up into the remote "Mothership repo"! You should always check on the web repository to see if your commit went through.  
 
## Dealing with merge issues
When you and other team members are working in a repo at the same time, and each of you is pulling, committing, and pushing files, you may find that you cannot pull in changes to your local repo, because GitHub warns that changes might write over the state of your work. 

* To deal with a merge issue, you need to first be sure that you `git add` and `git commit` any changes you have made. (You won't be able to push them just yet.) 
* Now, type:
```
git pull
```
* GitHub will now attempt a merge of your commit with the new material. It will attempt to do this automatically (something GitHub was designed to do). As long as you and your team member were working on different files or on very different areas of the same file, GitHub will be able to work out a way to merge your changes with your teammates'. But you will need to add and commit the result. GitHub will invite you to do this using an ancient early-days-of-computing editor called the "vi" editor, which will open on top of your terminal, and it will invite you to edit its standard commit message which will indicate that this is a "merge". To edit in vi, your usual tools of writing won't work (your mouse doesn't work here, and you have to type commands to move around the screen). Type the following to insert your own text if you want to add your own description to the merge):
```
I
```
(The "I" is for "insert"). Type whatever you want to add or modify at the top line where the commit message goes. You do use quotation marks around the commit message in the vi editor. When you're finished, type this sequence

```
esc : w q
```
That's the escape key then colon, w, and q. This combination let's you escape out of the commit-editing window, then :wq is to write and quit the vi editor. This will bring you back to the terminal / command line prompt where you normally write git commands.

* Now, type `git status` and it should tell you that you're ready to push two (or more) commits (the result of your merge plus your first commits that were never pushed). It should prompt you to do a `git push`. So do that. Type
```
git push
```
And the merge should be resolved.

## Merge conflicts
A variation on the merge issue above involves multiple team members working on a file and pushing at nearly the same time. The edits may be in locations where it is difficult for GitHub to automatically figure out how to merge them. When you attempt to pull these in, you will be told that GitHub cannot automatically complete the merge. Don't panic, but **do** be patient. 

* First, you may want to inform your team members that there is a merge conflict and you're going to work on resolving it, and that they should wait to hear from you before trying any new commits. 

* In your terminal / command line, when you attempt to pull, GitHub informs you which file(s) are affected, and you should then open these in `<oXygen/>` to resolve the conflict by hand. GitHub makes it as easy as possible to do this, because it will mark the affected areas with what I like to call "tire tracks", like so:

```
>>>>>>>>>
>>>>>>>>>
code of one version

============
============
code of the other version
>>>>>>>>>
>>>>>>>>>

```

You'll need to read this carefully and delete the version that's not wanted, as well as the GitHub "tiretrack" marks. Save the file and return to your command line / terminal. 

Type `git add` and `git commit -m "your message about resolving the merge conflict here"`. Then try a `git status` to make sure all is well, and if GitHub approves, go ahead and type `git push` to resolve the conflict.

Your team members should now do a `git pull` and pull in your resolution of the merge conflict, and all may continue their work as before. 
  
### Git commands for a Forked Repo workflow
* `git pull upstream master` (This pulls any changes that were made to the original repository since you last synced into your forked repository.)
* Save changes / move files into directory through File Explorer / Finder
* `git status` (shows the differences/changes between the master and your fork/branch -- should be red)
* `git add .` OR `git add -A` (You're adding your changes to your branch.)
* `git status` (To see that you added your changes to your branch -- should be green.)
* `git commit -m "your commit message here"` (Commits your changes to your branch with a message describing changes.)
* `git status` (To see that your commit was successful and your branch is ahead of your remote fork.)
* `git push` (Push your committed changes to your remote fork.)
* Create a pull request on the web repository from your fork to the original repo

## Further Reading: Becca Parker's ["Explain Git Shell"](http://dh.newtfire.org/explainGitShell.html) tutorial  

