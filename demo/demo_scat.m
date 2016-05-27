SaveAllDataCoeff('Sol_0.9_HQ','scat','0.25') %Calculate all the scat for Ts=250ms files and save them in different folders with similar structure to the original database.
LoadAllIntoOne('scat',0.25)%load all the files into one .mat file with labels based on mode of play or based on instrument playing.


dx=pdist(cc2);
dx=squareform(dx);
resav=rankingMetrics(dx,labelinst);%calculate the ranking metrics for the scatering

ccf=ScatStdMedian('scat',0.25);%calculate the variance and keep the ones that cumulate a sum less than 83% and give the result of ranking metrics

[L,Det]=lmnnCG(cc2',labelinst',5,'maxiter',1000); %this lmnn here is calculated on the raw data we can apply it on the data after transformation by scatstdmedian by replacing cc2 by ccf

dx=pdist((L*cc2')');
dx=squareform(dx);
resav=rankingMetrics(dx,labelinst);%calculate the mfcc after lmnn