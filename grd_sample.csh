#!/bin/csh -f
#       $Id$
# wei,2024/10/15

if ($#argv != 1) then
  echo ""
  echo "Usage: mask_corr.csh list"
  echo ""
  exit 1
endif

set list = $1

# 遍历列表中的每个文件夹路径
foreach line (`cat $list`)
  # 构造完整的 grd 文件路径
  set corr_grd = "$line/corr.grd"
  set unwrap_grd = "$line/unwrap_pin.grd"
  
  # 检查文件是否存在
  if (-e $corr_grd && -e $unwrap_grd) then
    # 进入文件夹
    pushd $line
    # 执行 grdsample 操作
    gmt grdsample unwrap_pin.grd -I16/4 -Gunwrap_pin_dsamp16.grd
    gmt grdsample corr.grd -I16/4 -Gcorr_dsamp16.grd
    # 返回原始目录
    popd
  else
    echo "Error: corr.grd or unwrap.grd not found in $line"
  endif
end
