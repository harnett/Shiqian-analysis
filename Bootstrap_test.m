function Bootstrap_test(ctrl_vals, exp_vals)

    %% Bootrap the dataset and do the stat. (two metrics (t-test; rank test eq))
    % Originally from Chris Deister's code and summarized by Qian
    % Chen@10/17/2019

    %% Bootrap the data set
    controlV= [1.0247	0.9822	2.0877	2.7084];  % example date1
    c21V = [8.5399	9.9661	13.2505	13.4719	10.0097];  % example date1

    dataToBSt=controlV;
    dataToBSt2=c21V;
    bReps=1000;
    tic
    clear a b
    clear bsDist
    for n=1:bReps
        a=shuffleTrialsSimp(1:numel(dataToBSt));
        b=shuffleTrialsSimp(1:numel(dataToBSt2));
        bsDist(:,n)=nanmean(dataToBSt(a))-nanmean(dataToBSt2(b));
    end
    toc
%     disp('#$#$#$#$ your are strapped #$#$#$#$')

    %% Do the Test 
    twoTail=1;     % if the data set is two-tail distribution the number is 1 . If is ono-tail distribution the number is 0.
    alphaLevel=0.05; % set the p value ? 

    if twoTail == 1
        cis=prctile(bsDist,[100*alphaLevel/2,100*(1-alphaLevel/2)]);
    elseif twoTail == 0
        cis=prctile(bsDist,[100*alphaLevel,100*(1-alphaLevel)]);
    end

    % figure,nhist(bsDist,'box')
    % hold all,plot([cis(1) cis(1)],[0 100],'k:')
    % hold all,plot([cis(2) cis(2)],[0 100],'k:')

%     H = cis(1)>0 | cis(2)<0


    %estimate p-value
    fCI=cis(2)-cis(1);
    SE=fCI/(2*1.96);
    zS=abs(mean(bsDist))/SE;
    pValEst=exp((-0.717*zS)-(0.416*(zS^2)));

    disp('*** stats ***')
%     mean(bsDist)
%     std(bsDist)
%     cis(2)-cis(1);

    pValEst
    disp('*** end stats ***')
end