clc;
clearvars;


%Load .3ds file
[FILENAME, PATH] = uigetfile('/Users/luna/Desktop/Special Investigation/Initial script to load data/....001.3ds');
[X, Y, V, Z, DATA, header, ~] = load3dsV([PATH FILENAME]);
LS = squeeze(DATA(:,:,:,6));  % extracts the average channel of the line spectrum
I = squeeze(DATA(:,:,:,1));  % extracts the average current channel



%make figure of the DOS plots
for i = 1:length(V)
      figure(1);
      DIDV = LS(:,:,i);
      imagesc(DIDV);
      title({'dI/dV', num2str(V(i)), 'meV'})
      pause
end

figure(2);
image = LS(:,:,80);
imagesc(image)
[cx,cy,c] = improfile;

figure(3);
cx = round(cx);
cy = round(cy);
plot(cy, cx);

for i= 1:length(c)
        figure(4)
        DOS_xy = LS(round(cx(i)), round(cy(i)), :);
        DOS_xy = reshape(DOS_xy, 1, []);
        plot(V, DOS_xy);
        title({'dI/dV vs Energy'})
        xlabel("Energy (MeV)")
        ylabel("dI/dV")
        hold on;
end
    

% Create a loop for interactive linecut selection




    %Save the coordinattes and pixel values to linecutData
%Making dI/dV spectrum
%x = 150;
%y = 150;

%DOS_xy = LS(x,y,:);
%DOS_xy =reshape(DOS_xy, 1, []);
% V= reshape(V, 1, []);
%figure();
%plot(V, DOS_xy)
