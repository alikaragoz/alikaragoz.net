#!/bin/sh

# Put the images to be published into the same folder as this file on you computer.
# To execute just double click (as long as you name it post.command) and this script will:
# - Resize the images to 1200px wide.
# - Create thumbnails of the images.
# - Upload them via ssh in the desired server's folder.
# - Create a markdown file with the list of all the uploaded images.

# Important Note: You need to install ImageMagick (brew install imagemagick) and jpegoptim (brew install jpegoptim)

# EDIT THE VARIABLES BELOW

IMAGE_SIZE="1200x"
IMAGE_QUALITY="90"
THUMB_SIZE="460x320"
THUMB_QUALITY="70"

USERNAME="alikaragoz"
HOSTNAME="alikaragoz.net"

PHOTOS_PATH="/home/alikaragoz/alikaragoz.net/public/photos/"
THUMB_PATH="/home/alikaragoz/alikaragoz.net/public/thumbnails/"

# DO NOT EDIT BELOW
# We get the path of the current directory and we move in it
DIR=$(cd "$(dirname "$0")"; pwd)
cd $DIR

# Creating full and thumbnails images folders
FULL_IMG="full"
THUMB_IMG="thumb"
mkdir $FULL_IMG
mkdir $THUMB_IMG

# Creating a preliminary .md file with the images
for file in *.jpg ; do echo "![](/photos/"$file")" >> post.md ; done

# Copying files
cp *.jpg $FULL_IMG/
cp *.jpg $THUMB_IMG/

# Resizing the images
cd $FULL_IMG
mogrify -resize $IMAGE_SIZE *.jpg
jpegoptim --max=$IMAGE_QUALITY *.jpg

# Resizing the thumbnails width and gravity crop in the center
cd ../$THUMB_IMG
mogrify -resize $THUMB_SIZE^ -gravity center -crop $THUMB_SIZE+0+0 *.jpg
jpegoptim --max=$THUMB_QUALITY *.jpg
for file in *.jpg ; do mv $file `echo $file | sed 's/.jpg/\_thumbnail.jpg/'` ; done

# Transfering the photos inside the public directory of the rails app
cd ../
scp -r $FULL_IMG/*.jpg $USERNAME@$HOSTNAME:$PHOTOS_PATH
scp -r $THUMB_IMG/*.jpg $USERNAME@$HOSTNAME:$THUMB_PATH

# Finally we remove the file we just created
rm -rf $FULL_IMG $THUMB_IMG

# Exiting the terminal
osascript -e 'tell application "Terminal" to quit'
