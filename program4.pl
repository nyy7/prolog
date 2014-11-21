compute([],Sn,Sn).
compute(['+'|So],Sn,[A,B|S]) :- C is B+A,compute(So,Sn,[C|S]).
compute(['-'|So],Sn,[A,B|S]) :- C is B-A,compute(So,Sn,[C|S]).
compute(['*'|So],Sn,[A,B|S]) :- C is B*A,compute(So,Sn,[C|S]).
compute(['/mod'|So],Sn,[A,B|S]) :- C is truncate(B/A),D is mod(B,A),compute(So,Sn,[C,D|S]).
compute(['/'|So],Sn,[A,B|S]) :- C is truncate(B/A),compute(So,Sn,[C|S]).
compute(['mod'|So],Sn,[A,B|S]) :- C is mod(B,A),compute(So,Sn,[C|S]).
compute(['='|So],Sn,[A,B|S]) :- A is B,compute(So,Sn,[-1|S]);compute(So,Sn,[0|S]).
compute(['<'|So],Sn,[A,B|S]) :- B < A,compute(So,Sn,[-1|S]);compute(So,Sn,[0|S]).
compute(['and'|So],Sn,[A,B|S]) :- not(A is 0),not(B is 0),compute(So,Sn,[-1|S]);compute(So,Sn,[0|S]).
compute(['or'|So],Sn,[A,B|S]) :- A is 0, B is 0,compute(So,Sn,[0|S]);compute(So,Sn,[-1|S]).
compute(['swap'|So],Sn,[A,B|S]) :- compute(So,Sn,[B,A|S]).
compute(['dup'|So],Sn,[A|S]) :- compute(So,Sn,[A,A|S]).
compute(['over'|So],Sn,[A,B|S]) :- compute(So,Sn,[B,A,B|S]).
compute(['rot'|So],Sn,[A,B,C|S]) :- compute(So,Sn,[C,A,B|S]).
compute(['drop'|So],Sn,[A|S]) :- compute(So,Sn,S).
compute(['2swap'|So],Sn,[A,B,C,D|S]) :- compute(So,Sn,[C,D,A,B|S]).
compute(['2dup'|So],Sn,[A,B|S]) :- compute(So,Sn,[A,B,A,B|S]).
compute(['2over'|So],Sn,[A,B,C,D|S]) :- compute(So,Sn,[C,D,A,B,C,D|S]).
compute(['2drop'|So],Sn,[A,B|S]) :- compute(So,Sn,S).
compute([A|So],Sn,S) :- integer(A), compute(So,Sn,[A|S]).
interpret_FORTH_program(So,Sn) :-
	compute(So,Sn,[]).
