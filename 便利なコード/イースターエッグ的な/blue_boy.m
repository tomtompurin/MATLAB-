%{
https://blog.tokor.org/2018/12/08/MATLAB%E8%8A%B8%E4%BA%BA%E3%81%AA%E3%82%89%E7%9F%A5%E3%81%A3%E3%81%A6%E3%81%8A%E3%81%8D%E3%81%9F%E3%81%84%E3%83%8D%E3%82%BF%E9%96%A2%E6%95%B0%E3%83%99%E3%82%B9%E3%83%885-rogy-Advent-Calendar-2018/
https://jp.mathworks.com/matlabcentral/answers/2001-what-matlab-easter-eggs-do-you-know#answer_3188
%}

clear
close all
clc
figure(1)
image

figure(2)
defImage = pow2(get(0,'DefaultImageCData'),47);
imgCell = repmat({zeros(size(defImage))},8,7);
for shift = 0:52
  imgCell{shift+1} = bitshift(defImage,shift);
end
allImages = cell2mat(imgCell.');
imshow(allImages,[min(allImages(:)) max(allImages(:))]);