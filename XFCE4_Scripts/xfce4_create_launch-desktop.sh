#!/bin/bash
# Create .desktop
# Reference: https://wiki.xfce.org/howto/customize-menu

option="gui"
path="$HOME/.local/share/applications"

# Example
app="Folders"
category="Folders"
command="thunar $HOME"
filename="$path/$app.desktop"

if [[ $option == "gui" ]]; then
	# exo-desktop-item-edit --create-new [DIRECTORY]
	exo-desktop-item-edit --create-new $path
else
	# Command line
	if [[ -d "$path/" ]]; then
		if [[ ! -f "$filename" ]]; then
			echo "[Desktop Entry]" > $filename
			echo "Version=1.0" >> $filename
			echo "Type=Application" >> $filename
			echo "Icon=xfce4-logo" >> $filename
			echo "Name=$app" >> $filename
			echo "GenericName=$app" >> $filename
			echo "Comment=$app for XFCE4" >> $filename
			echo "Exec=$command" >> $filename
			echo "Terminal=false" >> $filename			
			echo "StartupNotify=false" >> $filename
			echo "Categories=X-$category;" >> $filename
			echo "OnlyShowIn=XFCE" >> $filename
			echo "Create: $filename"
		else
			echo "File already exists!"
			echo "Failure on create : $filename"
		fi
	else
		echo "Directory $path not found!"
		echo "Failure on create : $filename"
	fi
fi