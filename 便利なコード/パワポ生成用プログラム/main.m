%% プログラムによるプレゼンテーションの作成
clear
close all
%% テンプレートの設定
import mlreportgen.ppt.*
slidesFile = 'myTemplate.pptx';
% slides = Presentation('myTemplate'); % myTempleteという名前のテンプレートを使用

% open(slides);
% close(slides);

if ispc
    winopen(slidesFile);
end

%% Presentation オブジェクトの作成
slidesFile = 'myNewPPTPresentation.pptx';
slides = Presentation(slidesFile,'myTemplate');

presentationTitleSlide = add(slides,'タイトル スライド');

replace(presentationTitleSlide,'タイトル 1','MATLABでパワポを作ろう！');

subtitleText = Paragraph('2020年度 髙橋研 修士2年');
append(subtitleText,[newline '冨吉雄太']);
replace(presentationTitleSlide,'サブタイトル 2',subtitleText);

%% 図のあるスライドの追加
x = randn(10000,1);
h = histogram(x);

saveas(gcf,'myPlot_img.png');

plot1 = Picture('myPlot_img.png');

pictureSlide = add(slides,'タイトルとコンテンツ');
contents = find(pictureSlide,'タイトル 1');
replace(contents(1),'図をパワポに載せることができます！');
contents = find(pictureSlide,'コンテンツ プレースホルダー 2');
replace(contents(1),plot1);

%% テキストのあるスライドの追加
textSlide = add(slides,'タイトルとコンテンツ');

titleText2 = Paragraph('文字だけのスライドも作れます！');
contents = find(textSlide,'タイトル 1');
replace(contents(1),titleText2);

t=Paragraph('別に便利ではないです...');
t.FontColor='red';
t.Strike='double';
contents = find(textSlide,'コンテンツ プレースホルダー 2');
replace(contents(1),{'インデントも',{'こうやって',{'自由に',{'いじれます！！'}}},...
[],t});

%% テーブルのあるスライドの追加
tableSlide = add(slides,'タイトルとコンテンツ');
contents = find(tableSlide,'タイトル 1');
titleText3 = Paragraph('表も作れます！');
replace(contents(1),titleText3);

paramTable = Table();
colSpecs(2) = ColSpec('6in');
colSpecs(1) = ColSpec('3in');
paramTable.ColSpecs = colSpecs;

tr1 = TableRow();
tr1.Style = {Bold(true)};

tr1te1Text = Paragraph('Product');
tr1te2Text = Paragraph('Description');
tr1te1 = TableEntry();
tr1te2 = TableEntry();
append(tr1te1,tr1te1Text);
append(tr1te2,tr1te2Text);
append(tr1,tr1te1);
append(tr1,tr1te2);

tr2 = TableRow();
tr2te1Text = Paragraph('きのこの山');
tr2te2Text = Paragraph('1975年に明治製菓が発売。');
append(tr2te2Text,'正直たけのこの里の方がおいしいけどきのこの山派はそのことを認めないので戦争が終わらない。');
tr2te1 = TableEntry();
tr2te2 = TableEntry();
append(tr2te1,tr2te1Text);
append(tr2te2,tr2te2Text);
append(tr2,tr2te1);
append(tr2,tr2te2);

tr3 = TableRow();
tr3te1Text = Paragraph('たけのこの里');
tr3te2Text = Paragraph('きのこの山から4年送れて1979年に発売される。');
append(tr3te2Text,'今現在たけのこの里派がきのこの山派に比べ、若干勢力が上だと明治製菓が公式に発表している。');
tr3te1 = TableEntry();
tr3te2 = TableEntry();
append(tr3te1,tr3te1Text);
append(tr3te2,tr3te2Text);
append(tr3,tr3te1);
append(tr3,tr3te2);

append(paramTable,tr1);
append(paramTable,tr2);
append(paramTable,tr3);

contents = find(tableSlide,'コンテンツ プレースホルダー 2');
replace(contents(1),paramTable);

%% プレゼンテーションを生成して開く
close(slides);

if ispc
    winopen(slidesFile);
end