% Author: Silvia Convento, PhD, Dept of Neuroscience, Baylor College of
% Medicine
% email address: silvia.convento@bcm.edu
% Date of creation: August 2016; % Last revision: December 2017;

%% Experiment 2, intensity discrimination, TACTILE block: code for analysis

% Upload the mat file 'TMS_ATintXX_XXXX_TACTILE.mat'

% allocating space for the following column vectors

tmp_RPmt=zeros(length(TACTILEDATA.resp),1);
RPmt=zeros(length(tmp_RPmt),1);
resp=zeros(length(tmp_RPmt),1);
Acc_resp=zeros(length(tmp_RPmt),1);

%Transforming the content of TACTILEDATA.resp field into 1/2 for analysis
%purposes

for i= 1:length(tmp_RPmt)
    if TACTILEDATA.resp(i)=='z'
        RPmt(i)=1;
    else
        RPmt(i)=2;
    end
end

% generating a unique matrix (infoRP) including all trial infos and
% the response vector RPmt

% TACTILEDATA.trialinfo:

% column2= comparison intensity
% column4= std intensity
% column4= standard intensity
% column6 = standard interval
% column8= if 1, std intensity higher

infoRP=[TACTILEDATA.trialinfo, RPmt];
[Y,I] = sort(infoRP(:,1)); infoRP= infoRP(I,:);

% calculating subject's 'resp' probability to judge comparison > than standard
% stimulus

for i= 1:length(tmp_RPmt)
    if infoRP(i,4)==infoRP(i,6)
        resp(i)=0;
    else
        resp(i)=1;
    end
end

infoRP=[infoRP,resp];

%calculating accuracy of the response

for i=1:length(infoRP)
    if infoRP(i,5)==infoRP(i,7)
        Acc_resp(i,1)=1;
    else
        Acc_resp(i,1)=0;
    end
end

% Calculating mean accuracy
mean_acc_TACTILE_block = mean(Acc_resp);
