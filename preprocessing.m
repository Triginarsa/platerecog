clear 
close all
clc
I=imread('plat.jpg');
figure,
imshow(I);
title('Citra Asli');

%proses grayscale
img_gray = rgb2gray(I); 
figure(2),
subplot(1,2,1),
imshow(img_gray); 
title('grayscale');
figure(2),
subplot(1,2,2),
%Menampilkan Histogram
imhist(img_gray);
title('histogram');

%penambahan kontras
img_gray2 = imadjust(img_gray,[0.2,0.8],[0,1]);
figure(3),
subplot(1,2,1),
imshow(img_gray2);
title('Penambahan Kontras');
figure(3),
subplot(1,2,2),
%Menampilkan Histogram
imhist(img_gray2);
title('histogram');

%deteksi Tepi
img_dt = edge(img_gray2,'sobel',0.15,'both');
figure(4),
imshow(img_dt);
title('Deteksi Tepi');

%erosi
se = [1;1;1];
img_erosi = imerode(img_gray2,se);
figure(5),
imshow(img_erosi);
title('Citra Hasil Erosi');
se = strel('rectangle',[25,25]);

%closing(menjadi lebih halus)
img_closing = imclose(img_erosi,se);
figure(6),
imshow(img_closing);
title('Image Closing');
                        
%pengurangan Noise
img_lessnoise = double((img_closing)>230);               
img_lessnoise = bwareaopen(img_lessnoise,2000);
figure(7),
imshow(img_lessnoise);
title('Pengurangan Noise');

[y,x,z] = size(img_lessnoise);
Im7 = double(img_lessnoise);
Blue_y = zeros(y,1);
for i = 1:y
    for j = 1:x
        if (Im7(i,j,1) == 1)
            Blue_y(i,1) = Blue_y(i,1) + 1;
        end
    end
end
[temp,MaxY] = max(Blue_y);
PY1 = MaxY;
while ((Blue_y(PY1,1)>=5)&&(PY1>1))
    PY1 = PY1 - 1;
end
PY2 = MaxY;
while ((Blue_y(PY2,1)>=5)&&(PY2<y))
    PY2 = PY2 + 1;
end
IY = I(PY1:PY2,:,:);
Blue_x = zeros(1,x);
for j = 1:x
    for i = PY1:PY2
        if(Im7(i,j,1) == 1)
            Blue_x(1,j) = Blue_x(1,j) + 1;
        end
    end
end
PX1 = 1;
while ((Blue_x(1,PX1)<5)&&(PX1<x))
    PX1 = PX1 + 1;
end
PX2 = x;
while ((Blue_x(1,PX2)<5)&&(PX2>PX1))
    PX2 = PX2 - 1;
end
%PX1 = PX1 - 1;
%PX2 = PX2 + 1; 
PY = PY2 - PY1;
PX = PX2 - PX1;
%dw = I(PY1+fix(PY/3):PY2-fix(PY/6),PX1+fix(PX/12):PX2-fix(PX/12),:);  %for plate1.jpg
dw = I(PY1:PY2,PX1:PX2,:);                 %for plate4.png/car1.jpg/car2.bmp
figure(8),
subplot(1,2,1),
imshow(IY),
title('horizontal shearing');
figure(8),
subplot(1,2,2),
imshow(dw),
title('vertical shearing');

%imwrite(dw,'dw.jpg');
%a = imread('dw.jpg');
b = rgb2gray(dw);
%imwrite(b,'gray-level image');
figure(9),
subplot(2,2,1),
imshow(b),
title('gray-level image');
g_max = double(max(max(b)));
g_min = double(min(min(b)));
T = round(g_max-(g_max-g_min)/3);
%[m,n] = size(b);
d = double((b)>=T);
%imwrite(d,'binary image.jpg');
figure(9),
subplot(2,2,2),
imshow(d),
title('binary image');
h = fspecial('average',3);
d = im2bw(round(filter2(h,d)));
%imwrite(d,'after mean-filter');
figure(9),
subplot(2,2,3),
imshow(d),
title('after mean-filter');
%[m,n] = size(d);
% se2 = eye(2);
% if bwarea(d)/m/n >= 0.365
%     d = imerode(d,se);
% elseif bwarea(d)/m/n <=0.235
%     d = imdilate(d,se);
% end
% figure(9),
% subplot(2,2,4),
% imshow(d),
% title('after corrosion or expansion');

e=cutting(d);
subplot(2,2,4),
imshow(e),
title('edge cutting');
