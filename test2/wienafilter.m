clear;  
close all;  
clc  
%读取图片
I = im2double(imread('D:\workstation\1020\2.png'));
figure,subplot(4,4,1),imshow(I);
title('Original Image');
noise = imnoise(zeros(size(I)),'gaussian',0,0.0001);
 
%模拟运动模糊
LEN = 21;
THETA = 11;
PSF = fspecial('motion', LEN, THETA);
blurred = imfilter(I, PSF, 'circular');
subplot(4,4,2),imshow(blurred);
title('Blurred Image');
 
%模拟运动噪声
g = I + noise;
subplot(4,4,3),imshow(g);
title('noise image');
 
%模拟模糊和滤波
bg = blurred + noise;
subplot(4,4,4),imshow(bg)
title('Blur and Noise image')
 
%恢复图像
wnr11 = deconvwnr(I, PSF);%信噪比为零
subplot(4,4,5),imshow(wnr11);
title('Original Image、S/N=0');
 
wnr12 = deconvwnr(blurred, PSF);%信噪比为零
subplot(4,4,6),imshow(wnr12);
title('blurred Image、S/N=0');
 
wnr13 = deconvwnr(g, PSF);%信噪比为零
subplot(4,4,7),imshow(wnr13);
title('noise Image、S/N=0');
 
wnr14 = deconvwnr(bg, PSF);%信噪比为零
subplot(4,4,8),imshow(wnr14);
title('blur and noise Image、S/N=0');
 
Sn = abs(fft2(noise)).^2;
nA = sum(Sn(:))/prod(size(noise));
SI = abs(fft2(I)).^2;
IA = sum(SI(:))/prod(size(I));
R = nA/IA;
 
wnr21 = deconvwnr(I,PSF,R);%噪信比已知 R
subplot(4,4,9),imshow(wnr21);
title('Original Image、N/S=R');
 
wnr22 = deconvwnr(blurred,PSF,R);%噪信比已知 R
subplot(4,4,10),imshow(wnr22);
title('blurred Image、N/S=R');
 
wnr23 = deconvwnr(g,PSF,R);%噪信比已知 R
subplot(4,4,11),imshow(wnr23);
title('noise Image、N/S=R');
 
wnr24 = deconvwnr(bg,PSF,R);%噪信比已知 R
subplot(4,4,12),imshow(wnr24);
title('blur and noise Image、N/S=R');
 
NCORR = fftshift(real(ifft2(Sn)));%自相关函数
ICORR = fftshift(real(ifft2(SI)));
 
wnr31 = deconvwnr(I,PSF,NCORR,ICORR);%自相关函数
subplot(4,4,13),imshow(wnr31);
title('Original Image、自相关函数');
 
wnr32 = deconvwnr(blurred,PSF,NCORR,ICORR);%自相关函数
subplot(4,4,14),imshow(wnr32);
title('blurred Image、自相关函数');
 
wnr33 = deconvwnr(g,PSF,NCORR,ICORR);%自相关函数
subplot(4,4,15),imshow(wnr33);
title('noise Image、自相关函数');
 
wnr34 = deconvwnr(bg,PSF,NCORR,ICORR);%自相关函数
subplot(4,4,16),imshow(wnr34);
title('blur and noise Image、自相关函数');
