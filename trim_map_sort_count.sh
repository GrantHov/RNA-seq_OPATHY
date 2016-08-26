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


