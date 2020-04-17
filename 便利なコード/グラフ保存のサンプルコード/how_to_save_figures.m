%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% date:2020/04/09
% author:Yuta Tomiyoshi
% explanation:This program shows how to save figures 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% まずはsaveasについて
fignum=1; % figureの番号を管理するためのもの
figure(fignum) % 
x = [2 4 7 2 4 5 2 5 1 4];
bar(x); % 棒グラフを作成
saveas(gcf,'Barchart1.png') 
% 現在のfigureを'Barchart.png'という名前で保存(拡張子込みでやることに注意)
% gcfは現在のfigure(今回はfigure1)を指す
% 特にフォルダを指定しなければ現在のフォルダに図が保存される

%% 図を好きなフォルダに保存しよう1
mkdir('newFolder1'); % 現在のフォルダに'newFolder1'という名前のフォルダを生成
saveas(gcf,'newFolder1/Barchart2.fig') ;
% 'newFolder1'という名前のフォルダの中に'Barchart1.fig'という名前で図を保存

%% 図を好きなフォルダに格納しよう
foldername=uigetdir('','図を保存したいフォルダを選ぼうのコーナー'); % ウィンドウが開くから図の保存先のフォルダを造るなり決めるなり
saveas(gcf,[foldername '/Barchart3.jpg']); % []を使っているのは二つの文字列のベクトルを生成しているという解釈をしている（正直意味わからんけど）
% 指定した場所ににBarchart3.jpgを保存

%% 回した時刻のフォルダを勝手に生成してそこに図を保存したい！！！
%% 変数をファイル名に含めたい！（n回目の試行とかn階の加速度とか）
[y,m,d]=ymd(datetime); % 日付の取得
[hh,mm,ss]=hms(datetime); % 時刻の取得
ss=round(ss); % 時刻を整数に丸める
foldername=sprintf('%d年%d月%d日%d時%d分%d秒',[y m d hh m ss]); % sprintfは非常に便利
mkdir(foldername) % 現在時刻の名前のフォルダを生成
for fignum=2:10
    figure(fignum);
    bar(x);
    saveas(gcf,sprintf([foldername '/Barchart%d.fig'],fignum-1)); % sprintfとsaveasを併用することでファイル名に変数を追加可能
end
% 数字の代わりに%dとかを置いておいて，あとから変数を置いておく（詳しくはsprintfのリファレンスを読もう）
%%
close all