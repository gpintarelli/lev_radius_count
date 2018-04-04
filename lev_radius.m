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

n_count_max = 700;
centersStrong = centers(1:n_count_max,:); 
radiiStrong = radii(1:n_count_max);
metricStrong = metric(1:n_count_max);

viscircles(centersStrong, radiiStrong,'EdgeColor','b');

% 1 pixel = 189,4 nm

radiiStrong_real = radiiStrong*189.4e-9;


figure; histfit(radiiStrong_real);

% [B,L] = bwboundaries(BW_filtered,'noholes');
% 
% figure;imshow(label2rgb(L, @jet, [.5 .5 .5]))% Display the label matrix and draw each boundary
% hold on
% for k = 1:length(B)
%   boundary = B{k};
%     plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% stats = regionprops(L,gray_image,'Area','Centroid','MeanIntensity'); % Table of the objects create
% figure;imshow(img); % DEBUG HERE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% threshold_circle = 0.05; % Ajust the circle tolerance
% loop over the boundaries
% for k = 1:length(B)
%   boundary = B{k}; % obtain (X,Y) boundary coordinates corresponding to label 'k'
%   obj_area = stats(k).Area;  % obtain the area calculation corresponding to label 'k'
%   obj_area = obj_area/58000; % Calibrate HERE: 58000px = 1cm²
%   obj_area_string = sprintf('%2.2f',obj_area);  % Prepare string to display the results
%   obj_grey_scale_mean = stats(k).MeanIntensity;
%   obj_grey_scale_mean = 1/obj_grey_scale_mean*6500; % Calibrate colour HERE!!!!!!!!!!!!!!!!!!!!!!!!
%   obj_grey_scale_mean_string = sprintf('%2.2f',obj_grey_scale_mean); 
%   
%   delta_sq = diff(boundary).^2;           % Compute a simple estimate of the object's perimeter
%   perimeter = sum(sqrt(sum(delta_sq,2))); % 
% 
%   area = stats(k).Area;  % Obtain the area calculation corresponding to label 'k'
% 
% 
%   metric = 4*pi*area/perimeter^2;  % Compute the roundness metric
% 
%   % display the results
%   obj_circle_string = sprintf('%2.2f',metric);
% 
%   % mark objects above the threshold with a black circle
%   if metric > threshold_circle
%       %if obj_grey_scale_mean < 100 % EDIT COLOUR THRESHOLD HERE !!!!!!!!!!!!!!!!!!!
%     centroid = stats(k).Centroid;
%     plot(centroid(1),centroid(2),'ro');
%  %   text(boundary(1,2)-80,boundary(1,1)-13,['Obj2Circle Ratio: ' obj_circle_string],'Color','y','FontSize',8,'FontWeight','bold');
%     text(boundary(1,2)+150,boundary(1,1)+30,['A: ' obj_area_string 'cm²'],'Color','b','FontSize',4,'FontWeight','bold');
%     %text(boundary(1,2)+150,boundary(1,1)+150,['Strength: ' obj_grey_scale_mean_string '%'],'Color','r','FontSize',8,'FontWeight','bold');
%       %end
%   end
% 
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







% sobel_img = edge(gray_image,'sobel');
% figure; imshow(sobel_img), title('Sobel Filter')


% FONTES:
% http://www.mathworks.com/help/images/examples/identifying-round-objects.html
%
%
%




