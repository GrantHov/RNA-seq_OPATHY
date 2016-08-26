i=1
for file in SRR1278968 SRR1278969 SRR1278970 SRR1278971 SRR1278972 SRR1278973
do
	if [ $i -le 3 ]
		then
		mkdir planktonic_${i}_${file}
		#echo $i
		cd planktonic_${i}_${file}
		fastq-dump --split-3 $file
		pigz -p 8 $file*  ################# USE 8 cores for gzipping ############### 
		cd ..
		i=$((i+1))
	else
		j=$((i-3))
		mkdir biofilm_${j}_${file}
		#echo $j
		cd biofilm_${j}_${file}
		fastq-dump --split-3 $file
		pigz -p 8 $file*  ################# USE 8 cores for gzipping ###############
		cd ..
		i=$((i+1))
	fi
done

for folder in plankt* biofil*
	do 
	name="${folder##*_}" ### string, following last "_"
	echo $name
	cd $folder
	skewer -m pe -l 36 -q 15 -Q 15 -o ./$name -t 8 *_1.fastq.gz *_2.fastq.gz 
	cd ..
done

rename 's/-trimmed-pair/_tr_p\_/' biofilm_*/*pair* planktonic_*/*pair*

for folder in plankt* biofil*
	do 
	cd $folder
	mkdir Mapping
	tophat -p 8 -o Mapping -G ~/practice/RNA_seq/C_parapsilosis_CDC317_current_features.gff -g 1 --b2-very-sensitive --library-type fr-firststrand ~/practice/RNA_seq/genome/C_par  *p_1.fastq.gz *p_2.fastq.gz 
	cd ..
done

for folder in plankt* biofil*
        do 
        cd $folder
        cd Mapping

	echo "Indexing " $folder
	samtools index accepted_hits.bam
	echo "Indexing done with " $folder

	echo "Sorting " $folder
        samtools sort -o sorted_accepted_hits.bam -n -@ 8 accepted_hits.bam
	echo "Sorting done with " $folder

	echo "BAM->SAM for " $folder 
	samtools view -h sorted_accepted_hits.bam > sorted_accepted_hits.sam
	echo "Convertion done for " $folder

	echo "Read counting for " $folder
	htseq-count -m union -t exon -i ID -o sorted_accepted_hits.sam.htseq sorted_accepted_hits.sam ~/practice/RNA_seq/C_parapsilosis_CDC317_current_features.gff 1>sorted_accepted_hits.sam.htseq.count 2>sorted_accepted_hits.sam.htseq.count.log
	echo "Counting is done for" $folder

	cd ..
	cd ..
done


