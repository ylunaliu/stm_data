clc;
clearvars;


%Load .3ds file
[FILENAME, PATH] = uigetfile('/Users/luna/Desktop/Special Investigation/Initial script to load data/....001.3ds');
[X, Y, V, Z, DATA, header, ~] = load3dsV([PATH FILENAME]);
LS = squeeze(DATA(:,:,:,6));  % extracts the average channel of the line spectrum
I = squeeze(DATA(:,:,:,1));  % extracts the average current channel

N = 6; % number of 2D arrays to store
A = zeros(280, 280, N);
B = zeros(280, 280, N);
C = zeros(280, 280, N);

image = LS(:,:,120);
min1 = min(image,[],"all"); 
image = image - min1;
Y2 = fft2(image);
start_index = 60;
Number = zeros(280, 280);


%rotation
for i = 1:N
    A(:, :, i) = imrotate(abs(fftshift(Y2)),60*i-60,"crop");
   % B(:, :, i) = flip(A(:,:,i), 2);
   % C(:, :, i) = flip(A(:,:,i), 1);
    Number = Number + A(:, :, i) + flip(A(:,:,i), 2) + flip(A(:,:,i), 1);
end

Number = Number/18;

figure(3);
imagesc(abs(Number), [0 15e-10]);

%New_matrice = cat(3, A, B, C) %matrix stores all the frames
