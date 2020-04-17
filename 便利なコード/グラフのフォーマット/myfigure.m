function [out] = myfigure(varargin)
% �y�����z
% figure�̑���Ɏg���Ή�ʓ����ォ�珇�Ԃɏd�Ȃ�Ȃ��悤�ɕ\�����Ă����B
%
% �y�����z
% �K�{�����F�Ȃ�
% �I�v�V��������(1�̏ꍇ)�Ffigure(����)�Ɠ���
%   �g���Fmyfigure(1:4)��myfigure([1 3 5])�ŕ����J���Ă����i�قƂ�ǈӖ��Ȃ����ǁj
%   �g���Fmyfigure(0)�ō쐬���Ă���figure��S�ĕ\��
%       ��Fmyfigure(1), myfigure(3), myfigure(1:15), myfigure(0)
%       �폜�p��close all or close(1:figure)
%   �g���Fmyfigure tate ���c�����֕��ׂ�
%         myfigure yoko ���������֕��ׂ�i�f�t�H���g�j
% �I�v�V��������(2�̏ꍇ)�Ffigure�̉����Əc���̐ݒ�i�ύX�FMATLAB�����܂ŗL���j
%   myfigure(figure_width, figure_height)
% 	�f�t�H���g����(��, �c) = (figure_width, figure_height) = (560, 420) % figure�łł���̂Ɠ���
%       ��Fmyfigure(400, 500)
%
% �y�Ԃ�l�z
% ���ʂ�figure�Ɠ����Bfigure�ԍ���return
%
% �ym�t�@�C�����ݒ�z
%   �E�����̃f�B�X�v���C���g���Ă���ꍇ�͂ǂꂩ��\�����Ă�����
%     �i�f�t�H���g�F2(�T�u)��1(���C��)��3��4���E�E�E�j
%   �Efigure�Ԃ̗]��
%   �Efigure�̃T�C�Y�i�f�t�H���g���͉� = 400, �c = 300)
%
% �y�쐬�ҁz
%   ���{
% �y�쐬�����z
% 2013/06/03 v1.1
% 2013/06/07 v1.2
% 2013/06/28 v1.3 myfigure all��myfigure 0�Ɠ��������s����悤�ɂ���
% 2013/07/05 v1.4 myfigure 800 500 all, myfigure 800 500 0�ňȍ~�̃f�t�H���g�T�C�Y�ύX(���800, 500)���\�ɂ���
% 2013/11/10 v1.5 myfigure all, myfigure 0�Ŏ������\�����̃O���t���l�߂ĕ\������悤�ɂ��Ă݂�
% 2014/05/22 v1.6 myfigure tate�ŏc�ɕ��ׂ邱�Ƃ��\�i����͐ݒ肷�邾���Amyfigure all�ȂǕK�v�j
%                 ���l��myfigure yoko�ŉ��ɕ��ׂ�ݒ�B�i�����l�Fyoko�j
% 2014/07/18 v2.1 myfigure('name', 'aaaaavb')�@�i�^�C�g��aaaavb��figure�j�̂悤�Ɉ������n���ꂽ���ɔ������Ă����G���[���C���ifigure�ɂ��̂܂ܓn���悤�ɕύX�j
%                 myfigure(1:5, 'name', 'aaaaavb') ��i�^�C�g��aaaavb��figure��1����5�܂Łj
%                 myfigure(600, 100, 1:5, 'name', 'aaaaavb') ���\�i600 * 100�̑傫���A�^�C�g��aaaavb��figure��1����5�܂Łj
% 2014/09/20 v2.2 myfigure close 1:20�ŕ����̐}��������悤��
 
    %% �ݒ�:figure��\��������f�B�X�v���C�̏���1:���C��,2:�T�u, 3,�E�E�E
    % �f�t�H���g��2(�T�u)��1(���C��)��3��4���E�E�E�i��3�ȏ�̃f�B�X�v���C�͖��m�F�j
    %     useDispNoArray = [1 2 3 4 5:10];
    useDispNoArray = [1 2 3 4 5:10];
    %     �]���i�������j
    marginLeft = 16;
    %     �]���i������j
    marginTop = 90;
    %     figure�̏㉺���E�̃E�B���h�E�� = [87 8 8 8]

    %     figure�̃f�t�H���g�T�C�Y [��, �c]
    %% figure�T�C�Y�̒�`�E�ۑ�
    global myfigure_size
    if length(myfigure_size) == 0
        myfigure_size = [560, 420];
    end
%     �}�̕��ѕ�
% �f�t�H���g�F�����c
% 
    global myfigure_tate
    if ~islogical(myfigure_tate)
        myfigure_tate = false;
    end
    %%
    %         �umyfigure 2�v�umyfigure 1:10�v�umyfigure 400 400�v�ɑΉ�
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
    
%     �����ʂŃR�s�[
    args = varargin(:);
    
    if (length(args) >= 2) 
        var1 = args{1};
        var2 = args{2};
%         ��1,2����������or����������Ȃ�T�C�Y�w��Ɖ���
        if isnumeric(var1) && isnumeric(var2)
            myfigure_size = [var1, var2];
%     �����ʂň��k������
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
                    warning([num2str(ii), '�Ԗڂ̐}�͂���܂���']);
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
                    warning(warnID, ['������figure�͂���܂���Fmyfigure ', varargin{:}]);
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
        % �����Ȃ��ł̌Ăяo��
        figNum = builtin('figure', args{:});
    end
        
    %     �Ԃ�l��v������Ă���Ԃ�
    if nargout ~= 0
        out = figNum;
    end
    % myfigure all �̎��\������figure���l�߂ĕ\��
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
    %     �I���t���O�Ffigure�͈͕̔\���A�S�\���̏ꍇ�Ȃ�
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
        % 1�s�ځF�m�[�p�\�{�̃f�B�X�v���C�i����x,y���W�A�E��x,y���W�j
        % 2�s�ڈȍ~�F���̃f�B�X�v���C�i����x,y���W�A�E��x,y���W�j
        % �����C���f�B�b�V����1, 1�Ŏn�܂�
        %            1           1        1366         768
        %        -1919       -1079           0           0
        % �f�B�X�v���C�̐�
        dispNo = size(dispInfo, 1);
        % �f�B�X�v���C���ȏ�̔ԍ��͏���
        useDispNoArray = useDispNoArray(useDispNoArray <= dispNo);
        % ���ёւ�
        dispInfo = dispInfo(useDispNoArray, :);
        %%
        % �m�[�p�\�{�́iWindows�{�^���\���f�B�X�v���C�Ƃ͌���Ȃ��j�X�N���[���T�C�Y
        mainScreenSize = get(0,'ScreenSize');
%         �s��, �s��, ����, �c��
        %            1           1        1366         768
        for i = 1:dispNo
            ScreenSize = dispInfo(i, :);
            %        -1919       -1079           0           0
            %            1           1        1366         768
            %     [����x ����y �E��x �E��y]
            %     [2 1]�\�[�g�ς�
            screenWidth = ScreenSize(3) - ScreenSize(1);
            screenHeight = ScreenSize(4) - ScreenSize(2);
            yoko = marginLeft + figure_width;
            tate = marginTop + figure_height;
            %     ��
            rowMax = floor(screenWidth / yoko);
            %     �s
            colMax = floor(screenHeight / tate);
            if numPos > rowMax * colMax
                numPos = numPos - rowMax * colMax;
    %             ����𓯂��ʒu�ɂ��ăT�C�Y�ύX
                pos = get(figNum, 'Position');
                set(figNum,'Position',[pos(1), pos(2) + pos(4) - figure_height, figure_width, figure_height]);
                continue
            end
            %     ��(0����)
            row = mod(numPos - 1, rowMax);
            %     �s(0����)
            col = ceil(numPos / rowMax);
            % �w��F[left, bottom, width, height]:
            % left : �傫���ƉE�̂ق��A�f�B�X�v���C���W�l���̂܂�
            % bottom : �傫���Ə�̕��F��ԍ���ɖ{�̃f�B�X�v���C���d�˂����̖{�̃f�B�X�v���C�̉����E��i�悭�킩���j
            if myfigure_tate
%                 �c�����ɕ��ׂ�i�񁨍s�j
                %     �s(1����)
                col = mod(numPos - 1, colMax) + 1;
                %     ��(1����)
                row = ceil(numPos / colMax) - 1;
            else
%                 �������֕��ׂ�i�s����j
                %     ��(0����)
                row = mod(numPos - 1, rowMax);
                %     �s(1����)
                col = ceil(numPos / rowMax);
            end
            left = ScreenSize(1) + marginLeft + yoko * row;
            bottom = mainScreenSize(4) - ScreenSize(2) - tate * col;
            set(figNum,'Position',[left, bottom, figure_width, figure_height]);
            return
        end        
    end
end
