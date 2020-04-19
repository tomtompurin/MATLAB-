%% アニメーションの作成
close all
clear
fontsize=10.5;
% GUIのフォント
set(0, 'defaultUicontrolFontName', 'Times New Roman');
% 軸のフォント
set(0, 'defaultAxesFontName','Times New Roman');
% タイトル、注釈などのフォント
set(0, 'defaultTextFontName','Times New Roman');
% GUIのフォントサイズ
set(0, 'defaultUicontrolFontSize', fontsize);
% 軸のフォントサイズ
set(0, 'defaultAxesFontSize', fontsize);
% タイトル、注釈などのフォントサイズ
set(0, 'defaultTextFontSize', fontsize);

%% アニメ化したい時刻歴を用意
dt=0.01; % サンプリング時間
t=dt:dt:3; % 時間のベクトル
data1=sin(5*t); % 時刻歴
data2=cos(5*t); % 時刻歴

date=num2str(date()); % 日付をdateに格納
filename=['動画/' date '_video'];
mkdir(filename) % 現在のフォルダにビデオを作成するためのフォルダを生成

myVideo = VideoWriter([filename '/棒グラフのアニメ']); % ビデオを作るための呪文，拡張子の設定とかはすみませんわからないです
myVideo.FrameRate = 1*1/dt; % フレームレート (frame per sec)これを変えることで動画の速度を変更可能
myVideo.Quality = 70; % 画質設定，0~100で高いほど高画質

open(myVideo);
set(gca);
% 以下で最初の1フレームのデータを表示
Graph1=bar(1,data1(1));
hold on
Graph2=bar(2,data2(1));

% 以下で図のフォーマット
legend("data1","data2");
ylim([-1 1])
xticks([1 2])
xticklabels({'sine','cosine'})

% 最初の1フレームを保存
myMovie(1)=getframe(gcf); % 現在アクティブなグラフをフレームとして得る
writeVideo(myVideo, myMovie(1));

for k=2:length(t)
    Graph1.YData=data1(k); % グラフに描画するデータの更新
    Graph2.YData=data2(k); % グラフに描画するデータの更新
    myMovie(k)=getframe(gcf); % 現在アクティブなグラフをフレームとして得る
    writeVideo(myVideo, myMovie(k));
end

disp("writeVideo end")
close(myVideo);
    