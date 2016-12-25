#!/bin/bash

root_dir=/path/to/project/;

mlx_script=${root_dir}/path/to/scripts/xxxxxxxx.mlx
shapes_in_dir=${root_dir}/path/to/data_in
shapes_out_dir=${root_dir}/path/to/data_out

mkdir -p $shapes_out_dir
cd $shapes_in_dir

for i in $( ls ); 
do
	echo Downsampling shape $i
	meshlabserver -i $shapes_in_dir"/"$i -o $shapes_out_dir"/"$i -s $mlx_script
done
