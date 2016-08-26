for folder in plankt*
        do 
        cd $folder
        cd Mapping
	samtools index accepted_hits.bam
        samtools sort -o sorted_accepted_hits.bam -n -@ 8 accepted_hits.bam
	samtools view -h sorted_accepted_hits.bam > sorted_accepted_hits.sam
	htseq-count -m union -t exon -i ID -o sorted_accepted_hits.sam.htseq sorted_accepted_hits.sam ~/practice/RNA_seq/C_parapsilosis_CDC317_current_features.gff 1>sorted_accepted_hits.sam.htseq.count 2>sorted_accepted_hits.sam.htseq.count.log

	cd ..
	cd ..
done

for folder in biofil*
        do 
        cd $folder
        cd Mapping
	samtools index accepted_hits.bam
        samtools sort -o sorted_accepted_hits.bam -n -@ 8 accepted_hits.bam
	samtools view -h sorted_accepted_hits.bam > sorted_accepted_hits.sam
	htseq-count -m union -t exon -i ID -o sorted_accepted_hits.sam.htseq sorted_accepted_hits.sam ~/practice/RNA_seq/C_parapsilosis_CDC317_current_features.gff 1>sorted_accepted_hits.sam.htseq.count 2>sorted_accepted_hits.sam.htseq.count.log
	cd ..
	cd ..
done
