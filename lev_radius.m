%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Software: Yeast Radius - IEB-UFSC                                       %
% Guilherme Brasil Pintarelli - guipintarelli@gmail.com - 04/04/2018      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
clc;
%img = imread('teste.png');
img = imread('lev_full.png');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% red = img(:,:,1); green = img(:,:,2); blue = img(:,:,3); % RGB Channels
a = zeros(size(img, 1), size(img, 2));
% just_red = cat(3, red, a, a); just_green = cat(3, a, green, a); just_blue = cat(3, a, a, blue);
% back_to_original_img = cat(3, red, green, blue);
gray_image = rgb2gray(img);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BW = gray_image < 160; %83 EDIT HERE THRESHOLD!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%BW = im2bw(img,0.3);
%BW = imbinarize(gray_image);
figure; imshow(BW); title('Binary');
BW_filtered = bwareaopen(BW,300); % remove all object containing fewer than 150 pixels!!!!!!!!!!!!!!!!!!!!!!!!
figure; imshow(BW_filtered); title('Binary Filtered');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[centers, radii, metric] = imfindcircles(BW_filtered,[15 30]); % Find circle

n_count_max = 783;
centersStrong = centers(1:n_count_max,:); 
radiiStrong = radii(1:n_count_max);
metricStrong = metric(1:n_count_max);

viscircles(centersStrong, radiiStrong,'EdgeColor','b');
% 1 pixel = 189,4 nm
radiiStrong_real = radiiStrong*189.4e-9;
figure; histfit(radiiStrong_real,20,'kernel') %ou normal

figure; boxplot(radiiStrong_real);
std = std(radiiStrong_real);
mean = mean(radiiStrong_real);

median = median(radiiStrong_real);
percentile5 = prctile(radiiStrong_real,5)
percentile95 = prctile(radiiStrong_real,95)

