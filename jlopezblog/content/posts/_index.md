---
title: "Papers"
---

Added with _index.md at the posts directory

Only the files named index.md will be listed in this posts homepage

Still trying to figure out how to adjust the image size

Here's how to highlight some code lines. Try other styles (catppuccin-mocha, tokyonight-night,base16-snazzy, fruity, github-dark, monokai, native)

```go {linenos=inline hl_lines=[3,"6-7"] style=native}  
package main

import "fmt"

func main() {
    for i := 0; i < 3; i++ {
        fmt.Println("Value of i:", i)
    }
}
```

Code using `base16-snazzy`

```Python {linenos=inline hl_lines=[3,"6-7"] style=base16-snazzy} 
#!/usr/bin/python3

import h5py

file_name = "model_checkpoint.weights.h5" 

f = h5py.File(file_name, "r")

for key in f.keys():
    print(key) 			#Names of the root level object names in HDF5 file - can be groups or datasets.
    print(type(f[key])) 	# get the object type: usually group or dataset

#Get the HDF5 group; key needs to be a group name from above
group = f[metrics]

#Checkout what keys are inside that group.
for key in group.keys():
    print(key)

# This assumes group[some_key_inside_the_group] is a dataset, and returns a np.array:

data = group["metrics"][()]

#Do whatever you want with data
print(data)

#After you are done
f.close()
```

Python code using `monokai`

```Python {linenos=inline hl_lines=[3,"6-7"] style=monokai} 
#!/usr/bin/python3

from moviepy.editor import *

# Paths
#image_folder = "../ImagesAWS/flat" # Folder containing your images
audio_path = "../../Música/y2mate.com - Young Turks 2008 Remaster.mp3"  # Path to your audio file
output_path = "output_video.mp4"  # Output MP4 file

# Load all images in the folder
#import os
#image_files = sorted([os.path.join(image_folder, img) for img in os.listdir(image_folder) if img.lower().endswith(('.png', '.jpg', '.jpeg'))])

# Load images from paths.txt
with open("paths.txt", "r") as file:
    image_files = [path for path in file.read().splitlines() if path.lower().endswith(".jpg")]

# Sort the filtered paths
image_files = sorted(image_files)

# Create a list of ImageClips (each image shown for 3 seconds)
image_clips = [ImageClip(img).set_duration(2) for img in image_files]

# Concatenate the images into a video
video = concatenate_videoclips(image_clips, method="compose")

# Load the audio file and set it to loop to match the video duration
audio = AudioFileClip(audio_path)
looped_audio = audio.fx(afx.audio_loop, duration=video.duration)

# Add the audio to the video
video_with_audio = video.set_audio(looped_audio)

# Export the final video
video_with_audio.write_videofile(output_path, fps=3, codec="libx264", audio_codec="aac")
```

Killua having a drink

![killua](/killua1short.jpg)
