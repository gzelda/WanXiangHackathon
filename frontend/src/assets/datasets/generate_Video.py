#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 2019/2/19 16:42
# @Author  : xiaodai
# -*- coding: UTF-8 -*-


path = r'/Users/Gavin/Desktop/WanXiangHackathon/frontend/src/assets/datasets/output0'



import os
import cv2

img_root = '/Users/Gavin/Desktop/WanXiangHackathon/frontend/src/assets/datasets/output0/'#这里写你的文件夹路径，比如：/home/youname/data/img/,注意最后一个文件夹要有斜杠
fps = 30    #保存视频的FPS，可以适当调整
print(cv2)
#可以用(*'DVIX')或(*'X264'),如果都不行先装ffmepg: sudo apt-get install ffmepg
fourcc = cv2.VideoWriter_fourcc(*'mp4v')
videoWriter = cv2.VideoWriter('saveVideo.mp4',fourcc,fps,(600,400))#最后一个是保存图片的尺寸

for i in range(3573):
    name = img_root+'00'+str(i+3798)+'_rgb'+'.png'
    #print(name)
    frame = cv2.imread(name)
    #print(img_root+'00'+str(i+3798)+'_rgb'+'.png')
    #print(frame)
    videoWriter.write(frame)
videoWriter.release()

