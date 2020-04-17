%% グラフのフォーマットやサイズなどを規定するプログラム
%% myfigureは制作者が冨吉ではないです
%%
clear
close all
%% グラフのフォーマット
graph_format

%% グラフサイズの規定
yoko=173.8; % ウィンドウ幅（単位はmm）
tate=yoko/2; % ウィンドウ高さ（単位はmm）

% 卒論の図の横幅は173.8 mmでした（人による）

%% 以下，windowsかMacかでコメントアウト
% windowsの場合 96 pix =1 inch= =25.4 mmなので
yoko=96*yoko/25.4;
tate=96*tate/25.4;
% % macの場合 72 pix =1 inch= =25.4 mmなので
% yoko=72*yoko/25.4;
% tate=72*tate/25.4;

%% グラフの生成2つ
myfigure(yoko,tate)
plot(rand(6))
legend('1','2','3','4','5','6')

myfigure(yoko,tate)
plot(rand(6))
legend('1','2','3','4','5','6')