function [out] = myfigure(varargin)
% 【説明】
% figureの代わりに使えば画面内左上から順番に重ならないように表示してくれる。
%
% 【引数】
% 必須引数：なし
% オプション引数(1つの場合)：figure(引数)と同じ
%   拡張：myfigure(1:4)やmyfigure([1 3 5])で複数個開いてくれる（ほとんど意味ないけど）
%   拡張：myfigure(0)で作成してあるfigureを全て表示
%       例：myfigure(1), myfigure(3), myfigure(1:15), myfigure(0)
%       削除用→close all or close(1:figure)
%   拡張：myfigure tate →縦方向へ並べる
%         myfigure yoko →横方向へ並べる（デフォルト）
% オプション引数(2つの場合)：figureの横幅と縦幅の設定（変更：MATLABを閉じるまで有効）
%   myfigure(figure_width, figure_height)
% 	デフォルト幅は(横, 縦) = (figure_width, figure_height) = (560, 420) % figureでできるのと同じ
%       例：myfigure(400, 500)
%
% 【返り値】
% 普通のfigureと同じ。figure番号をreturn
%
% 【mファイル内設定】
%   ・複数のディスプレイを使っている場合はどれから表示していくか
%     （デフォルト：2(サブ)→1(メイン)→3→4→・・・）
%   ・figure間の余白
%   ・figureのサイズ（デフォルト幅は横 = 400, 縦 = 300)
%
% 【作成者】
%   杉本
% 【作成日時】
% 2013/06/03 v1.1
% 2013/06/07 v1.2
% 2013/06/28 v1.3 myfigure allでmyfigure 0と同じ事を行えるようにした
% 2013/07/05 v1.4 myfigure 800 500 all, myfigure 800 500 0で以降のデフォルトサイズ変更(例は800, 500)を可能にした
% 2013/11/10 v1.5 myfigure all, myfigure 0で歯抜け表示中のグラフを詰めて表示するようにしてみた
% 2014/05/22 v1.6 myfigure tateで縦に並べることが可能（これは設定するだけ、myfigure allなど必要）
%                 同様にmyfigure yokoで横に並べる設定。（初期値：yoko）
% 2014/07/18 v2.1 myfigure('name', 'aaaaavb')　（タイトルaaaavbのfigure）のように引数が渡された時に発生していたエラーを修正（figureにそのまま渡すように変更）
%                 myfigure(1:5, 'name', 'aaaaavb') や（タイトルaaaavbのfigureを1から5まで）
%                 myfigure(600, 100, 1:5, 'name', 'aaaaavb') も可能（600 * 100の大きさ、タイトルaaaavbのfigureを1から5まで）
% 2014/09/20 v2.2 myfigure close 1:20で複数個の図を消せるように
 
    %% 設定:figureを表示させるディスプレイの順番1:メイン,2:サブ, 3,・・・
    % デフォルトは2(サブ)→1(メイン)→3→4→・・・（※3つ以上のディスプレイは未確認）
    %     useDispNoArray = [1 2 3 4 5:10];
    useDispNoArray = [1 2 3 4 5:10];
    %     余白（左方向）
    marginLeft = 16;
    %     余白（上方向）
    marginTop = 90;
    %     figureの上下左右のウィンドウ幅 = [87 8 8 8]

    %     figureのデフォルトサイズ [横, 縦]
    %% figureサイズの定義・保存
    global myfigure_size
    if length(myfigure_size) == 0
        myfigure_size = [560, 420];
    end
%     図の並び方
% デフォルト：横→縦
% 
    global myfigure_tate
    if ~islogical(myfigure_tate)
        myfigure_tate = false;
    end
    %%
    %         「myfigure 2」「myfigure 1:10」「myfigure 400 400」に対応
    function str = checkChar(str)
        if ischar(str)
            str = eval(str);
        end
    end
    function bool = findStrRegexp(var, pat)
        bool = ~isempty(regexp(var, pat, 'once'));
    end
%%
    warnID = 'myfigure:warning';
    %%
    flagFinish = false;
    flagShowAll = false;
    
%     小括弧でコピー
    args = varargin(:);
    
    if (length(args) >= 2) 
        var1 = args{1};
        var2 = args{2};
%         第1,2引数が数字or数字文字列ならサイズ指定と解釈
        if isnumeric(var1) && isnumeric(var2)
            myfigure_size = [var1, var2];
