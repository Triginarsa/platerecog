function [ citra, proses_detail ] = preprocessing(citra_asli)
%OPEN_IMAGE Summary of this function goes here
%   Detailed explanation goes here

grayscale = rgb2gray(citra_asli); 

%histogram_grayscale = imhist(grayscale);

enhanced_image = imadjust(grayscale,[0.2,0.8],[0,1]);

a = figure;
set(a, 'Visible', 'off');
subplot(1,2,1),
imshow(enhanced_image);
title('enhanced graylevel');

subplot(1,2,2),
imhist(enhanced_image);
title('histogram');

savefig('enhanced_graylevel.fig');

se = [1;1;1];
eroded_image = imerode(grayscale,se);

b = figure;
set(b, 'Visible', 'off');
imshow(eroded_image);
title('Citra Erosi');

savefig('eroded_image.fig');

se = strel('rectangle',[25,25]);
closed_image = imclose(eroded_image ,se);

c = figure;
set(c, 'Visible', 'off');
imshow(closed_image);
title('Citra Closing');

savefig('closed_image.fig');

noise_reduced_image = double((closed_image)>220);               
noise_reduced_image = bwareaopen(noise_reduced_image,2000);
se = strel('rectangle',[5,5]);

noise_reduced_image = imdilate(noise_reduced_image,se);

d = figure;
set(d, 'Visible', 'off');
imshow(noise_reduced_image);
title('Pengurangan Noise');

savefig('noise_reduced.fig');

S = regionprops(noise_reduced_image,'BoundingBox', 'ConvexArea', 'Eccentricity', 'Area');

[~,idx]=sort([S.Area]);

S = S(idx);

e = figure;
set(e, 'Visible', 'off');
imshow(noise_reduced_image);
title('Pencarian Plat');

hold on ;
for i=1:size(S,1)
    if ((S(i).BoundingBox(3)>S(i).BoundingBox(4))&&(S(i).Eccentricity>=0.8700)&&(S(i).Eccentricity<=0.9550))
        rectangle('Position', S(i).BoundingBox,'edgecolor','green');
        Plat = S(i).BoundingBox;
    end
end

savefig('plate.fig');

siz = size(noise_reduced_image);

Plat_x = [Plat(1)+5 Plat(1)+Plat(3)-5];
Plat_y = [Plat(2)+5 Plat(2)+Plat(4)-5];

if Plat_x(1)<1, Plat_x(1)=1; end
if Plat_y(1)<1, Plat_y(1)=1; end
if Plat_x(2)>siz(2), Plat_x(2)=siz(2); end
if Plat_y(2)>siz(1), Plat_y(2)=siz(1); end

im = grayscale;
result = im(Plat_y(1):Plat_y(2),Plat_x(1):Plat_x(2));

citra         = result;
proses_detail = {
    'enhanced_graylevel.fig', ...
    'eroded_image.fig', ...
    'closed_image.fig', ...
    'noise_reduced.fig', ...
    'plate.fig'};