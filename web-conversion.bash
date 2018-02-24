# Extensions to convert
images=(jpg jpeg png JPG JPEG PNG)
videos=(mp4 MP4)

# Colours
GREEN='\033[0;32m'
WHITE='\033[1;37m'
BLUE='\033[0;34m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color


# Check software is installed
if [ ffmpeg ]; then
  echo FFMPEG installed
else
  printf "${RED}FFMPEG is not installed.${NC}\n"
  echo Try running: brew install ffmpeg –with-libvpx –with-libvorbis –with-fdk-aacc
  echo https://www.webmproject.org/tools/
  exit
fi

if [ cwebp ]; then
  echo CWEBM installed
else
  printf "${RED}CWEBP is not installed.${NC}\n"
  echo https://developers.google.com/speed/webp/docs/using
  exit
fi

# Delete afterwards
printf "${GREEN}Converting images and videos in ${NC}${PWD}\n"
echo -n "Do you want to delete original files, once converted? (Y/n)"
read answer
if echo "$answer" | grep -iq "^y" ;then
    delete=1
else
    delete=0
fi

# All files in folder
for file in *
do
  # Get file extension and name
  filename=$(basename "$file")
  extension="${filename##*.}"
  filename="${filename%.*}"

  # Convert to images
  if [[ " ${images[@]} " =~ " ${extension} " ]]; then
    printf "${WHITE}Converting ${GREEN}$filename${WHITE} to ${BLUE}WEBP${NC}\n"
    cwebp -q 80 "$file" -o "$filename.webp"

    # Clean up
    if [ delete ]; then
      rm "$file"
    fi

  fi

  # Convert Videos
  if [[ " ${videos[@]} " =~ " ${extension} " ]]; then
    printf "${WHITE}Converting ${GREEN}$filename${WHITE} to ${CYAN}WEBM${NC}\n"
    ffmpeg -i "$file" -c:v libvpx -crf 10 -b:v 1M -c:a libvorbis "$filename.webm"

    # Clean up
    if [ delete ]; then
      rm "$file"
    fi
  fi

done
