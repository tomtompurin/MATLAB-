function [loss, figH1, figH2] = checkClassificationPerformance(method)

% データ読み込み
s = load('fisheriris.mat');
X = s.meas(:,3:4);
Y = categorical(s.species);

switch method
    case 'fitcnb' % ナイーブベイズ
        Mdl = fitcnb(X,Y,...
            'ClassNames',{'setosa','versicolor','virginica'});
    case 'fitcsvm' % サポートベクタマシン
        Mdl = fitcecoc(X,Y,...
            'ClassNames',{'setosa','versicolor','virginica'});
    case 'fitctree' % 決定木
        Mdl = fitctree(X,Y,...
            'ClassNames',{'setosa','versicolor','virginica'});
    case 'fitcknn' % ｋ近傍法
        Mdl = fitcknn(X,Y,...
            'ClassNames',{'setosa','versicolor','virginica'});
    otherwise
        disp('not recognized');
end

% 交差検証済み (分割された) モデルを作成
CVMdl = crossval(Mdl,'KFold',5);
loss = kfoldLoss(CVMdl);
predictedLabels = kfoldPredict(CVMdl);

figH1 = figure(1); % 混同行列
cm = confusionchart(Y,categorical(predictedLabels));
cm.FontSize = 15;

figH2 = figure(2); % 散布図プロット
idx = Y == predictedLabels;
gscatter(X(~idx,1),X(~idx,2),Y(~idx),'rgb','x',8,'on');
hold on
gscatter(X(idx,1),X(idx,2),Y(idx),'rgb','.',18,'on');
hold off
title('Fisher''s Iris Data','FontSize',15);
xlabel('Petal Length (cm)','FontSize',13);
ylabel('Petal Width (cm)','FontSize',13);

grid on