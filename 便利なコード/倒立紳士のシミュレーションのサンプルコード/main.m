%% 倒立振り子の振り上げ安定化
%% 方針
%{
1.振り上げ用の制御器と，安定化用の制御器を用意する
2.二つの制御器のうち，どちらの制御器を使うかを決めるニューラルネットワークを作成
 ==>NNの入力は現在の状態量，出力は二つの制御器のうちどちらを使うか
%}
clear
close all

%% 倒立振子のモデル
M=0.1;        % Mass of daisya
m=0.023;      % Mass of bar
J=3.20e-4;	% Inertia moment
L=0.2;		% Length
mu=2.74e-5;	% Damping coefficient
zeta=240;     % Physical parameter of DC motor
xi=90;		% Physical parameter of DC motor
g=9.81;       % Gravity accel.

%% 最適レギュレータ法による状態フィードバックゲインの設計
% 線形化→状態方程式→lqrによるゲイン決定
p1=m*L/(J+m*L*L); p2=mu/(J+m*L*L);
A=[0 0 1 0;0 0 0 1;0 0 -zeta 0; 0 p1*g p1*zeta -p2];
B=[0;0;xi;-p1*xi];
C=[1 0 0 0;0 1 0 0];
D=[0;0];
Q=diag([1,10,1,10]);
r=10;
K=lqr(A,B,Q,r);

%% 数値シミュレーション
% 様々な初期角度から検証
% x0=[0;pi;0;0]; % 初期値
% x0=[0;pi/2;0;0]; % 初期値
% x0=[0;pi/3;0;0]; % 初期値
% x0=[0;pi/4;0;0]; % 初期値
% x0=[0;pi*2/3;0;0]; % 初期値
x0=[0;pi*3/4;0;0]; % 初期値
dt=0.005;
T=0.0:dt:8;
tsize = size(T,2);

%% ネットワークの定義
net=perceptron;
net=configure(net,zeros(2,1),0);

%% ネットワークに重みを代入
load('bchrom3.mat'); % 学習済みパラメータを読み込み
net.IW{1,1}=bchrom; % 重み
net.b{1}=-1; % バイアス？

%% 数値計算
u_nn=zeros(length(T),1);
X_n=zeros(4,length(T)+1);
X_n(:,1)=x0;

for i=1:length(T)
    % 角度情報を-π～πの範囲に修正
    X(:,i)=X_n(:,i);
    X(2,i)=rem(X(2,i),2*pi);
    if X(2,i)>pi
        X(2,i)=X(2,i)-2*pi;
    end
    if X(2,i)<-pi
        X(2,i)=X(2,i)+2*pi;
    end
    
    % ネットワークの値に応じて振り上げ，安定のどちらの制御器を使うかを判定
    % 0→安定化，1→振り上げ
    jjj(i)=sim(net,[X(2,i)^2;X(4,i)^2]); % jjj(i)に0か1が格納されます
    
    if jjj(i)==1
        % 振り上げのためのbang-bang制御器
        if X_n(4,i)<0&&(X(2,i)>0.9*pi||X(2,i)<-0.9*pi)
            u_nn(i)=-0.6;
        elseif X_n(4,i)>=0&&(X(2,i)>0.9*pi||X(2,i)<-0.9*pi)
            u_nn(i)=0.6;
        end
    elseif jjj(i)==0
        % 振り子安定化のためのLQR制御器
        u_nn(i)=-K*X(:,i);
    end
    % rungekutta
    K1=rungekutta(X_n(:,i),u_nn(i),dt);
    K2=rungekutta(X_n(:,i)+0.5*K1,u_nn(i),dt);
    K3=rungekutta(X_n(:,i)+0.5*K2,u_nn(i),dt);
    K4=rungekutta(X_n(:,i)+K3,u_nn(i),dt);
    X_n(:,i+1) = X_n(:,i)+(K1+2*K2+2*K3+K4)/6;
end


%% 結果の表示
figure(3)
plot(T,X_n(:,1:length(T)))
legend('x', 'th', 'dx', 'dth');grid on
title('各状態量の時刻歴応答')

figure(4)
plot(T,u_nn)
title('制御入力の時刻歴')

figure(5)
plot(T,jjj)
title('ニューラルネットの出力の時刻歴（0：安定化，1：振り上げ）')

% -π～πの間で正規化された角度の時刻歴
figure(6)
plot(T,X(2,1:length(T)))
title('振子角度の時刻歴')
%% アニメーションの表示

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