%     小括弧で圧縮しつつ複製
            args = args(3:end);
        elseif ischar(var1) && ischar(var2) && findStrRegexp(var1, '^\d+$') && findStrRegexp(var2, '^\d+$')
            myfigure_size = [str2num(var1), str2num(var2)];
            args = args(3:end);
        end
    end
    
    figNum = -1;
    if (length(args) >= 1) 
        var1 = args{1};
        if strcmp(var1, 'all')
            figNum = 0;
            args = args(2:end);
        elseif strcmp(var1, 'close')
            nums = checkChar(args{2});
            for ii = nums
                try
                    close(ii);
                catch
                    warning([num2str(ii), '番目の図はありません']);
                end
            end
            return
        elseif strcmp(var1, 'tate')
            myfigure_tate = true;
            return;
        elseif strcmp(var1, 'yoko')
            myfigure_tate = false;
            return;
        else
            if isnumeric(var1)
                figNum = var1;
                args = args(2:end);
            elseif ischar(var1)&& findStrRegexp(var1, '^\d+( *: *\d+)?$')
                figNum = eval(var1);
                args = args(2:end);
            end
        end
        
        if figNum == 0
            figNum = sort(get(0, 'Children'));
            if isempty(figNum)
                if nargin == 1
                    warning(warnID, ['既存のfigureはありません：myfigure ', varargin{:}]);
                end
                flagFinish = true;
            end
            flagShowAll = true;
        end
        if length(figNum) >= 2
            if ~flagShowAll
                for index = figNum
                    myfigure(index, args{:});
                end
            end
            flagFinish = true;
        elseif figNum > 0
            figNum = builtin('figure', figNum);
            if (length(args) >= 1)
                set(figNum, args{:});
            end
        end
    end
    
    if figNum == -1
        % 引数なしでの呼び出し
        figNum = builtin('figure', args{:});
    end
        
    %     返り値を要求されてたら返す
    if nargout ~= 0
        out = figNum;
    end
    % myfigure all の時表示中のfigureを詰めて表示
    if flagShowAll
        for k=1:length(figNum)
            setPosition(k, figNum(k));
            builtin('figure', figNum(k));
            if (length(args) >= 1)
                set(figNum(k), args{:});
            end
        end
        flagFinish = true;
    end
    %     終了フラグ：figureの範囲表示、全表示の場合など
    if flagFinish
        return
    end
    %%
    setPosition(figNum.Number, figNum);
    
    function setPosition(numPos, figNum)
        figure_width = myfigure_size(1);
        figure_height = myfigure_size(2);
        %%
        dispInfo = get(0,'MonitorPosition');
        % 1行目：ノーパソ本体ディスプレイ（左上x,y座標、右下x,y座標）
        % 2行目以降：他のディスプレイ（左上x,y座標、右下x,y座標）
        % ※メインディッシュは1, 1で始まる
        %            1           1        1366         768
        %        -1919       -1079           0           0
        % ディスプレイの数
        dispNo = size(dispInfo, 1);
        % ディスプレイ数以上の番号は消去
        useDispNoArray = useDispNoArray(useDispNoArray <= dispNo);
        % 並び替え
        dispInfo = dispInfo(useDispNoArray, :);
        %%
        % ノーパソ本体（Windowsボタン表示ディスプレイとは限らない）スクリーンサイズ
        mainScreenSize = get(0,'ScreenSize');
%         不明, 不明, 横幅, 縦幅
        %            1           1        1366         768
        for i = 1:dispNo
            ScreenSize = dispInfo(i, :);
            %        -1919       -1079           0           0
            %            1           1        1366         768
            %     [左上x 左上y 右下x 右下y]
            %     [2 1]ソート済み
            screenWidth = ScreenSize(3) - ScreenSize(1);
            screenHeight = ScreenSize(4) - ScreenSize(2);
            yoko = marginLeft + figure_width;
            tate = marginTop + figure_height;
            %     列
            rowMax = floor(screenWidth / yoko);
            %     行
            colMax = floor(screenHeight / tate);
            if numPos > rowMax * colMax
                numPos = numPos - rowMax * colMax;
    %             左上を同じ位置にしてサイズ変更
                pos = get(figNum, 'Position');
                set(figNum,'Position',[pos(1), pos(2) + pos(4) - figure_height, figure_width, figure_height]);
                continue
            end
            %     列(0から)
            row = mod(numPos - 1, rowMax);
            %     行(0から)
            col = ceil(numPos / rowMax);
            % 指定：[left, bottom, width, height]:
            % left : 大きいと右のほう、ディスプレイ座標値そのまま
            % bottom : 大きいと上の方：一番左上に本体ディスプレイを重ねた時の本体ディスプレイの下境界基準（よくわからん）
            if myfigure_tate
%                 縦方向に並べる（列→行）
                %     行(1から)
                col = mod(numPos - 1, colMax) + 1;
                %     列(1から)
                row = ceil(numPos / colMax) - 1;
            else
%                 横方向へ並べる（行→列）
                %     列(0から)
                row = mod(numPos - 1, rowMax);
                %     行(1から)
                col = ceil(numPos / rowMax);
            end
            left = ScreenSize(1) + marginLeft + yoko * row;
            bottom = mainScreenSize(4) - ScreenSize(2) - tate * col;
            set(figNum,'Position',[left, bottom, figure_width, figure_height]);
            return
        end        
    end
end
