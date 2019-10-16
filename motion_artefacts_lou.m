clear all;close all;

[sbxName, sbxPath] = uigetfile('.sbx', 'Please select file containing imaging data.');
sbxName = strtok(sbxName, '.');

load([sbxPath, sbxName, '.rigid'], '-mat', 'phaseDifferences', 'rowShifts', 'columnShifts', 'frameCrop');
% load([sbxPath, sbxName, '.align'], '-mat', 'phaseDifferences', 'rowShifts', 'columnShifts', 'frameCrop');

  Info = sbxInfo([sbxPath, sbxName])

%%
table=[rowShifts' [0; diff(rowShifts')] columnShifts' [0; diff(columnShifts')]];
thresh=[10 10 10 10];
badframes1=find(table(:,1)>thresh(1) | table(:,1)<-thresh(2));
badframes2=find(table(:,3)>thresh(3) | table(:,3)<-thresh(4));
% yo=ismember(badframes1,badframes2);
yo=[badframes1;badframes2]
badframes=unique(yo)


%%
newrowShifts=rowShifts;
newcolumnShifts=columnShifts;
newrowShifts(badframes)=nan;
newcolumnShifts(badframes)=nan;

for i=1:length(badframes)
    kk=badframes(i);
    
    temp=newrowShifts(kk-1:kk+1)
    temp=nanmean(temp)
    if temp<0
    temp=ceil(temp);
    else
        temp=floor(temp);
    end
    newrowShifts(kk)=temp;
    
    temp=newcolumnShifts(kk-1:kk+1)
    temp=nanmean(temp)
    if temp<0
    temp=ceil(temp);
    else
        temp=floor(temp);
    end
    newcolumnShifts(kk)=temp;
           
end
figure;
subplot(2,1,1);hold on
plot(rowShifts,'k');hold on;plot(newrowShifts,'r')

subplot(2,1,2);hold on
plot(columnShifts,'k');hold on;plot(newcolumnShifts,'r')



subplot(2,1,1);hold on
plot(badframes,max(max(table(:,[1 3]))),'o','Color','b')
subplot(2,1,2);hold on
plot(badframes,max(max(table(:,[1 3]))),'o','Color','b')


%%
% randomsequence=[6000:6100]
for i=1:length(badframes)
 kk=badframes(i);


avg_pre=[];
for prekk=[-10:1:-1]+kk
    temp_frame = sbxRead(Info,prekk);
    temp_frame=temp_frame(1+frameCrop(3):end-frameCrop(4),1+frameCrop(1):end-frameCrop(2));
    temp_frame=temp_frame([100:end-100]+newcolumnShifts(prekk),[100:end-100]+newrowShifts(prekk));
    temp_frame=double(temp_frame);
    if isempty(avg_pre)
        avg_pre=[temp_frame];
    else
        avg_pre=avg_pre+temp_frame;
    end
end
temp=avg_pre;

frame = sbxRead(Info, kk);
frame=frame(1+frameCrop(3):end-frameCrop(4),1+frameCrop(1):end-frameCrop(2));
frame=frame([100:end-100]+newcolumnShifts(kk),[100:end-100]+newrowShifts(kk));
frame=double(frame);

Iblur3 = imgaussfilt(frame,1);

temp=temp./max(max(temp));
Iblur3=Iblur3./max(max(Iblur3));


if i==1
figure('Position',[00 50 1800 900],'Name', 'Screening ROIs', 'Units', 'normalized', 'Color', 'w');

subplot(2,2,1)
imshow(temp)
axis on

subplot(2,2,2)
imshow(Iblur3)
axis on

subplot(2,2,3)
C = imfuse(temp,Iblur3,'falsecolor','Scaling','joint','ColorChannels',[1 0 2]);
imshow(C)
axis on


newlim=input('axis limtits')
else


subplot(2,2,1)
imshow(temp)
axis on
xlim([newlim(1) newlim(2)])
ylim([newlim(3) newlim(4)])

subplot(2,2,2)
imshow(Iblur3)
axis on
xlim([newlim(1) newlim(2)])
ylim([newlim(3) newlim(4)])

subplot(2,2,3)
C = imfuse(temp,Iblur3,'falsecolor','Scaling','joint','ColorChannels',[1 0 2]);
imshow(C)
axis on
xlim([newlim(1) newlim(2)])
ylim([newlim(3) newlim(4)])

yoyo=input('enter to accept')

while ~isempty(yoyo)
    x_y_offset=input('Enter x and y offsets');
    newrowShifts(kk)=newrowShifts(kk)-x_y_offset(1)
    newcolumnShifts(kk)=newcolumnShifts(kk)-x_y_offset(2)
    frame = sbxRead(Info, kk);
frame=frame(1+frameCrop(3):end-frameCrop(4),1+frameCrop(1):end-frameCrop(2));
frame=frame([100:end-100]+newcolumnShifts(kk),[100:end-100]+newrowShifts(kk));
frame=double(frame);
Iblur3 = imgaussfilt(frame,1);
temp=temp./max(max(temp));
Iblur3=Iblur3./max(max(Iblur3));

    subplot(2,2,1)
imshow(temp)
axis on
xlim([newlim(1) newlim(2)])
ylim([newlim(3) newlim(4)])

subplot(2,2,2)
imshow(Iblur3)
axis on
xlim([newlim(1) newlim(2)])
ylim([newlim(3) newlim(4)])

subplot(2,2,3)
C = imfuse(temp,Iblur3,'falsecolor','Scaling','joint','ColorChannels',[1 0 2]);
imshow(C)
axis on
xlim([newlim(1) newlim(2)])
ylim([newlim(3) newlim(4)])

yoyo=input('enter to accept')
end

end
end

%% save new offsets
yoyo=input('Enter to save')
if isempty(yoyo)
columnShifts=newcolumnShifts;
rowShifts=newrowShifts;
cd(sbxPath)
save([sbxName, '.rigid'], '-mat', 'phaseDifferences', 'rowShifts', 'columnShifts', 'frameCrop');
end

disp('Delete .pre file and reprocess data if already preprocess')