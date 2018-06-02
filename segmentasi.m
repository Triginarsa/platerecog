function [ result ] = segmentasi( citra )
%SEGMENTASI Summary of this function goes here
%   Detailed explanation goes here
myFolder = 'datauji/';

filePattern = fullfile(myFolder, '*.bmp'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
for k = 1 : length(theFiles)
  baseFileName = theFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now deleting %s\n', fullFileName);
  delete(fullFileName);
end

Im6 = imresize(citra, [NaN 300]);
Im7 = imadjust(Im6,[0.7 0.8],[]);

g_max = double(max(max(Im7)));
g_min = double(min(min(Im7)));
T = round(g_max-(g_max-g_min)/3);

Im8 = double((Im7)>=T);

h = fspecial('average',3);
Im9 = imbinarize(round(filter2(h,double(Im8))));

h = fspecial('average',3);
Im10 = imclearborder(Im9, 4);
Im11 = bwmorph(Im10,'close');

%se = strel('rectangle',[2,2]);
%erosi = imerode(d,se);
%figure,
%imshow(erosi),
%title('after mean-filter');

char = regionprops(Im11,'BoundingBox', 'Area', 'Eccentricity','Centroid');

generationID = 2;
L=bwlabel(Im11,8);
siz=size(Im11);
n=max(L(:)); % number of objects

ObjCell=cell(n,1);

imageId = 1;
z = 1;
for i=1:n
      % Get the bb of the i-th object and offest by 2 pixels in all
      % directions
      char_i=ceil(char(i).BoundingBox);
      char_x=[char_i(1)-2 char_i(1)+char_i(3)+2];
      char_y=[char_i(2)-2 char_i(2)+char_i(4)+2];
      if char_x(1)<1, char_x(1)=1; end
      if char_y(1)<1, char_y(1)=1; end
      if char_x(2)>siz(2), char_x(2)=siz(2); end
      if char_y(2)>siz(1), char_y(2)=siz(1); end
      % Crop the object and write to ObjCell
      imchar=L==i;
      charfix{i}=imchar(char_y(1):char_y(2),char_x(1):char_x(2));
      
      if (char(i).Area<=2100)&&(char(i).Area>=235)&&(char(i).Eccentricity>=0.800)&&(char(i).Eccentricity<=0.990)
          img = imresize(charfix{i},[32, 16]);
          imwrite(img, ['datauji/' num2str(generationID,'%d') '_' num2str(z,'%d') '.bmp'], 'bmp');
          imageId = imageId + 1;
          cf{i} = charfix{i};
          z = z +1;
      end
end

cf = cf(~cellfun(@isempty, cf));

result = Im11;
