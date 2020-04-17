%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% date:2020/04/09
% author:Yuta Tomiyoshi
% explanation:This program shows how to save figures 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% �܂���saveas�ɂ���
fignum=1; % figure�̔ԍ����Ǘ����邽�߂̂���
figure(fignum) % 
x = [2 4 7 2 4 5 2 5 1 4];
bar(x); % �_�O���t���쐬
saveas(gcf,'Barchart1.png') 
% ���݂�figure��'Barchart.png'�Ƃ������O�ŕۑ�(�g���q���݂ł�邱�Ƃɒ���)
% gcf�͌��݂�figure(�����figure1)���w��
% ���Ƀt�H���_���w�肵�Ȃ���Ό��݂̃t�H���_�ɐ}���ۑ������

%% �}���D���ȃt�H���_�ɕۑ����悤1
mkdir('newFolder1'); % ���݂̃t�H���_��'newFolder1'�Ƃ������O�̃t�H���_�𐶐�
saveas(gcf,'newFolder1/Barchart2.fig') ;
% 'newFolder1'�Ƃ������O�̃t�H���_�̒���'Barchart1.fig'�Ƃ������O�Ő}��ۑ�

%% �}���D���ȃt�H���_�Ɋi�[���悤
foldername=uigetdir('','�}��ۑ��������t�H���_��I�ڂ��̃R�[�i�['); % �E�B���h�E���J������}�̕ۑ���̃t�H���_�𑢂�Ȃ茈�߂�Ȃ�
saveas(gcf,[foldername '/Barchart3.jpg']); % []���g���Ă���͓̂�̕�����̃x�N�g���𐶐����Ă���Ƃ������߂����Ă���i�����Ӗ��킩��񂯂ǁj
% �w�肵���ꏊ�ɂ�Barchart3.jpg��ۑ�

%% �񂵂������̃t�H���_������ɐ������Ă����ɐ}��ۑ��������I�I�I
%% �ϐ����t�@�C�����Ɋ܂߂����I�in��ڂ̎��s�Ƃ�n�K�̉����x�Ƃ��j
[y,m,d]=ymd(datetime); % ���t�̎擾
[hh,mm,ss]=hms(datetime); % �����̎擾
ss=round(ss); % �����𐮐��Ɋۂ߂�
foldername=sprintf('%d�N%d��%d��%d��%d��%d�b',[y m d hh m ss]); % sprintf�͔��ɕ֗�
mkdir(foldername) % ���ݎ����̖��O�̃t�H���_�𐶐�
for fignum=2:10
    figure(fignum);
    bar(x);
    saveas(gcf,sprintf([foldername '/Barchart%d.fig'],fignum-1)); % sprintf��saveas�𕹗p���邱�ƂŃt�@�C�����ɕϐ���ǉ��\
end
% �����̑����%d�Ƃ���u���Ă����āC���Ƃ���ϐ���u���Ă����i�ڂ�����sprintf�̃��t�@�����X��ǂ����j
%%
close all