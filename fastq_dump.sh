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

done


	
	
