%% q计算时要加上thet，其他的正常，结果已经验证

syms q1 q2 q3 q4 q5 q6 dq1 dq2 dq3 dq4 dq5 dq6
q=[q1 q2 q3 q4 q5 q6];
dq=[dq1 dq2 dq3 dq4 dq5 dq6];
q1=[q2 q3 q4 q5 q6];

alpha=[0        -pi/2  pi     pi     -pi/2  pi/2  ];%这一块跟我建立的运动学模型不太一致如果不改变的话到时候力方向要改变
a =   [0        0      0.408  0.376  0      0     ];
d =   [0.1215   0.1215 0      0      0.1025 0.094 ];
thet =[0        -pi/2  0      -pi/2  0      0     ];
%此处theta2 theta4的offset是由于工具箱与半物理模型存在差异theta1的offset是真实存在的情况
dh=[alpha;a;d;thet];
rob=[0 0 0 0 0 0];
Pc=zeros(3,6);
Pc(:,1) = [3.250886897473500e-07,0.005349553492961,-0.008836893256111];
Pc(:,2) = [0.203996646979614,2.013045850365440e-10,0.012764154539598];
Pc(:,3) = [0.188922115560337,6.788824347390720e-07,0.098102674046156];
Pc(:,4) = [7.542051374285920e-07,0.006248125433126,-0.003923674640724];
Pc(:,5) = [-7.542076205786350e-07,-0.006248125426173,-0.003923674641157];
Pc(:,6) = [3.920487784499380e-10,1.757880572814670e-04,-0.021329449070668];
m = [1.576583486939290;4.041757822654940;2.271456690983430;0.500477539188764;0.500477539245988; 0.158309554874285]; 
g=9.81;
Ic = zeros(3,3,6);
Ic(:,:,1)  = [4.064e-3 0         0;
              0        3.9286e-3 0.1602e-3;
              0        0.1602e-3 3.087e-3];
Ic(:,:,2)  = [9.654e-3 0     0 ;
              0        0.145 0; 
              0        0     0.1426];
Ic(:,:,3)  = [2.1432e-3  0       0.7312e-3;
              0          0.04439 0;
              0.7312e-3 0        0.04413];
Ic(:,:,4)  = [0.7119e-3 0         0 ;
              0         0.4059e-3 2.3081e-5;
              0         2.3081e-5 0.6856e-3];
Ic(:,:,5)  = [0.7119e-3 0          0;
              0         0.4059e-3  -2.3081e-5; 
              0         -2.3081e-5 0.6856e-3];
Ic(:,:,6)  = [7.3138e-5 0         0 ;
              0         7.1953e-5 0 ;
              0         0         0.1088e-3]; 
          
[M,C,G] = Lagrange_InverseDynamics(dh,rob,Pc,Ic,g,m,q,dq)
matlabFunction(M,'File','autogen/M_mtrx_fcn','Vars',{q},'Optimize', true);
matlabFunction(C,'File','autogen/C_mtrx_fcn','Vars',{dq,q},'Optimize', true);
matlabFunction(G,'File','autogen/G_mtrx_fcn','Vars',{q1},'Optimize', true);