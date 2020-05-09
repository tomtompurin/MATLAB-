%% ����`�����Q�N�b�^�̌v�Z

function K=rungekutta(X,u,dt)
%% �|���U�q�̃��f��
M=0.1;        % Mass of daisya
m=0.023;      % Mass of bar
J=3.20e-4;	% Inertia moment
L=0.2;		% Length
mu=2.74e-5;	% Damping coefficient
g=9.81;       % Gravity accel.

%% 
MM=[M+m m*L*cos(X(2))
    m*L*cos(X(2)) J+m*L*L];

% cos(X(2))�̍����������Ƃ��ɃA���_�[�t���[���N�����C��Ίp����NaN���������邱�Ƃ�����
% �����������邽�߂̗�O����
if isnan(MM(1,2)*MM(2,1))==1
    MM=[M+m 0
    0 J+m*L*L];
end

KK=MM\[u+m*L*X(4)^2*sin(X(2))-mu*X(3);m*g*L*sin(X(2))-mu*X(4)];

K=dt*[X(3);X(4);KK];