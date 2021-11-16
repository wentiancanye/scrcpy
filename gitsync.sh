#!/bin/bash
git remote -v
git remote add upstream https://github.com/Genymobile/scrcpy.git
git status
git fetch upstream
git checkout master
git merge upstream/master
git push
