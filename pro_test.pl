are_unique(A,B,C) :- not( A = B), not(B = C), not(C = A).
same([],[]).
same([H1|X],[H2|Y]) :- H1 = H2, same(X,Y).
