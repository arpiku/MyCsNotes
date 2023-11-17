# Git
1. Git is a software for tracking changes in any set of files, usually used for coordinating work among programmers collaboratively developing source code during software development. Its goals include speed, data integrity, and support for distributed, non-linear workflows (thousands of parallel branches running on different systems).
2. Originally crated by **Linus Trovald**
3. It handles version control using branches and commits that create a history of changes occuring to a set of files.
4. Each commit and change has a unique ID that helps in bracktracking and understanding who did what.
5. Github run the 'git' code and brings things online, providing a service to store and work on code using git, allowing better collaboration due to it's online nature.

## Repo
1. A short form of 'Repository', the project that is being worked on, it's the name of the set of files and folder that are being tracked using git.

## Commit 
1.  When ever a change occurs to the 'repo' it creates a *commit hash*, bascially the changes are refered to as commits.
2. This *commit hash* allows the document to go back to the previous state, the entire history of the documents along with all the changes can be stored.
## branch
1. Branches are created when some change that needs to be tested is being done on the repo, it helps in testing out the code before 'commiting' it to the 'master' branch.
2. 'master' branch generally is the name of the branch containing the finalized set of documentation, e.g the live code that has been reviewed and tested.
3. One opens a new branch when testing out new changes, and when things are finalized one creates a *pull request*.
## Pull request.
1. When only new stuff is added, there is no *conflict*, conflict represents a situtaion where the changes in the new file are conflicting with the existing data, in the sense some information might be getting deleted, or a line of code being changed to something else entirely.
2. The branches can deviate on their own and then can be *merged* into the master.
3. Merging means when two branches are collapsed into one, resulting into a repo that is the union of the merging ones.
4. This is also true for *forked* repos.
5. When a repo is forked, all the documents along with the commit history is **copied** into a new repo that is editable by the person doing the forking.
6. If the changes made are to be implemented into the orginal document, then one needs to do a pull request.

## Issues
1. This is particular to **Github**, they are mainly for the purpose of collaborating on github, one can notice problems/ mistakes/ bugs etc in a project.
2. Once an issue is raised, the repo creator and contributors can review it and resolve the issue.
3. One can paste the *commit hash* in the issue raised, and it will create a link within the issue, and the link will lead to the to commit.




