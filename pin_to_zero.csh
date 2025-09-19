#!/bin/csh -f
# Run in parent directory
#2024.10.16 weiwei

  foreach directory (`ls -d merge/*/ | awk '{print $1}'`)
    cd $directory
# 设置参考点雷达坐标范围
  #  gmt grdcut unwrap.grd -R15329/15337/5207/5209 -Gtmp.grd    #ref.llh tianjin shiqu
  gmt grdcut unwrap_dsamp2.grd -R18951/18956/6158/6163 -Gtmp.grd 
    set mean = `gmt grdinfo tmp.grd -L | grep mean | awk '{print $3}'`
    echo "I am pinning unwrapped phase of $directory, which has a mean of $mean..."
    gmt grdmath unwrap_dsamp2.grd $mean SUB = unwrap_dsamp2_YC01.grd
    cd ../../
  end
