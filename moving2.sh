for f in plank* biof*
	do
	name="${f##*_}"
	cd counts
	mkdir $name
	cp ~/practice/RNA_seq/$f/Mapping/$name.count ~/practice/RNA_seq/counts/$name/
	cd ..
	done
	


