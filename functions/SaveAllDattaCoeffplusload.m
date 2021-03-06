function [ccall,labelinst,labeltype]=SaveAllDattaCoeff(name0,coeffType,T)
% -----------------------------------------------------------------
if(nargin==2)
    T=0.25;
end

%SaveAllDattaCoeff Load all the audio files in the database and calculate the mfcc or scattering coefficients
%for a given value of T,
%
%name is the full path to the database
%
%coeffType is a string indicating either 'scat' for scattering calculated to the second order or 'mfcc'
%for Mel Frequency Cepstral coefficients
%
%T is the window for which the coeffients should be calculated in seconds
%T=0.128 for 128ms
%
%!!! make sure the database dosen't contain any file other than the .wav
%files. !!!
%-------------------------------------------------------------------
ccall=[];
numbtype=-1;
numbinst=0;
labelinst=[];
labeltype=[];
instrumentstypelist = dir(fullfile(name0)); %load the nof the type of instruments
dirinstrumenttype = {instrumentstypelist.name}';
dirinstrumenttype = char(dirinstrumenttype);
size1=size(dirinstrumenttype,1);
c=0;
for i=3:size1
    
    name1=strtrim(dirinstrumenttype(i,:));
    instrumentslist = dir(fullfile(name0,name1));%load the names of the  instruments
    dirinstruments= {instrumentslist.name}';
    dirinstruments = char(dirinstruments);
    size2=size(dirinstruments,1);
    
    for k=3:size2
        numbtype=numbtype+1;
        numbinst=numbinst+1;
        name2=strtrim(dirinstruments(k,:));
        TypeOfPlay = dir(fullfile(name0,name1,name2));%load the names of type of play for each instrument
        dirTypeOfPlay= {TypeOfPlay.name}';
        dirTypeOfPlay = char(dirTypeOfPlay);
        size3=size(dirTypeOfPlay,1);
        
        for m=3:size3
            numbtype=numbtype+1;
            
            name3=strtrim(dirTypeOfPlay(m,:));
            if(name3(1:3)~='.DS')
                wavFileDirectory=fullfile(name0,name1,name2,name3)
                
                WavFiles = dir(wavFileDirectory);%load all the wav files in the directory
                dirWavFiles={WavFiles.name}';
                dirWavFiles = char(dirWavFiles);
                nameOfWavFile=strtrim(dirWavFiles(3,:));
                [pathstr,name,ext] = fileparts(nameOfWavFile);
                
                
                if(strcmp(ext,'.wav'))
                    if(coeffType=='scat')
                        ccm= scatteringSave(wavFileDirectory,T);
                        ccall=[ccall;ccm];
                        sizesde=size(ccm);
                        for l=1:sizesde(1)
                            labelinst=[labelinst ;numbinst];
                        end
                        for l=1:sizesde(1)
                            labeltype=[labeltype ;numbtype];
                        end
                        
                    end
                    if(coeffType=='mfcc')
                        ccm=  mfccSave(wavFileDirectory);
                        ccall=[ccall;ccm];
                        sizesde=size(ccm);
                        for l=1:sizesde(1)
                            labelinst=[labelinst ;numbinst];
                        end
                        for l=1:sizesde(1)
                            labeltype=[labeltype ;numbtype];
                        end
                    end
                    
                    
                end
                
                
            end
        end
    end
    
end



