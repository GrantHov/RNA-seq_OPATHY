for folder in plankt* biofil*
	do 
	name="${folder##*_}"
	echo $name
	cd $folder
	skewer -m pe -l 36 -q 15 -Q 15 -o ./$name -t 8 *_1.fastq.gz *_2.fastq.gz 
	cd ..
done


