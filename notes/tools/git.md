# Git

1. [Start](#wiki-start)
2. [Tagging](#wiki-tagging)
4. [Branches](#wiki-branches)
5. [Quick Recipes](#wiki-quick-recipes)
6. [Resources](#wiki-resources)
7. [Aliases](#wiki-aliases)

![](http://i43.tinypic.com/2rmw7ix.png)

Get some help:

```
git help --all
git <command> --help # displays man page
```

Remember to:
- Commit often so you can cherry pick (but commits, not "branches", these you can simply merge).
- Create annotated tags in order to have all that info. If it's something temporary, use lightweight.
- When you want to commit something in your branch, be sure to be in your branch.


## <a name="start">Start</a>

In case you have already install git, then:

#### Create repository from project

```
cd <project-folder>
git init
```

#### Add .gitignore file
```
vi .gitignore
.DS_Store
_site
```

#### Staging files and committing

```
git add .
git commit -m 'Initial commit'
```

#### Unstage any staged changes for a given file.

```
git reset
```

#### Rename branch name

```
git branch -m old_branch_name new_branch_name
```


#### Push to remote repository (create repo first)

```
git remote add origin ssh://<remote-url>
git push -u origin --all # pushes up the repo and its refs for the first time
git push -u origin --tags # pushes up any tags
```

Read [Advanced Git concepts; the upstream tracking branch](http://felipec.wordpress.com/2013/09/01/advanced-git-concepts-the-upstream-tracking-branch/).

With ```.git/config``` file should look like this

```
[remote "origin"]
	url = ssh://<remote-url>
	fetch = +refs/heads/*:refs/remotes/origin/*
```

#### Remove repository

```
rm -rf .git
```

#### Clone existing repository

```
git clone git://...
git clone http://...
git clone ssh://...
```

## <a name="tagging">Tagging</a>

It exists two types of tags in Git:

- *Lightweight*: a branch that doesn't change. Pointer to a specific commit.
- *Annotated*: stored as full objects in the Git database. Checksummed, author, date, have a tagging message.

#### List tags (in alphabetical order)

```
git tag
```

#### Search for tags with a particular pattern

```
git tag -l "v1.4*"
```

#### The -n flag displays the first line of the annotation message along with the tag.

```
git tag -n
```

It's possible to tag commits after having pushed them, just have to specify the commit hash

```
git tag -a v1.3 9fceb02
```

Another remark to mention: tags doesn't transfer to remote servers unless you specify it. To share tags, just do it as you would do with remote branches:
```
git push origin v1.4
```

Or do them all at once:
```
git push origin --tags
```
#### Create Annotated

```
git tag -a v1.4 -m "my version 1.4"
```

By doing ```git show v1.4``` you'll get author's info and message.

#### Create Lightweight

```
git tag v1.4
```

## <a name="branches">Branches</a>

#### Create branch locally and remotely

You might find yourself in a situation where you have a branch that you created locally and want to push to a remote git repository.

```
git checkout -t -b branch_name
git checkout -t -b nameofthebranch
```

#### Delete a git branch both locally and remotely

```
git push origin --delete <branchName>
```

#### Push branch

Here is the command you would execute to push all of the changes from your plugin branch to a plugin branch on the GitHub repository:

```
git push -u origin plugin # without /
```

This tells git to push changes from your plugin branch to the plugin branch on the origin repository. If origin does not have a plugin branch, it is created on the fly. The -u tells git that you want to be able to easily push and pull changes to that branch in the future.

#### List local branches

```
git branch
```

#### List remote branches

```
git branch -a
```

Before create a new branch pull the changes from upstream, your master need to be uptodate.

#### Create the branch on your local machine

```
git branch <name_of_your_new_branch>
```

####  Push the branch on remote

```
git push origin <name_of_your_new_branch>
```

#### Switch to your new branch

```
git checkout <name_of_your_new_branch>
```

You can see all branches created by using

```
git branch
```

Which will show :

```
master
fix1
fix2
```

#### Add a new remote for your branch
```
git remote add <name_of_your_remote> <url>
```

#### Push changes from your commit into your branch
```
git push origin <name_of_your_remote>
```

#### Delete a branch on your local filesytem
```
git branch -d <name_of_your_new_branch>
```

#### Delete the branch on github
```
git push origin :<name_of_your_new_branch>
```

The only difference it's the : to say delete.

If you want to change default branch, it's so easy with github, in your fork go into Admin and in the drop-down list default branch choose what you want.

#### Merge with master

There's sometimes the need to merge with what's already in production/master in order to work with the latest changes. This also prevents you from having conflicts when you merge this branch in the master later on.

```
git fetch
git merge origin/master
```

#### Revert to commit

```
git revert commitnumber
```

#### Apply commit to current branch

```
git cherrypick
```

## <a name="quick-recipes">Quick recipes</a>

This is a subset of the things I find myself googling.

Here is the list, so I can refer to them later.

#### How do you discard unstaged changes in git?

Stash your changes to drop them later
```
git stash save --keep-index
```

You drop that stash with:
```
git stash drop
```

Or maybe you prefer to revert a single file:

```
git checkout path/to/file/to/revert
```

For all unstaged files use:

```
git checkout -- .
```

#### Delete last not pushed commit

If you have committed junk but not pushed,

```
git reset --soft HEAD~1
```

HEAD~1 is a shorthand for the commit before head.

Alternatively you can refer to the SHA-1 of the hash you want to reset to.

`--soft` option will delete the commit but it will leave all your changed files "Changes to be committed", as git status would put it.

If you want to get rid of any changes to tracked files in the working tree since the commit before head use --hard instead.

#### Delete last pushed commit

Now if you already pushed and someone pulled which is usually my case, you can't use git reset. You can however do a git revert,

```
git revert HEAD
```
This will create a new commit that reverses everything introduced by the accidental commit.

In Git, revert usually describes a new commit that undoes previous commits.

#### Delete the last commit

Extracted from [here](http://samwize.com/2014/01/15/how-to-remove-a-commit-that-is-already-pushed-to-github/).

Deleting the last commit is the easiest case. Let’s say we have a remote mathnet with branch master that currently points to commit dd61ab32. We want to remove the top commit. Translated to git terminology, we want to force the master branch of the mathnet remote repository to the parent of dd61ab32:

```
git push mathnet +dd61ab32^:master
```

Where git interprets ```x^``` as the parent of x and ```+``` as a forced non-fastforward push. If you have the master branch checked out locally, you can also do it in two simpler steps: First reset the branch to the parent of the current commit, then force-push it to the remote.

```
git reset HEAD^ --hard
git push mathnet -f

```

#### Create diff reviews

git fetch && git diff -w 3b8cb0fc1d3d 1d1a6473a63457


#### Change last commit's message

```
git commit --amend
```

#### Viewing Unpushed Git Commits

```
git log origin/master..HEAD
```

You can also view the diff using the same syntax

```
git diff origin/master..HEAD
```

## <a name="resources">Resources</a>

- [Git Commander](https://github.com/golbin/git-commander)
- [Git hooks](http://githooks.com/)
- [Git basics for tagging](http://git-scm.com/book/en/Git-Basics-Tagging)
- [Git Visual Tutorial](http://pcottle.github.com/learnGitBranching/?demo)
- [Git Tutorial](http://try.github.com/levels/1/challenges/1)
- [Git Submodules](http://book.git-scm.com/5_submodules.html)
- [Git Fetch and Merge](http://longair.net/blog/2009/04/16/git-fetch-and-merge/)
- [Git magic with branches](http://www-cs-students.stanford.edu/~blynn/gitmagic/intl/es/ch04.html)
- [Git Ready](http://gitready.com/)
- [Git Stashing](http://www.kernel.org/pub/software/scm/git/docs/git-stash.html)
- [Fractals in Git](http://philippe.bruhat.net/stuff/git-fractals/)
- [Wiki](https://git.wiki.kernel.org/index.php/Main_Page)
- [Why Git](http://thkoch2001.github.com/whygitisbetter)
- [Developing and Deploying with Branches](http://guides.beanstalkapp.com/version-control/branching-best-practices.html)
- [Successful git branching model](http://nvie.com/posts/a-successful-git-branching-model/)
- [Finding and Purging Big Files From Git History](http://naleid.com/blog/2012/01/17/finding-and-purging-big-files-from-git-history)
- [Git grep (fast search)](http://git-scm.com/docs/git-grep)
- [Raw Git](http://rawgit.com/)
- [Rename branch](https://ariejan.net/2010/08/09/rename-a-git-branch/)
- [https://github.com/blog/2019-how-to-undo-almost-anything-with-git](https://github.com/blog/2019-how-to-undo-almost-anything-with-git)
- [Git as DB](https://speakerdeck.com/bkeepers/git-the-nosql-database)
- [how-to-remove-a-commit-that-is-already-pushed-to-github](http://samwize.com/2014/01/15/how-to-remove-a-commit-that-is-already-pushed-to-github/)
- [common-git-screwupsquestions-solutions](http://41j.com/blog/2015/02/common-git-screwupsquestions-solutions/)
- [git-for-svn-users](https://people.gnome.org/~newren/eg/git-for-svn-users.html)