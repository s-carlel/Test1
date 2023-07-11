import os, time, shutil, logging

seconds_in_day = 24 * 60 * 60

source_folder = "C:\vGarage"
destionation_folder = "C:\Backup"

now = time.time()
before = now - seconds_in_day

def last_mod_time(fname):
    return os.path.getmtime(fname)

for fname in os.listdir(src):
   src_fname = os.path.getmtime(fname)
     if last_mod_time(src_fname) > before:
       dst_fname = os.path.join(source_folder, fname)
       shutil.move(src_fname, dst_fname)
