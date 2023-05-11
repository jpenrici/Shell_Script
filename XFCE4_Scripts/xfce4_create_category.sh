#!/bin/bash
# Create sub-menus
# Reference: https://wiki.xfce.org/howto/customize-menu

# In .menu
#  ...
#  <Menu>
#    <Name>Folders</Name>
#    <Directory>folders.directory</Directory>
#    <Include>
#      <Category>X-Folders</Category>
#    </Include>
#  </Menu>
#  ...

# Example: ~/.local/share/desktop-directories/Folders.directory
category="Folders"
path="$HOME/.local/share/desktop-directories"
filename="$path/$category.directory"

if [[ -d "$path/" ]]; then
	if [[ ! -f "$filename" ]]; then
		echo "[Desktop Entry]" > $filename
		echo "Version=1.0" >> $filename
		echo "Type=Directory" >> $filename
		echo "Icon=xfce4-logo" >> $filename
		echo "Name=$category" >> $filename
		echo "Comment=$category for XFCE4 menu" >> $filename
		echo "Create: $filename"
	else
		echo "File already exists!"
		echo "Failure on create : $filename"
	fi
else
	echo "Directory $path not found!"
	echo "Failure on create : $filename"
fi
