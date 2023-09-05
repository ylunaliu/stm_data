clc;
clearvars;


%Load .3ds file
[FILENAME, PATH] = uigetfile('/Users/luna/Desktop/Special Investigation/Initial script to load data/....001.3ds');
[X, Y, V, Z, DATA, header, ~] = load3dsV([PATH FILENAME]);
LS = squeeze(DATA(:,:,:,6));  % extracts the average channel of the line spectrum
I = squeeze(DATA(:,:,:,1));  % extracts the average current channel

figure(1);
image = LS(:,:,130);
min = min(min(image));
image = image - min;
imagesc(image);

figure(2);
Y1 = fft2(image);
imagesc(abs(fftshift(Y1)), [0 10e-10]);
colorbar

