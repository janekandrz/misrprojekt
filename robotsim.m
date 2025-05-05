
robot = SerialLink([
    Prismatic('theta',0,'a', 0, 'alpha', 0, 'qlim', [0 2],'offset',1)  
    Revolute('d', 0, 'a', 0, 'alpha', pi/2, 'qlim', [-pi pi],'offset', pi/2)   
    Prismatic('theta', 0, 'a', 0, 'alpha', 0, 'qlim', [0 2],'offset',1) 
], 'name', 'PRP Robot')

q=[1 0 1];

% Wizualizacja
robot.plot(q, 'workspace', [-3 5 -3 3 0 4]);
hold on;

%%

%PRP Robot:: 3 axis, PRP, stdDH, fastRNE                          
%+---+-----------+-----------+-----------+-----------+-----------+
%| j |     theta |         d |         a |     alpha |    offset |
%+---+-----------+-----------+-----------+-----------+-----------+
%|  1|          0|         q1|          0|          0|          1|
%|  2|         q2|          0|          0|     1.5708|     1.5708|
%|  3|          0|         q3|          0|          0|          1|
%+---+-----------+-----------+-----------+-----------+-----------+

%%
syms d1 t2 d3
q_sym = [d1 t2 d3];

t1=robot.A(1,q_sym)

t2 = robot.A(2,q_sym)
z
t3 = robot.A(3,q_sym)

tfinal = robot.A(1:3,q_sym)

%for i=1:robot.n-1
%    t= robot.A(i:i+1,q_sym)
%end 

%%
T02 = robot.A(1:2,q_sym)
T03 = robot.A(1:3,q_sym)



%%

% Plot coordinate frames for each link
for i = 1:robot.n
    T = robot.A(1:i, q);  % Forward kinematics to the i-th link
    trplot(T, 'frame', sprintf('F%d', i), 'length', 1);
end


