#!/bin/csh -f

#wei tang
# modified by weitang 20171006
# modified by Xiangjun Zhao 20240912
# geocode: convert the displacement from radar coordinate(range, azimuth) to gegraphical coordinate(longitude, latitude)

#####################################################

if ($#argv == 0) then
    echo ""
    echo "Usage: proj_disp_ra2ll.csh disp_ra.list"
    echo ""
    echo "Example: proj_disp_ra2ll.csh disp_ra.list"
    echo "			convert the displacement from radar coordinate(range, azimuth) "
    echo "			to gegraphical coordinate(longitude, latitude)"	
    echo ""
    echo ""
    exit 1
  endif
#
set intput = $1
set vel_file = vel.grd
#####################################################
echo Start geocoding cumulative displacements!
foreach fl (`cat $intput`)
  if (-f $fl".grd") then
   set disp_file = $fl".grd"
   echo Project $disp_file

   #transform to geographical lonlat
   proj_ra2ll.csh trans.dat $disp_file $fl"_ll.grd"
   
   else
     echo File $fl".grd" does not exist!
  endif
end

echo Finish geocoding cumulative displacements!

##################################################################################
echo
echo
echo 
#####################################################

#transform to geographical lonlat
proj_ra2ll.csh trans.dat $vel_file vel_ll.grd

ls 20*ll.grd | awk -F. '{print $1}' > disp_ll.list

echo Finish geocoding velocity!
