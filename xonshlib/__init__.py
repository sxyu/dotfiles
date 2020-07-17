from scipy.special import comb
class permu():
    @staticmethod
    def eye(n = 0):
        return permu(*range(1, n+1))
    @staticmethod
    def all(n):
        from itertools import permutations
        return list(map(lambda x : permu([*x]), permutations(range(1, n+1))))
    def __init__(self, *args):
        if len(args) == 0:
            # empty (identity)
            self.per = []
        elif type(args[0]) is int:
            # single cycle
            cyc = args
            self.per = list(range(1, max(cyc)+1))
            for i in range(len(cyc)):
                self.per[cyc[i] - 1] = cyc[(i+1)%len(cyc)]
        elif type(args[0]) is tuple: 
            # many cycles
            perm = permu.eye()
            for cyc in args:
                perm = perm * permu(*cyc)
            self.per = perm.per
        elif type(args[0]) is list: 
            # permutation
            self.per = args[0]
    def __len__(self):
        return len(self.per)
    def __getitem__(self, index):
        if index - 1 >= len(self.per):
          return index
        return self.per[index - 1]
    def __rmul__(self, other):
        if type(other) is list:
            result = []
            for otherp in other:
                result.append(otherp * self)
            return result
        else:
            raise NotImplemented
    def __mul__(self, other):
        if type(other) is list:
            result = []
            for otherp in other:
                result.append(self * otherp)
            return result
        else:
            result = []
            for i in range(1, max(len(self.per), len(other.per))+1):
                result.append(self[other[i]])
            return permu(result)
    def inv(self):
        result_per = self.per[:]
        for i in range(len(self.per)):
            result_per[self.per[i] - 1] = i+1
        return permu(result_per)
    def __pow__(self, p):
        g = self
        if p < 0:
            p = -p
            g = self.inv()
        result = permu.eye()
        for i in range(p):
            result = result * g
        return result
    def to_cycles(self):
        cycles = []
        seen = set()
        for i in range(1, len(self.per)+1):
            if i not in seen:
                cycle = [i]
                j = self.per[i-1]
                seen.add(i)
                while j != i:
                    cycle.append(j)
                    seen.add(j)
                    j = self.per[j-1]
                if len(cycle) > 1:
                    cycles.append(tuple(cycle))
        return cycles
    def __repr__(self):
        cycs = self.to_cycles()
        if not cycs:
            return '()'
        return ''.join(map(str, cycs))
    def is_eye(self):
        for i in range(len(self.per)):
            if self.per[i] != i+1:
                return False
        return True
    def genr(self):
        result = [permu.eye()]
        k = self
        while not k.is_eye():
            result.append(k)
            k = k * self
        return result

import numpy as np
#from matplotlib import pyplot as plt
import sympy as sp
from sympy import symbols
#import numpy.linalg as la
arange = np.arange
array = np.array
def zeros(*argv): return np.zeros((argv))
def ones(*argv): return np.ones((argv))
eye = np.eye
randarr = np.random.rand
randn = np.random.randn

def intlist(x, spl=' '):
    return list(map(int, x.split(spl)))
    
def fltlist(x, spl=' '):
    return list(map(float, x.split(spl)))
    
def lrev(x):
    return list(reversed(x))
    
def lsort(x):
    return list(sorted(x))
    
def lmap(f, x):
    return list(map(f, x))

def choose(n, k):
    return (0 if k > n or k < 0 else fact(n)//(fact(k) * fact(n-k)))
    #  return comb(n,k) # WTF not integer
    
def modinv(x, m):
    return pow(x, m-2, m)

def primefact(x):
    st = []
    i = 2
    while i * i <= x:
        if x % i == 0:
            st.append(i)
            while x % i == 0:
                x //= i
            if x < 2:
                break
        i += 1
    if x > 1:
        st.append(x)
    return sorted(st)
    
def factor_num(x):
    st = []
    i = 1
    while i * i <= x:
        if x % i == 0:
            st.append(i)
            if i*i != x: st.append(x//i)
        i += 1
    return sorted(st)
            
def binstr(len):
    return [y for x in product(*[[0,1]]*len) for y in x]

def binstrl(len):
    return list(binstr(len))

def runlen(x):
    # longest subarray of equal elements
    runl, lrunl = 1, 1
    for i in range(1, len(x)):
        if x[i] == x[i-1]:
            runl += 1
            lrunl = max(runl, lrunl)
        else:
            runl = 1
    return lrunl
    
def ispalin(x):
    for i in range(len(x)//2):
        if x[i] != x[len(x)-i-1]: return False
    return True

def lis(x, nd = False, inv = False):
    from sortedcontainers import SortedList
    sl = SortedList(key = lambda x: -x) if inv else SortedList()
    for i in x:
        sl.add(i)
        if nd:
            j = sl.bisect_right(i)
        else:
            j = sl.bisect_left(i) + 1
        if j < len(sl): sl.pop(j)
    return len(sl)

def symbx():
    global a,b,c,d,r,u,v,w,x,y,z,n,m
    a,b,c,d,r,u,v,w,x,y,z,n,m = symbols('a b c d r u v w x y z n m')
    init_printing()
    print('Symbolic mode')
from math import pi,sqrt,sin,cos,tan,log2,log10,factorial as fact
