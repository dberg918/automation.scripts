# Automation Scripts
This repository contains a collection of scripts for the purpose of automating 
certain jobs in my podcast workflow.

## launch-episode
`launch-episode` is the master script for launching an episode of our podcast, 
[Lovey Dummies][ld]. It runs in a directory that contains the master WAV file,
an exported Audacity label TXT file for chapters, and a JPEG image for social
media. These 3 files should all have the same "episode-#" file name. The script
takes 3 parameters: 1. episode number, 2. episode title, and 3. episode
subtitle. It compresses the master file to OPUS and AAC formats, writes
metadata, adds the chapters to the AAC file, renames the JPEG image to match
the episode title, then uploads them to our AWS S3 bucket.

Lastly, it calculates the episode's duration (for the iTunes feed), puts 
together the front matter for the episode's blog entry, then opens it in vim for 
editing.

### Dependencies
`launch-episode` requires the following packages, all of which can be found in 
Ubuntu 16.04's repos:

    opus-tools fdkaac mp4v2-utils awscli vim

It also requires the `chappy` script in this repo, so make sure it's available 
in your $PATH! An easy and sudo-free way to do that is the following:

    $ mkdir -p ~/.local/bin && cp chappy ~/.local/bin/chappy

## chappy
`chappy` is a cute little 30-line bash script that parses exported label tracks 
from Audacity. It is briefly used in the `launch-episode` script to create 
properly formatted chapters for the website (WebVTT), as well as a chapter file 
integrated into our M4A file so that listeners can browse chapters in apps like 
[Pocket Casts][pc] and [Overcast][oc].

### Try it!
Clone the repository and run `./chappy tests/labels.txt` from the root directory.
You should now have two files in your directory, `labels.vtt` and 
`labels.chapters.txt`.

## lovey-stats
`lovey-stats` is a script that pulls logfiles from an AWS S3 bucket, turns them 
into NCSA CLF logs, and feeds them to Webalizer to generate approximate 
download statistics. It's designed to run daily as a cron job to get yesterday's 
stats, although you can feed it a date parameter in the terminal to get stats 
for a particular date, month, or year. For example, `lovey-stats "2016-10-20"` 
will generate statistics for October 20, 2016; `lovey-stats "2016-10"` will 
generate them for the entire month of October 2016; and `lovey-stats "2016"` 
will generate them for all of 2016.

### Dependencies
`lovey-stats` requires the following packages, all of which can be found in 
Ubuntu 16.04's repos:

    awscli webalizer

### Note about using cron
If you plan to use `cron` for generating daily statistics, keep in mind that it 
runs in a very limited `env`. I decided to use `pip` to install the latest 
version of `awscli`, but `pip` installed it in `/usr/local/bin`, which was not 
in the pared-down $PATH of `cron`. Just be sure to include your desired $PATH in 
your crontab!



[ld]: http://loveydummies.com "A podcast about relationships"
[pc]: http://www.shiftyjelly.com/android/pocketcasts
[oc]: https://overcast.fm
