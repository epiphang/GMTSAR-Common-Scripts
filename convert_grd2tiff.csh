#!/bin/csh -f

# File: convert_grd2tiff.csh
# Author: zyz
# Date: 2025-09-20
# Description: This script converts a list of GRD files to GeoTIFF.

#####################################################
# Check input arguments
if ($#argv == 0) then
    echo ""
    echo "Usage: convert_grd_to_tiff.csh grd_list"
    echo ""
    echo "Example: convert_grd_to_tiff.csh grd_list"
    echo "          Converts GRD files listed in grd_list to GeoTIFF format"
    echo ""
    echo "Note: Ensure GMT (grdconvert) is installed and available in PATH."
    echo ""
    exit 1
endif

#####################################################
set input_list = $1

echo "Start converting GRD files to GeoTIFF format!"

# Process each file in the list
foreach date_string (`cat $input_list`)
  # Check if the .grd file exists
  set grd_file = ${date_string}"_ll.grd" # 为列表中的每个条目添加.grd扩展名
  if (-f $grd_file) then
    # Extract base filename without extension
    set base_name = `echo $grd_file | sed 's/\.grd$//'`
    set output_tiff = ${base_name}".tiff"

    echo "Converting $grd_file to $output_tiff"

    # Convert GRD to GeoTIFF using GMT's grdconvert
    # grdconvert $grd_file $output_tiff=gd:GTiff
    gdal_translate -of GTiff $grd_file $output_tiff

    # Check if conversion was successful
    if ($status == 0 && -f $output_tiff) then
      echo "Successfully created: $output_tiff"
    else
      echo "Warning: Conversion may have failed for $grd_file"
    endif
  else
    echo "File $grd_file does not exist! Skipping."
  endif
end

echo "Finished converting GRD files to GeoTIFF format!"
