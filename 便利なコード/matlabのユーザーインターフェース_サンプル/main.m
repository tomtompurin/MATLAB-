%% エクセルとかcsvファイルのパスをUIで指定できるようにするコード
% ファイルの指定
[filename,path] = uigetfile({'*.csv','*.xlsx'},'Select a File'); % 表示されるファイルの拡張子の設定（他に必要であれば追加してください）
if isequal(filename,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,filename)]);
end
%% ユーザーにクエスチョンを投げてくれるコード
answer = questdlg(['きのこの山とたけのこの里はどっちが好き？' newline], ...
	'きのこタケノコ戦争勃発', ...
	'きのこの山','たけのこの里','Cancel','Cancel');
% 回答ごとに処理を分岐
switch answer
    case 'きのこの山'
        disp('不正解！残念！！！');
    case 'たけのこの里'
        disp('正解！やったね！！！');
    case 'Cancel'
        disp('プログラムの実行はキャンセルされました');
        return
end
%% ディレクトリの指定（回すたびに図を保存するし保存場所も自分で決めたい人向け）
selpath = uigetdir;
A = [12.7 5.02 -98 63.9 0 -.2 56]; % 書き込みのためのベクトル
filename = fullfile(selpath,file);
xlswrite(filename,A);
%% 書き込みのためのファイル指定（回すたびに何かを保存するしそのためのファイル名指定も自分でしたい人向け）
A = [12.7 5.02 -98 63.9 0 -.2 56]; % 書き込みのためのベクトル
[file,path] = uiputfile('*.xlsx');
filename = fullfile(path,file);
xlswrite(filename,A);
%% ユーザーに情報を撃ち込ませる場合
x = inputdlg({'名前','口座番号','パスワード'},...
              '個人所情報の収集', [1 50; 1 12; 1 7]); 
disp(['名前は' x{1} newline '口座番号は' x{2} newline 'パスワードは' x{3} 'ですね！！']);
%% 選択肢の中から選ばせる場合(単一選択)
list = {'Red','Yellow','Blue',...                   
'Green','Orange','Purple'};
[indx,tf] = listdlg('ListString',list,'SelectionMode','single');
disp(indx);
%% 選択肢の中から選ばせる場合(複数選択)
list = {'Red','Yellow','Blue',...                   
'Green','Orange','Purple'};
[indx,tf] = listdlg('ListString',list,'SelectionMode','multiple');
disp(indx);
