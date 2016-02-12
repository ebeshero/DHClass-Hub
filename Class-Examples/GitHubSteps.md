##GitHub steps working from fork and branch:

* ls (This gives you all of the repositories that are cloned to your computer)
* cd [whatever repository you want to contribute to] (This takes you directly into the repository you wish to contribute to)
* git pull upstream master (This pulls any changes that were made to the original repository since you last synced into your forked repository)
* git status (This is used a lot just to see the differences/changes between the master and your fork/branch, so you will see it a lot here)
* git checkout [branch name] (This will take you into the branch you are working in that is separate from your fork)
* PUT YOUR CONTRIBUTIONS INTO THE FOLDER YOU WISH TO MAKE CHANGES TO
* git status (To see the changes that you have made)
* git add . OR git add -A (You're adding your changes to your branch)
* git status (To see that you added your changes to your branch)
* git commit -m "[your commit message here]" (Commit your changes to your branch)
* git status (To see that you committed and your branch is up to date with what you've been working in)
* git checkout master (To go back into your forked repository from your branch)
* git merge [branch name here] (You're merging your changes in your branch to your forked repo)
* git push --all -u (You are pushing all of the changes into your fork)
* git status (Just to make sure you pushed everything)
* You now need to get on the GitHub website and Create a Pull Request
* DONE!!