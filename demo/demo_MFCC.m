SaveAllDataCoeff('Sol_0.9_HQ','mfcc') %Calculate all the mfcc files and save them in different folders with similar structure to the original database.
LoadAllIntoOne('mfcc')%load all the files into one .mat file with labels based on mode of play or based on instrument playing.


dx=pdist(cc2);
dx=squareform(dx);
resav=rankingMetrics(dx,labelinst);%calculate the ranking metrics for the mfcc

calculatemedian('mfcc');%calculate the variance and keep the ones that cumulate a sum less than 83% and give the result of ranking metrics

[L,Det]=lmnnCG(cc2',labelinst',5,'maxiter',1000); 

dx=pdist((L*cc2')');
dx=squareform(dx);
resav=rankingMetrics(dx,labelinst);%calculate the mfcc after lmnn