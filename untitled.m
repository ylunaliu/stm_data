clc;
clearvars;


%Load .3ds file
[FILENAME, PATH] = uigetfile('/Users/luna/Desktop/Special Investigation/Initial script to load data/....001.3ds');
[X, Y, V, Z, DATA, header, ~] = load3dsV([PATH FILENAME]);
LS = squeeze(DATA(:,:,:,6));  % extracts the average channel of the line spectrum
I = squeeze(DATA(:,:,:,1));  % extracts the average current channel

slice_index = 140;
band = [];
for i=1:length(V)

   % figure(1);
    image = LS(:,:,i);
    min1 = min(image,[],"all"); 
    image = image - min1;
 %   imagesc(image);
    figure(1);
    Y2 = fft2(image);

    J_0_filp1 = flip(fftshift(Y2), 2);
    J_0_filp2 = flip(fftshift(Y2), 1);

    J_60 = imrotate(abs(fftshift(Y2)),60,"crop");
    J_60_filp1 = flip(J_60, 2);
    J_60_filp2 = flip(J_60, 1);
    J_120 = imrotate(abs(fftshift(Y2)),120,"crop");
    J_120_filp1 = flip(J_120, 2);
    J_120_filp2 = flip(J_120, 1);
    J_180 = imrotate(abs(fftshift(Y2)),180,"crop");
    J_180_filp1 = flip(J_180, 2);
    J_180_filp2 = flip(J_180, 1);
    J_240 = imrotate(abs(fftshift(Y2)),240,"crop");
    J_240_filp1 = flip(J_240, 2);
    J_240_filp2 = flip(J_240, 1);
    J_300 = imrotate(abs(fftshift(Y2)),300,"crop");
    J_300_filp1 = flip(J_300, 2);
    J_300_filp2 = flip(J_300, 1);

    Image_average = (fftshift(Y2)+J_60+J_120+J_180+J_240+J_300+J_0_filp1+J_0_filp2+J_120_filp1+J_120_filp2+J_60_filp2+J_60_filp1+J_180_filp1+J_180_filp2+J_240_filp2+J_240_filp1+J_300_filp1+J_300_filp2)/18;
    
    slice = Image_average(slice_index,:);
    band = vertcat(band, slice);

    imagesc(abs(Image_average), [0 15e-10]);
    pause;
%     colorbar
    %pause
end

figure(2);
imagesc(abs(band), [0 15e-10]);
title({'Slice x coord' num2str(slice_index)})
colorbar;