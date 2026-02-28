# Git Rebasing

* Each commit should make a minimally meaningful changes, including its own tests.
* Each commit should individually build and pass all tests.
* Commits should be designed to support future reverts. When each commit is self-contained, they can
  be individually reverted without breaking the repository. Subsequent commits may depend on code in
  previous commits, but previous commits should be self-contained and not rely on future commits to
  put them in a usable state.
* Err on the side of making commits too small rather than too large.
* Err on the side of creating more commits rather than fewer commits, as it is easier to
  retroactively squash commits than to split them apart.
* Do not write commits like "fix tests" or "refactor x". Instead edit the relevant commit to include
  the required changes.
* Temporary WIP or fixup commits are fine and even encouraged for exploratory work, but these are
  expected to be squashed into another commit before merging.
* You may create a WIP commit with some suggestions and leave it for me to squash myself.
* DO NOT EVER edit `.git/` files directly. Only use `git` commands to interact with source control.
* Do not push any changes to a remote, I will push when I am comfortable with changes.
