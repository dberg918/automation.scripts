# Automation Scripts
This repository contains a collection of scripts for the purpose of automating 
certain jobs in my podcast workflow.

## launch-episode
`launch-episode` is the master script for launching an episode of our podcast, 
[Lovey Dummies][ld]. It runs in a directory that contains the master WAV file 
and an exported Audacity label TXT file for chapters and takes 3 parameters: 
1. episode number, 2. episode title, and 3. episode subtitle. It compresses the 
master file to OPUS and AAC formats, adds the chapters to the AAC file, then 
uploads them to our AWS S3 bucket.

Lastly, it calculates the episode's duration (for the iTunes feed), puts 
together the front matter for the episode's blog entry, then opens it in vim for 
editing.

### Dependencies
`launch-episode` requires the following packages, all of which can be found in 
Ubuntu 16.04's repos:

    opus-tools ffmpeg gpac mp4v2-utils awscli vim

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
`labels.chapters`.

[ld]: http://loveydummies.com "A podcast about relationships"
[pc]: http://www.shiftyjelly.com/android/pocketcasts
[oc]: https://overcast.fm
