/**
 * intersect(+List1:list,+List2:list,?List3:list).
 * 
 * Succeeds if the third list is the intersection of the first two.
 *
 * @param List1 The first list.
 * @param List2 The second list.
 * @param List3 The list containing all the elements existing in both List1 and List2.
 *
 * Examples:
 *
 * ?- intersect([a,b,c],[b,c,d],[c,d]).
 * fail
 *
 * ?- intersect([a,b,c],[b,c,d],[b,c]).
 * true
 *
 * ?- intersect([a,b,c],[b,c,d],X).
 * [X = [b,c]]
 *
 * ?- intersect([],[a,b],X).
 * [X = []]
 */
member(X|[X|_]).
member(X|[_|T]) :- member(X|T).
intersect([],_,[]).
intersect(_,[],[]).
intersect([H1|T1],T2,[H1|T3]) :-
	 member(H1,T2),!,intersect(T1,T2,T3).
intersect([_|T1],T2,T3) :- intersect(T1,T2,T3).

/**
 * smallest(+List:list,?Value:int).
 *
 * Succeeds if the value of the second parameter is the smallest element in the list as the first parameter.
 *
 * @param List  The list from which to find out the smallest element.
 * @param Value the value of smallest element in the list.
 *
 * Examples:
 *
 * ?- smallest([4,5,1,7],4).
 * fail
 * 
 * ?- smallest([4,5,1,7],1).
 * true
 * 
 * ?- smallest([4,5,1,7],X).
 * [X = 1]
 * 
 * ?- smallest([2],X).
 * [X = 2]
 *
 * ?- smallest([],X).
 * fail
 */
min([H|T],A,Min) :- H >= A, min(T,A,Min).
min([H|T],A,Min) :- H < A, min(T,H,Min).
min([],A,A).
smallest(List,Min) :- 
	List = [H|_], min(List,H,Min).

/**
 * last_element(+List:list,?Value:atom).
 *
 * Succeeds if the value of the second parameter is the last element in the list as the first parameter.
 *
 * @param List  The list from which to find out the last element.
 * @param Value the value of last element in the list.
 *
 * Examples:
 *
 * ?- last_element([a,e,f,d],a).
 * fail
 * 
 * ?- last_element([a,e,f,d],d).
 * true
 * 
 * ?- last_element([a,e,f,d],X).
 * [X = d]
 * 
 * ?- last_element([a],X).
 * [X = a]
 *
 * ?- last_element([],X).
 * fail
 */
last_element(List,Last) :- 
	List = [_|T], last_element(T,Last).
last_element(List,X) :- List = [X|[]].

/**
 * pair(+Key:atom, ?Value:atom, ?List:list).
 * 
 * Succeeds if the list as the third parameter contains the value of the first parameter as its first element
 * and the value of the second parameter as its second element.
 *
 * @param Key  The Key to relate with another value.
 * @param Value The value to relate with Key.
 * @param List The list contain the key as its first element and value as its second elment.
 *
 * Examples:
 *
 * ?- pair(a,3,[a,4]).
 * fail
 * 
 * ?- pair(a,3,[a,3]).
 * true
 * 
 * ?- pair(a,3,X).
 * [X = [a,3]]
 * 
 * ?- pair(a,Y,[a,3]).
 * [Y = 3]
 *
 * ?- pair(Z,3,[a,3]).
 * [Z = a]
 * 
 * ?- pair(X,Y,[a,3]).
 * [X = a, Y = 3]
 */

pair(Key,Value,Dict) :- 
	Dict = [X,Y|[]], Key = X, Value = Y.

/**
 * cross_product(+List1:list, +List2:list, ?List3:list).
 *
 * Succeeds if the list as the third parameter is the list of Key/Value pairs created by combining the first two arguments pairwise.
 * 
 * @param List1  The Key list.
 * @param List2  The value list.
 * @param List3 the list of Key/Value pairs.
 *
 * Examples:
 *
 * ?- cross_product([a,e,f,d],[1,4,3,2],[[a,1],[e,4],[f,3],[d,0]]).
 * fail
 * 
 * ?- cross_product([a,e,f,d],[1,4,3,2],[[a,1],[e,4],[f,3],[d,2]]).
 * true
 * 
 * ?- cross_product([a,e,f,d],[1,4,3,2],X).
 * [X = [[a,1],[e,4],[f,3],[d,2]]]
 *
 * ?- cross_product([a,e,f,d],Y,[[a,1],[e,4],[f,3],[d,2]]).  
 * [Y = [1,4,3,2]]
 *
 * ?- cross_product(Z,[1,4,3,2],[[a,1],[e,4],[f,3],[d,2]]). 
 * [Z = [a,e,f,d]]
 *
 * ?- cross_product([],[],X).
 * [X = []]
 *
 */
cross_product([H1|Klist],[H2|Vlist],[H3|Dlist]) :- 
	pair(H1,H2,H3), cross_product(Klist,Vlist,Dlist).
cross_product([],_,[]).
