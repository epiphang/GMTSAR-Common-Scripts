#!/bin/csh -f
# unwarp_corr_cut.csh
# intflist contains a list of all date1_date2 directories.
# 使用直接指定的坐标范围进行裁剪，替代原参考网格文件方式
# 在intf_all/merge路径下使用，运行  ./unwarp_corr_cut.csh intflist

set intfile = $1

# === 设置裁剪区域的雷达坐标范围 ===
# 将示例坐标替换为雷达坐标系下的实际坐标范围
# 格式：最小距离向/最大距离向/最小方位向/最大方位向
# 使用 grdinfo corr.grd 查看原始文件的雷达坐标范围
set crop_region = "10000/20000/1000/3000"  # x轴y轴

foreach line (`awk '{print $1}' $intfile`)
  cd $line
  echo "cutting $line with radar coordinates: $crop_region"
  
  # 使用雷达坐标范围进行裁剪
  gmt grdcut corr.grd -R$crop_region -Gcorr_cut.grd
  gmt grdcut unwrap.grd -R$crop_region -Gunwrap_cut.grd
  
# 如果进行了GACOS处理，需要裁剪nwrap_gacos_corrected_detrended.grd文件
# gmt grdcut unwrap_gacos_corrected_detrended.grd -R$crop_region -Gunwrap_gacos_cut.grd
  
  cd ..
  echo "finish cutting $line"
end
