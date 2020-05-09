%% �|���U��q�̐U��グ���艻
%% ���j
%{
1.�U��グ�p�̐����ƁC���艻�p�̐�����p�ӂ���
2.��̐����̂����C�ǂ���̐������g���������߂�j���[�����l�b�g���[�N���쐬
 ==>NN�̓��͂͌��݂̏�ԗʁC�o�͓͂�̐����̂����ǂ�����g����
%}
clear
close all

%% �|���U�q�̃��f��
M=0.1;        % Mass of daisya
m=0.023;      % Mass of bar
J=3.20e-4;	% Inertia moment
L=0.2;		% Length
mu=2.74e-5;	% Damping coefficient
zeta=240;     % Physical parameter of DC motor
xi=90;		% Physical parameter of DC motor
g=9.81;       % Gravity accel.

%% �œK���M�����[�^�@�ɂ���ԃt�B�[�h�o�b�N�Q�C���̐݌v
% ���`������ԕ�������lqr�ɂ��Q�C������
p1=m*L/(J+m*L*L); p2=mu/(J+m*L*L);
A=[0 0 1 0;0 0 0 1;0 0 -zeta 0; 0 p1*g p1*zeta -p2];
B=[0;0;xi;-p1*xi];
C=[1 0 0 0;0 1 0 0];
D=[0;0];
Q=diag([1,10,1,10]);
r=10;
K=lqr(A,B,Q,r);

%% ���l�V�~�����[�V����
% �l�X�ȏ����p�x���猟��
% x0=[0;pi;0;0]; % �����l
% x0=[0;pi/2;0;0]; % �����l
% x0=[0;pi/3;0;0]; % �����l
% x0=[0;pi/4;0;0]; % �����l
% x0=[0;pi*2/3;0;0]; % �����l
x0=[0;pi*3/4;0;0]; % �����l
dt=0.005;
T=0.0:dt:8;
tsize = size(T,2);

%% �l�b�g���[�N�̒�`
net=perceptron;
net=configure(net,zeros(2,1),0);

%% �l�b�g���[�N�ɏd�݂���
load('bchrom3.mat'); % �w�K�ς݃p�����[�^��ǂݍ���
net.IW{1,1}=bchrom; % �d��
net.b{1}=-1; % �o�C�A�X�H

%% ���l�v�Z
u_nn=zeros(length(T),1);
X_n=zeros(4,length(T)+1);
X_n(:,1)=x0;

for i=1:length(T)
    % �p�x����-�΁`�΂͈̔͂ɏC��
    X(:,i)=X_n(:,i);
    X(2,i)=rem(X(2,i),2*pi);
    if X(2,i)>pi
        X(2,i)=X(2,i)-2*pi;
    end
    if X(2,i)<-pi
        X(2,i)=X(2,i)+2*pi;
    end
    
    % �l�b�g���[�N�̒l�ɉ����ĐU��グ�C����̂ǂ���̐������g�����𔻒�
    % 0�����艻�C1���U��グ
    jjj(i)=sim(net,[X(2,i)^2;X(4,i)^2]); % jjj(i)��0��1���i�[����܂�
    
    if jjj(i)==1
        % �U��グ�̂��߂�bang-bang�����
        if X_n(4,i)<0&&(X(2,i)>0.9*pi||X(2,i)<-0.9*pi)
            u_nn(i)=-0.6;
        elseif X_n(4,i)>=0&&(X(2,i)>0.9*pi||X(2,i)<-0.9*pi)
            u_nn(i)=0.6;
        end
    elseif jjj(i)==0
        % �U��q���艻�̂��߂�LQR�����
        u_nn(i)=-K*X(:,i);
    end
    % rungekutta
    K1=rungekutta(X_n(:,i),u_nn(i),dt);
    K2=rungekutta(X_n(:,i)+0.5*K1,u_nn(i),dt);
    K3=rungekutta(X_n(:,i)+0.5*K2,u_nn(i),dt);
    K4=rungekutta(X_n(:,i)+K3,u_nn(i),dt);
    X_n(:,i+1) = X_n(:,i)+(K1+2*K2+2*K3+K4)/6;
end


%% ���ʂ̕\��
figure(3)
plot(T,X_n(:,1:length(T)))
legend('x', 'th', 'dx', 'dth');grid on
title('�e��ԗʂ̎���������')

figure(4)
plot(T,u_nn)
title('������͂̎�����')

figure(5)
plot(T,jjj)
title('�j���[�����l�b�g�̏o�͂̎������i0�F���艻�C1�F�U��グ�j')

% -�΁`�΂̊ԂŐ��K�����ꂽ�p�x�̎�����
figure(6)
plot(T,X(2,1:length(T)))
title('�U�q�p�x�̎�����')
%% �A�j���[�V�����̕\��

figure('Position',[100 100 500 500]);
bar=animatedline;
car=animatedline;
height=0.1;
width=0.15;

for k=1:length(T)
    clearpoints(bar);
    clearpoints(car);
    axis([X_n(1,k)-0.25 X_n(1,k)+0.25 -0.25 0.25])
    addpoints(bar,X_n(1,k),0);
    addpoints(bar,X_n(1,k)+L*sin(X_n(2,k)),L*cos(X_n(2,k)));
    addpoints(car,X_n(1,k)-width/2,-height/2);
    addpoints(car,X_n(1,k)+width/2,-height/2);
    addpoints(car,X_n(1,k)+width/2,+height/2);
    addpoints(car,X_n(1,k)-width/2,+height/2);
    addpoints(car,X_n(1,k)-width/2,-height/2);
    
    drawnow
end
