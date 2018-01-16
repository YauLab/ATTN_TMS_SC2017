% Author: Silvia Convento, PhD, Dept of Neuroscience, Baylor College of
% Medicine
% email address: silvia.convento@bcm.edu
% Date of creation: August 2016; % Last revision: December 2017;

%% LOCALIZATION TASK: code for analysis
% The code works for both baseline and S1 TMS data

% Upload the mat file 'TMS_ATfreqXX_LocTask_S1TMS.mat' or'TMS_ATfreqXX_LocTask_Base.mat'

% allocating space for the following column vectors

tmp_RPmt=zeros(length(ALL_BLOCKS_DATA.trialinfo),1);
RPmt=zeros(length(tmp_RPmt),1);
resp=zeros(length(tmp_RPmt),1);
Resp4type= zeros(4,4);
Acc_matrix= zeros(1,4);

%Transforming the content of ALL_BLOCKS_DATA.resp field into 1/2/3/4 for analysis
%purposes

for i = 1:length(ALL_BLOCKS_DATA.trialinfo)
    if ALL_BLOCKS_DATA.resp(i)=='r'
        RPmt(i,1)=1;
    else if ALL_BLOCKS_DATA.resp(i)=='l'
            RPmt(i,1)=2;
        else if ALL_BLOCKS_DATA.resp(i)=='b'
                RPmt(i,1)=3;
            else
                RPmt(i,1)=4;
            end
        end
    end
end

clear i 

% generating a unique matrix (infoRP) including all trial infos and
% the response vector RPmt

% ALL_BLOCKS_DATA.trialinfo:

% column1= block number;
% column2= trial number;
% column3= trial type (1==right; 2==left; 3==both; 4==none);

infoRP=[ALL_BLOCKS_DATA.trialinfo, RPmt];
 
Trial_Type=1:1:4;

% Calculating the mean accuracy [Acc_matrix] for each trial type (Right/ Left/ Both/ None)
% and resp4type matrix including the probability of each response (Right/
% Left/ Both/ None) for each trial type (Right/ Left/ Both/ None).

for h=1:max(Trial_Type)
    Int_idcs = find(infoRP(:,3)==Trial_Type(h)); %indexing trial type
    for l= 1:max(Trial_Type)
    resp = numel(find(infoRP(Int_idcs,4)==Trial_Type(l)));

    Resp4type(l,h) = (resp/numel(find(infoRP(:,3)==Trial_Type(h))));

    end
    
    Acc = numel(find(infoRP(Int_idcs,4)==infoRP(Int_idcs,3)));
    Acc_matrix(h) = (Acc/numel(find(infoRP(:,3)==Trial_Type(h))));
end


% Plotting Accuracy bar and confusion matrix

figure('units','normalized','outerposition',[0 .2 .85 .9]);
h=imagesc(Resp4type);set(gca, 'position', [.30 .10 .35 .50], 'box','off', 'TickDir','Out');%
set(gca, 'Xtick',1:4,'Ytick',1:4);
set(gca, 'YtickLabel',{'Right','Left','Both','None'},  'XtickLabel',{'Right','Left','Both','None'},'FontSize',16, 'FontWeight','bold');
yl=ylabel('Response type','FontSize',20);
xl=xlabel('Trial type','FontSize',20);
%cb=colorbar
cs=jet(100);
colormap(cs);
cb=colorbar('Ytick',[0:.25:1], 'box','off','FontSize',16, 'FontWeight','bold','Limits',[0 1]);
get(xl); set(xl,'position', [2.55585 4.91681 1]);
get(yl); set(yl, 'position', [-.18 2.51327 1.00005]);
space_pos=get(gca,'OuterPosition'); pos=get(gca,'Position');

axes('position', [pos(1), space_pos(4), pos(3), .3]);
b=bar(Acc_matrix);set(gca,'TickDir','out','box','off');
ypl= ylabel('Accuracy','FontSize',20);set(ypl, 'position', [-.18 0.614048 1.00011]); %[0.141618 0.611914 1.00011]
set(gca, 'XTick', []);
bar_pos=get(gca,'Position');bar_outpos=get(gca,'OuterPosition');
posax.pos_confmat=pos; posax.outpos_confmat=space_pos;
posax.pos_bar=bar_pos; posax.outpos_bar=bar_pos;
