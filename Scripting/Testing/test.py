# Python program to move
# files and directories


import shutil

# Source path
source = "C:\vGarage"

# Destination path
destination = "C:\ITM"

# Move the content of
# source to destination
dest = shutil.move(source, destination)

# print(dest) prints the
# Destination of moved directory
