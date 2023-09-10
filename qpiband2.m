clc;
clearvars;


%Load .3ds file
[FILENAME, PATH] = uigetfile('/Users/luna/Desktop/Special Investigation/Initial script to load data/....001.3ds');
[X, Y, V, Z, DATA, header, ~] = load3dsV([PATH FILENAME]);
LS = squeeze(DATA(:,:,:,6));  % extracts the average channel of the line spectrum
I = squeeze(DATA(:,:,:,1));  % extracts the average current channel

slice_index = 144;
band = [];
N = 3; % number of 2D arrays to store

figure(2);
image = LS(:,:,80);
imagesc(image)
[cx,cy,c] = improfile;

figure(3);
cx = round(cx);
cy = round(cy);
plot(cy, cx);

    

for i=1:length(V)
    value = zeros(1,length(cy));
    A = zeros(280, 280, N);
    B = zeros(280, 280, N);
    C = zeros(280, 280, N);
    Number = zeros(280, 280);
   % figure(1);
    image = LS(:,:,i);
    min1 = min(image,[],"all"); 
    image = image - min1;
 %   imagesc(image);
    figure(1);
    Y2 = fft2(image);

    for j = 1:N
        A(:, :, j) = imrotate(abs(fftshift(Y2)),120*j-120,"crop");
        Number = Number + A(:, :, j) + flip(A(:,:,j), 2) + flip(A(:,:,j), 1);
    end
    Number = Number/18;
    for j = 1:length(cy)
        value(j) = Number(cx(j), cy(j));
    end
    band = vertcat(band, value);


    imagesc(abs(Number), [0 5e-10]);
    colorbar;
    title({'Energy slice' num2str(i)})
   % pause;
end

figure(2);
imagesc(abs(band), [0 18e-10]);
title({'Slice x coord' num2str(slice_index)})
colorbar;
