import os
import datetime
import glob

path =  r'C:\Housekeeping'
logging_path =  r'C:\Housekeeping\Logs'

today = datetime.datetime.today()
os.chdir(path)

# creating a log file with date
file = open(logging_path + datetime.datetime.today().strftime('%d-%m-%Y_%H_%M') + '.txt', 'w+')

for root, directories, files in os.walk(path, topdown=False):
    for name in files:
        t = os.stat(os.path.join(root, name))[8]
        filetime = datetime.datetime.fromtimestamp(t) - today
        #Hier in dem Bsp. werden alle Dateien Ordner die älter als 60 Tage sind gelöscht
        #if filetime.days <= -30:
        if filetime.days <= -60:
            print(os.path.join(root, name), filetime.days)
            file.write(
                os.path.join(root, name) + ' created ' + str(-1 * filetime.days) + ' days ago\n')  # writing in the file
            os.remove(os.path.join(root, name))