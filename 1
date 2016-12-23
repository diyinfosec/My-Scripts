#======================================================================================================
#- This script will convert a list file containing FOR572 Course Index into a TOC List file
#- 1. The Course Index is available as a docx file at the below link:
#- https://www.evernote.com/pub/philh/for572notebook#st=p&n=735707b2-73a1-4c78-8c20-cdb209b40659
#- 2. Copy contents of the file and put it in a simple text file (index.dat)
#- 3. Run this script. It is assumed the index.dat is in the same directory as the script
#- 4. The output TOC file will be created in the same directory with the name "output.dat"
#======================================================================================================

#- Initialize input and output file name
index_file="index.dat"
output_file="output.dat"

#- Initialize temporary file names, remove the files if already existing
tmp_file_1="tmp$$_1.dat"
tmp_file_2="tmp$$_2.dat"
/bin/rm -f $tmp_file_1 $tmp_file_2

#- Create temp file 1. This will remove any non-numeric lines (i.e. ones without page numbers) 
#- and also replace the first occurenct of tab with pipe symbol
grep [0-9] $index_file | sed 's/\t/|/' > $tmp_file_1

#- Read through temp file 1
while read line
do
	#- Extract topic and page information from every line
	topic=`echo $line | cut -f1 -d"|"`
	pages=`echo $line | cut -f2 -d"|"`

	#- Process page information and create temp file 2
	echo $pages | awk -F\, -v tmp_file_2="$tmp_file_2" -v topic="$topic" '{
			for (i = 0; ++i<=NF;)
			{
				split($i,page_array,":")
				chapter_number=page_array[1]
				page_range=page_array[2]

				split(page_range,single_pages,"-")
				start_page=single_pages[1]
				end_page=single_pages[2]

				if(end_page == "")
						end_page = start_page

				#- Write content to temp file 2
				print chapter_number "|" start_page "|" end_page "|" topic >> tmp_file_2
			}
		  }' 

	#- Sort the contents of temp file 2 and write them to the TOC file
	sort -t"|" -n -k1,1 -k2,2 -k3,3 $tmp_file_2 | sed 's/^ //g' > $output_file
done < $tmp_file_1

#- Clean up the temp files 
/bin/rm -f $tmp_file_1 $tmp_file_2

#- Exit
exit
