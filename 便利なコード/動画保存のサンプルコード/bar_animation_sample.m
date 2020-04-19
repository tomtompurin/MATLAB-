%% �A�j���[�V�����̍쐬
close all
clear
fontsize=10.5;
% GUI�̃t�H���g
set(0, 'defaultUicontrolFontName', 'Times New Roman');
% ���̃t�H���g
set(0, 'defaultAxesFontName','Times New Roman');
% �^�C�g���A���߂Ȃǂ̃t�H���g
set(0, 'defaultTextFontName','Times New Roman');
% GUI�̃t�H���g�T�C�Y
set(0, 'defaultUicontrolFontSize', fontsize);
% ���̃t�H���g�T�C�Y
set(0, 'defaultAxesFontSize', fontsize);
% �^�C�g���A���߂Ȃǂ̃t�H���g�T�C�Y
set(0, 'defaultTextFontSize', fontsize);

%% �A�j������������������p��
dt=0.01; % �T���v�����O����
t=dt:dt:3; % ���Ԃ̃x�N�g��
data1=sin(5*t); % ������
data2=cos(5*t); % ������

date=num2str(date()); % ���t��date�Ɋi�[
filename=['����/' date '_video'];
mkdir(filename) % ���݂̃t�H���_�Ƀr�f�I���쐬���邽�߂̃t�H���_�𐶐�

myVideo = VideoWriter([filename '/�_�O���t�̃A�j��']); % �r�f�I����邽�߂̎����C�g���q�̐ݒ�Ƃ��͂��݂܂���킩��Ȃ��ł�
myVideo.FrameRate = 1*1/dt; % �t���[�����[�g (frame per sec)�����ς��邱�Ƃœ���̑��x��ύX�\
myVideo.Quality = 70; % �掿�ݒ�C0~100�ō����قǍ��掿

open(myVideo);
set(gca);
% �ȉ��ōŏ���1�t���[���̃f�[�^��\��
Graph1=bar(1,data1(1));
hold on
Graph2=bar(2,data2(1));

% �ȉ��Ő}�̃t�H�[�}�b�g
legend("data1","data2");
ylim([-1 1])
xticks([1 2])
xticklabels({'sine','cosine'})

% �ŏ���1�t���[����ۑ�
myMovie(1)=getframe(gcf); % ���݃A�N�e�B�u�ȃO���t���t���[���Ƃ��ē���
writeVideo(myVideo, myMovie(1));

for k=2:length(t)
    Graph1.YData=data1(k); % �O���t�ɕ`�悷��f�[�^�̍X�V
    Graph2.YData=data2(k); % �O���t�ɕ`�悷��f�[�^�̍X�V
    myMovie(k)=getframe(gcf); % ���݃A�N�e�B�u�ȃO���t���t���[���Ƃ��ē���
    writeVideo(myVideo, myMovie(k));
end

disp("writeVideo end")
close(myVideo);
    