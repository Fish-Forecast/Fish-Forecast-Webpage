# Forecasting Webpage

This is a webpage for the Fish Forecasting lectures and labs.  To use is as a template for a specific course, see notes below on how to copy into another repository.

## Lecture slides

This is based on Mark's slide templates (present) for presentations written in R Markdown using **[xaringan](https://github.com/yihui/xaringan)**, an R package for creating slideshows with **[remark.js](http://remarkjs.com)**.

Put external (meaning not produced by R within the Rmarkdown file) figures and pictures in directory 'figs'.

The internally made figures will be put automatically in 'template_files/figure-html'.

See template.Rmd for examples of formatting slides.

Click 'knit' in RStudio to create the html file.  To print to pdf, use Chrome.

## Using this as a template for a course website

To clone this for another course. Do this once.

1. Create the repo New-Repo (or whatever you want to name) on GitHub
2. Open terminal and run these commands which will

  * copy the 'master repo' to a new repo for your course
  * set the remote, called origin' for your new repo
  * add a second remote called 'upstream' that points to the 'master repo'.  You need this to push changes from upstream into New-Repo later
  * push the local master branch to the remote called origin

```
cd New-Repo
git clone https://github.com/Fish-Forecast/Fish-Forecast-Webpage 
cd New-Repo
git remote set-url origin https://github.com/Fish-Forecast/New-Repo
git remote add upstream https://github.com/Fish-Forecast/Fish-Forecast-Webpage
git push origin master
```

## Updating New-Repo when Fish-Forecast-Webpage changes

If you make changes in the master repo and want to push to the copy run this code.  This assumes the changes in master are on github so pushed from local. 

```
# make sure at New-Repo
cd New-Repo
git pull upstream master
```

Updating just one file, file1, from upstream. Something like this might work.

```
cd New-Repo
git fetch upstream
git checkout -m upstream/master -- file1
git add file1
git commit -m "my message"
git push origin master
```

## Merge changes from New-Repo back into the original

If you make changes in New-Repo and want to merge into Fish-Forecast-Webpage...  Oh dear, that's probably a recipe for a slew of merge conflicts but here's the code.

Push everything into upstream. Make sure that is what you really want to do.

```
# make sure at New-Repo
cd New-Repo
git push upstream master
```

Or just a file or two. Use `git status` to double-check what is going to be pushed.

```
cd New-Repo
git status
git add file1
git commit file1 -m "my message"
git status
git push upstream
```
