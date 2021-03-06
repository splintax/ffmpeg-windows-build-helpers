cd sandbox/win32/ffmpeg_git
git_version=`git rev-parse HEAD`
echo $git_version
cd ../../..
mkdir -p distros
date=`date +%Y-%m-%d`
file="ffmpeg-distro-static-$date-$git_version"
dir="distros/$file"
rm -rf $dir
mkdir $dir
if [ -f ./sandbox/win32/ffmpeg_git/ffmpeg.exe ]; then
  mkdir $dir/32-bit
fi
if [ -f ./sandbox/x86_64/ffmpeg_git/ffmpeg.exe ]; then
  mkdir $dir/64-bit
fi

# TODO include shared builds too, now, also maybe separate zips for everything, put them in their own folder?

cp ./sandbox/win32/ffmpeg_git/ffmpeg.exe "$dir/32-bit"
#cp ./sandbox/win32/ffmpeg_git/ffplay.exe "$dir/32-bit"
#cp ./sandbox/win32/ffmpeg_git/ffmpeg_g.exe "$dir/32-bit"

# old shared build stuff...
#cp ./sandbox/win32/ffmpeg_git/*/*-*.dll     "$dir/32-bit" 
#./sandbox/mingw-w64-i686/bin/i686-w64-mingw32-strip $dir/32-bit/*.dll

#cp ./sandbox/x86_64/ffmpeg_git/ffmpeg.exe "$dir/64-bit"
#cp ./sandbox/x86_64/ffmpeg_git/ffplay.exe "$dir/64-bit"
#cp ./sandbox/x86_64/ffmpeg_git/ffmpeg_g.exe "$dir/64-bit"

# old broken shared stuff...
#cp ./sandbox/x86_64/ffmpeg_git/*/*-*.dll     "$dir/64-bit"
#./sandbox/mingw-w64-x86_64/bin/x86_64-w64-mingw32-strip $dir/64-bit/*.dll

cd distros
7zr a "$file.7z" "$file/*" || 7za a "$file.7z" "$file/*"  # some have a package with only 7za, see https://github.com/rdp/ffmpeg-windows-build-helpers/issues/16
cd ..

echo "created distros/$file"
