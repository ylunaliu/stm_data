%Rotation
clc;
clearvars;


%Load .3ds file
[FILENAME, PATH] = uigetfile('/Users/luna/Desktop/Special Investigation/Initial script to load data/....001.3ds');
[X, Y, V, Z, DATA, header, ~] = load3dsV([PATH FILENAME]);
LS = squeeze(DATA(:,:,:,6));  % extracts the average channel of the line spectrum
I = squeeze(DATA(:,:,:,1));  % extracts the average current channel


image = LS(:,:,70);
min1 = min(image,[],"all"); 
image = image - min1;
FFT_image = fft2(image);
figure(1);
imagesc(abs(fftshift(FFT_image)), [0 15e-10]);
colorbar;

J_60 = imrotate(abs(fftshift(FFT_image)),60,"crop");
J_120 = imrotate(abs(fftshift(FFT_image)),120,"crop");
J_180 = imrotate(abs(fftshift(FFT_image)),180,"crop");
J_240 = imrotate(abs(fftshift(FFT_image)),240,"crop");
J_300 = imrotate(abs(fftshift(FFT_image)),300,"crop");

Image_average = (fftshift(FFT_image)+J_60+J_120+J_180+J_240+J_300)/6;
figure(2);
imagesc(abs(Image_average), [0 15e-10]);
colorbar;

savefig("average_data.fig")
