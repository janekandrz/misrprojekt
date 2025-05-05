import roboticstoolbox as rtb
import numpy as np
from spatialmath import *
from spatialmath.base.symbolic import *
from matplotlib import pyplot as plt
import sympy as sp

d1, t1, d3, l2 = symbol("d1, t1, d3, l2")


def Robot():

    robot = rtb.DHRobot([
        rtb.PrismaticDH(),  
        rtb.RevoluteDH(d=l2, a=0,),   
        rtb.PrismaticDH(theta=-np.pi/2, a=0, alpha=np.pi/2) 
    ])

    print(robot)

"""
┌────────┬─────┬────┬───────┐
│   θⱼ   │ dⱼ  │ aⱼ │  ⍺ⱼ   │
├────────┼─────┼────┼───────┤
│ 0.0°   │  q1 │  0 │  0.0° │
│  q2    │  l2 │  0 │  0.0° │
│ -90.0° │  q3 │  0 │ 90.0° │
└────────┴─────┴────┴───────┘
"""


def CalcForwordKin():

    A01 = SE3(0,0,d1)
    A12 = SE3.Rz(t1)*SE3(0,0,l2)
    A23 = SE3.Rz(-90,'deg')*SE3.Rx(90,'deg')*SE3(0,0,d3)

    A03 = A01*A12*A23 

    np.set_printoptions(precision=3,suppress=True)

    A03_simp = simplify(sp.Matrix(A03.A))
    precision_A03 = A03_simp.evalf(3)

    sp.pprint(precision_A03, use_unicode=True)

    
    


def main():
    #Robot()
    CalcForwordKin()

if __name__=="__main__":
    main()