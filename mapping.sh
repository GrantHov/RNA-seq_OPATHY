for folder in plankt* biofil*
	do 
	cd $folder
	mkdir Mapping
	tophat -p 8 -o Mapping -G ~/practice/RNA_seq/C_parapsilosis_CDC317_current_features.gff -g 1 --b2-very-sensitive --library-type fr-firststrand ~/practice/RNA_seq/genome/C_par  *p_1.fastq.gz *p_2.fastq.gz 
	cd ..
done


