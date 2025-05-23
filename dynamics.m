syms d1 t2 d3 l1 l3 m1 m2 m3 
syms d1_prim t2_prim d3_prim
syms Ixx1 Iyy1 Izz1 Ixx2 Iyy2 Izz2 Ixx3 Iyy3 Izz3 
syms g


Jv1 = [0 0 0;
       0 0 0;
       1 0 0];

Jw1 = [0 0 0;
       0 0 0;
       0 0 0];

Jv2 = [0 -sin(t2)*(d3+l3) 0;
       0 cos(t2)*(d3+l3) 0;
       1 0 0;];

Jw2 = [0 0 0;
       0 0 0;
       0 1 0];

Jv3 = [0 -sin(t2)*(d3+l3) cos(t2);
       0 cos(t2)*(d3+l3) sin(t2);
       0 0 0];

Jw3 =[0 0 0;
      0 0 0;
      0 1 0];

R01=[1 0 0;
     0 1 0;
     0 0 1];

R02 =[-sin(t2) 0 cos(t2);
      cos(t2) 0 sin(t2);
      0 1 0];

R03 = [-sin(t2) 0 cos(t2);
      cos(t2) 0 sin(t2);
      0 1 0];

I1 = [Ixx1 0 0 ; 0 Iyy1 0 ; 0 0 Izz1];
I2 = [Ixx2 0 0 ; 0 Iyy2 0 ; 0 0 Izz2];
I3 = [Ixx3 0 0 ; 0 Iyy3 0 ; 0 0 Izz3];

% - D 

D1 = transpose(Jv1)*Jv1*m1 + transpose(Jw1)*R01*I1*transpose(R01)*Jw1

D2 = simplify(transpose(Jv2)*Jv2*m2 + transpose(Jw2)*R02*I2*transpose(R02)*Jw2)

D3 = simplify(transpose(Jv3)*Jv3*m3 + transpose(Jw3)*R03*I3*transpose(R03)*Jw3;

D = simplify(D1+D2+D3)

% - chris 
q=[d1,t2,d3];
C=sym(zeros(3,3,3));
for i=1:3
    for j=1:3
        for k=1:3
              C(i,j,k)=simplify(1/2*(diff(D(j,k),q(i))+diff(D(i,k),q(j))-diff(D(i,j),q(k))));
              
        end
    end
end


CH=sym(zeros(3,1));
q_prim = [d1_prim ;t2_prim ;d3_prim];
for k=1:3
    for i=1:3
        for j=1:3
            CH(k) = CH(k)+C(i,j,k)*q_prim(i)*q_prim(j);
        end
    end
end
CH=simplify(CH)


% G - energie potencjalna 
E1= m1*g*0.5*(d1+l1);
E2=m2*g*(d1+l1);
E3=m3*g*(d1+l1);
E=E1+E2+E3;


G1=diff(E,d1);
G2=diff(E,t2);
G3=diff(E,d3);

G=[G1;G2;G3]





