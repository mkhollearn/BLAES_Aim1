import pandas
from glob import glob
import os
import shutil #help to copy images

#print('running script')
df = pandas.read_csv('final_output.csv')
#print(df)

#this part of the code copies the actual images from MST set 1 to a new folder called final_images to be used for the BLASE task
os.chdir("../Set 1") 
set1_images = os.listdir() # this is an unsorted list of strings
set1_images.sort()
df_set1 = df[df["Set #"]=='1']

for i in set1_images:
	if i in df_set1["MDT-O "].values:
		print(i,"true")
		shutil.copyfile(i,'../BLAES_imageset/final_images/' +"1_" +i)
	else:
		print(i,"false")
		
#and here we iterate over the rest of the sets doing the same thing as above
os.chdir("../")
sets = ["2", "3", "4", "5", "6", "C", "D", "E", "F"]
for s in sets:
	os.chdir('Set ' + s)
	set_images = os.listdir()
	set_images.sort()
	df_sets = df[df["Set #"]== s.lower()]
	for i in set_images:
		if i in df_sets["MDT-O "].values:
			print(s,i,"true")
			shutil.copyfile(i,'../BLAES_imageset/final_images/' + s+ "_" +i)
		else:
			print(s,i,"false")
	os.chdir("../")