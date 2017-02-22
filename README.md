# Chappy
Chappy is a cute little 30-line bash script that parses exported label tracks from Audacity.

## Try it!
Clone the repository and run `./chappy.sh labels.txt` from the root directory. You should now have two files in your directory, `labels.vtt` and `labels.chapters`.

## What the what?
We use this script at [Lovey Dummies][ld] to prepare chapters for our podcast. The `vtt` file is used for chapters on the 
website with our custom audio player, and the `.chapters` file is merged into our audio files with MP4Box and converted to 
an Apple-friendly format with mp4chaps. This allows you to see chapters in apps like [Pocket Casts][pc] and [Overcast][oc].

[ld]: http://loveydummies.com "A podcast about relationships"
[pc]: http://www.shiftyjelly.com/android/pocketcasts
[oc]: https://overcast.fm
