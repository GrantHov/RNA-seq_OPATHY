for folder in bio* pla*
	do
	name="${folder##*_}"	
	cd $folder/Mapping/
	mv sorted_accepted_hits.sam.htseq.count $name.count
	cd ..
	cd ..
	done
