
%Load .sxm file
[FILENAME,PATH]= uigetfile('/Users/luna/Desktop/Special Investigation/Initial script to load data/Ni-doped_FGT_23_08_08_0007.sxm');
[header, data] = loadsxm([PATH,FILENAME],'Z');
xvalues=linspace(0,header.scan_range(1),size(data,2));
yvalues=linspace(0,header.scan_range(2),size(data,1));
%%
data = data - mean(data);
fftdata = fft2(data);
figure(1);
imagesc(abs(fftshift(fftdata)),[0 15e-10])

