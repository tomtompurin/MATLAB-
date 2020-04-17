%% グラフのフォーマット
fontsize=14; % 文字サイズ パワポなら20以上の数字をおすすめ，ワードならワードの文字サイズと同じ数字を
% GUIのフォント
set(0, 'defaultUicontrolFontName', 'Times New Roman');
% 軸のフォント
set(groot, 'defaultAxesFontName','Times New Roman');
% タイトル、注釈などのフォント
set(groot, 'defaultTextFontName','Times New Roman');
% GUIのフォントサイズ
set(groot, 'defaultUicontrolFontSize', fontsize);
% 軸のフォントサイズ
set(groot, 'defaultAxesFontSize', fontsize);
% タイトル、注釈などのフォントサイズ
set(groot, 'defaultTextFontSize', fontsize);
% 凡例の位置 bestとかnorthoutsideとか
set(groot, 'defaultLegendLocation', 'northoutside')
% 凡例の縦横
set(groot, 'defaultLegendOrientation', 'horizontal')
% グラフの太さ
set(groot, 'defaultLineLineWidth', 2)
% デフォルトのグラフの色（背景）
set(groot,'defaultFigureColor','w')
% グラフのカラー指定（R,G,B）=（0~1,0~1,0~1）;
% グラフのラインスタイル設定
% デフォルトのグラフの色が使いにくいので色やスタイルの組み合わせを作成
% RGBの値のセット，ここら辺は好きにいじって
color = [1 0 0;
    0 0 1;
    0 1 0;];
style='-|-.|:|--';
set(groot,'DefaultAxesLineStyleOrder',style,'defaultAxesColorOrder',color,'DefaultAxesLineStyleOrder',style)