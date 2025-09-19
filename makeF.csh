#!/bin/csh -f
# MAKEF1_F2_F3.csh - 创建 F1, F2, F3 目录结构
# Yizhan Zhao 20250916

# 处理 F1 目录
echo "处理目录: F1"
mkdir F1
cd F1
mkdir topo
mkdir raw
cd raw
ln -s ../../topo/dem.grd .
ln -s ../../data/F*_F*/*.SAFE/*/*iw1*vv*xml .
ln -s ../../data/F*_F*/*.SAFE/*/*iw1*vv*tiff .
ln -s ../../data/*EOF .
cd ../topo
ln -s ../../topo/dem.grd .
cd ../..
echo "F1 完成"

# 处理 F2 目录
echo "处理目录: F2"
mkdir F2
cd F2
mkdir topo
mkdir raw
cd raw
ln -s ../../topo/dem.grd .
ln -s ../../data/F*_F*/*.SAFE/*/*iw2*vv*xml .
ln -s ../../data/F*_F*/*.SAFE/*/*iw2*vv*tiff .
ln -s ../../data/*EOF .
cd ../topo
ln -s ../../topo/dem.grd .
cd ../..
echo "F2 完成"

# 处理 F3 目录
echo "处理目录: F3"
mkdir F3
cd F3
mkdir topo
mkdir raw
cd raw
ln -s ../../topo/dem.grd .
ln -s ../../data/F*_F*/*.SAFE/*/*iw3*vv*xml .
ln -s ../../data/F*_F*/*.SAFE/*/*iw3*vv*tiff .
ln -s ../../data/*EOF .
cd ../topo
ln -s ../../topo/dem.grd .
cd ../..
echo "F3 完成"

echo "所有目录处理完成！Success!"
