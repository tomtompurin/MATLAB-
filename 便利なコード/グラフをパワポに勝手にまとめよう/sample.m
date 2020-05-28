%% 参考（というかパクリ）
% https://qiita.com/eigs/items/8c4bf743fc1319762607

%% PowerPointを開く
h = actxserver('PowerPoint.Application');
% PowerPointのウィンドウ表示（出来栄えの確認用）
h.Visible = 1; 

%% プレゼンテーションを追加
h.Presentation.invoke;
Presentation = h.Presentation.Add;

%% カスタムレイアウト読み込み
titleSlide = Presentation.SlideMaster.CustomLayouts.Item(1);
blankSlide = Presentation.SlideMaster.CustomLayouts.Item(2);

%% タイトルページ追加
Slide1 = Presentation.Slides.AddSlide(1,titleSlide);
Slide1.Shapes.Title.TextFrame.TextRange.Text = 'MATLAB -> PowerPoint 自動化';

%% 2ページ目以降、イメージを描画
methods = ["fitcnb","fitcsvm","fitctree","fitcknn"];
methodnames = ["ナイーブベイズ",...
    "サポートベクターマシン",...
    "決定木",...
    "ｋ近傍法"];
for ii=1:4
    newslide = Presentation.Slides.AddSlide(ii+1,blankSlide);
    newslide.Shapes.Title.TextFrame.TextRange.Text = [methodnames(ii) + "-" + methods(ii)];

    [loss, figH1, figH2] = checkClassificationPerformance(methods(ii));

    % 1つ目のFigureをコピペ
    print(figH1,'-dmeta','-r150')

    Image1 = newslide.Shapes.Paste;
    set(Image1, 'Left', 50) % 位置、大きさセット
    set(Image1, 'Top', 120)
    set(Image1, 'Width', 300)
    set(Image1, 'Height',300)

    % ２つ目のFigureをコピペ
    print(figH2,'-dmeta','-r150')

    Image2 = newslide.Shapes.Paste;
    set(Image2, 'Left',450)
    set(Image2, 'Top', 120)
    set(Image2, 'Width', 300)
    set(Image2, 'Height', 300)

    % Text 挿入 (Left, Top, Width, Height は TextBox の位置とサイズ)
    tmp = newslide.Shapes.AddTextbox('msoTextOrientationHorizontal',200,450,400,70);
    tmp.TextFrame.TextRange.Text = '混同行列';
    tmp = newslide.Shapes.AddTextbox('msoTextOrientationHorizontal',570,450,400,70);
    tmp.TextFrame.TextRange.Text = '散布図（ｘは不正解）';
    tmp = newslide.Shapes.AddTextbox('msoTextOrientationHorizontal',600,70,400,70);
    tmp.TextFrame.TextRange.Text = "Loss: " + string(loss);
end

%% プレゼンテーションを保存
Presentation.SaveAs([pwd '\ExamplePresentation.pptx']);

%% PowerPointを閉じる
h.Quit;
h.delete;