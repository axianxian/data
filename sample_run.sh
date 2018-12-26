#!/bin/bash
path=/home/sensetime/huyu/senseid_facepro-2.0.0-face_professional-linux-464bbae/samples/c++/output.txt
license_file="/home/sensetime/huyu/senseid_facepro-2.0.0-face_professional-linux-464bbae/samples/c++/senseid_facepro.lic"
activate_folder="/home/sensetime/huyu/senseid_facepro-2.0.0-face_professional-linux-464bbae/samples/c++/senseid_facepro_sn"
sample_path=/home/sensetime/huyu/senseid_facepro-2.0.0-face_professional-linux-464bbae/samples/c++
license_path=/home/sensetime/Documents/facepro_license

#for filename in $( ls $sample_path|grep ".sh")
#  do 
#    echo "以下执行的sample是：$filename">>$path
#    sh "/home/sensetime/sample/st_face-1.1.1-liveness_professional-linux-087440c/samples/c++/"$filename >>$path 2>&1
#    echo "-------------------------------\n">>$path
#  done
#exit
 
for each_license in $( ls $license_path)
do 
find $sample_path -name "*.lic" -exec rm -f {} \;
if [ -d "$activate_folder" ];then
rm -rf $activate_folder
fi
echo "----------------------start copy license-------------------------" | tee -a $path
cp "$license_path/$each_license" "$sample_path"
echo "复制license--$each_license成功" | tee -a $path
if [ ! -f "$license_file" ];then
mv "$sample_path/$each_license" "senseid_facepro.lic"
echo "Rename License Success" | tee -a $path 
echo "执行sample" | tee -a $path
sh $sample_path/"run_sample_face_detect_1vs1.sh">>$path 2>&1
echo "-----------------------------------------------------------------">>$path
else
sh $sample_path/"run_sample_face_detect_1vs1.sh">>$path 2>&1
echo "-----------------------------------------------------------------">>$path
fi
done
exit
 
 


