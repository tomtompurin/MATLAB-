%% matlabからtwitterにつぶやくコード
clear
close all
%% まず以下のURlの1.~4.手順でThingspeakのアカウントを造り，アカウント連携をします
% https://jp.mathworks.com/help/thingspeak/thingtweet-app.html
% APIキーを使うのでコピーしてください
%% URL(ここは変更なし)
url = 'https://api.thingspeak.com/apps/thingtweet/1/statuses/update';
%% 以下のkeyを変更
api_key = 'ここに取得したキーを入力'; 
%% ツイート内容を規定
date=datestr(datetime); % 日付と時刻をdateに格納
data = ['MATLAB tweets this post at ' date]; % ここがツイートの文面 
% なんか日本語は対応してくれませんでした...
data = ['api_key=',api_key,'&status=',data];
response = webwrite(url,data);