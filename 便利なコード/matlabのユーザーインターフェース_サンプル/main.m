%% �G�N�Z���Ƃ�csv�t�@�C���̃p�X��UI�Ŏw��ł���悤�ɂ���R�[�h
% �t�@�C���̎w��
[filename,path] = uigetfile({'*.csv','*.xlsx'},'Select a File'); % �\�������t�@�C���̊g���q�̐ݒ�i���ɕK�v�ł���Βǉ����Ă��������j
if isequal(filename,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,filename)]);
end
%% ���[�U�[�ɃN�G�X�`�����𓊂��Ă����R�[�h
answer = questdlg(['���̂��̎R�Ƃ����̂��̗��͂ǂ������D���H' newline], ...
	'���̂��^�P�m�R�푈�u��', ...
	'���̂��̎R','�����̂��̗�','Cancel','Cancel');
% �񓚂��Ƃɏ����𕪊�
switch answer
    case '���̂��̎R'
        disp('�s�����I�c�O�I�I�I');
    case '�����̂��̗�'
        disp('�����I������ˁI�I�I');
    case 'Cancel'
        disp('�v���O�����̎��s�̓L�����Z������܂���');
        return
end
%% �f�B���N�g���̎w��i�񂷂��тɐ}��ۑ����邵�ۑ��ꏊ�������Ō��߂����l�����j
selpath = uigetdir;
A = [12.7 5.02 -98 63.9 0 -.2 56]; % �������݂̂��߂̃x�N�g��
filename = fullfile(selpath,file);
xlswrite(filename,A);
%% �������݂̂��߂̃t�@�C���w��i�񂷂��тɉ�����ۑ����邵���̂��߂̃t�@�C�����w��������ł������l�����j
A = [12.7 5.02 -98 63.9 0 -.2 56]; % �������݂̂��߂̃x�N�g��
[file,path] = uiputfile('*.xlsx');
filename = fullfile(path,file);
xlswrite(filename,A);
%% ���[�U�[�ɏ����������܂���ꍇ
x = inputdlg({'���O','�����ԍ�','�p�X���[�h'},...
              '�l�����̎��W', [1 50; 1 12; 1 7]); 
disp(['���O��' x{1} newline '�����ԍ���' x{2} newline '�p�X���[�h��' x{3} '�ł��ˁI�I']);
%% �I�����̒�����I�΂���ꍇ(�P��I��)
list = {'Red','Yellow','Blue',...                   
'Green','Orange','Purple'};
[indx,tf] = listdlg('ListString',list,'SelectionMode','single');
disp(indx);
%% �I�����̒�����I�΂���ꍇ(�����I��)
list = {'Red','Yellow','Blue',...                   
'Green','Orange','Purple'};
[indx,tf] = listdlg('ListString',list,'SelectionMode','multiple');
disp(indx);
