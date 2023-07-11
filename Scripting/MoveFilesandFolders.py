import time, os, shutil, datetime, logging
#Die letzten 7 Tage in Sekunden
#SECONDS_IN_DAY = 7 * 24 * 60 * 60
#alle Stunde wird verschoben 
SECONDS_IN_DAY = 1 * 60 * 60

src = r"C:\vGarage"
dst = r"C:\Housekeeping\moved_on_"


#Ordner mit Timestamp erstellen zum verscheiben
datestring = dst + datetime.datetime.now().strftime("%Y-%m-%d_%H_%M");
print (datestring);
if not os.path.isdir(datestring):
    os.mkdir(datestring)
else:
    print("Directory already exists")

now = time.time()
before = now - SECONDS_IN_DAY

def last_mod_time(fname):
    return os.path.getmtime(fname)

for fname in os.listdir(src):
    src_fname = os.path.join(src, fname)
    if last_mod_time(src_fname) < before:
        dst_fname = os.path.join(datestring, fname)
        shutil.move(src_fname, dst_fname)