/**
 * all_keys(List1:list, list2:list).
 *
 * Succeeds if the second parameter is equal to the list of keys in the first parameter.
 *
 * @param list1: a dictionary contain key and value pairs.
 * @param list2: a list of keys.
 *
 * Examples:
 *
 * ?- all_keys([[a,1],[b,2]],[a,b]).
 * true
 * 
 * ?- all_keys([[a,1],[b,2]],[a,c]).
 * fail
 *
 * ?- all_keys([[a,1],[b,2]],X).
 * [X = [a,b]]
 * 
 * ?- all_keys([],X).
 * [X = []]
 */
all_keys([],[]).
all_keys([Ht|T],[Hx|X]) :- Ht = [Hx|_], all_keys(T,X).

/**
 * all_values(List1:list, list2:list).
 *
 * Succeeds if the second parameter is equal to the list of values in the first parameter.
 *
 * @param list1: a dictionary contain key and value pairs.
 * @param list2: a list of values.
 *
 * Examples:
 *
 * ?- all_values([[a,1],[b,2]],[1,2]).
 * true
 * 
 * ?- all_values([[a,1],[b,2]],[1,4]).
 * fail
 *
 * ?- all_values([[a,1],[b,2]],X).
 * [X = [1,2]]
 * 
 * ?- all_values([],X).
 * [X = []] 
 */
all_values([],[]).
all_values([Ht|T],[Hy|Y]) :- Ht = [_,Hy], all_values(T,Y).

/**
 * define(key:atom, value:atom, list1:list, list2:list).
 *
 * Succeeds if the forth parameter list is the third parameter list with any existing definition as the second parameter of the specified key as first parameter removed, and the given key and value pair added at the front.
 *
 * @param key: a key used to specify for removing and adding in the new list.
 * @param value: a value used to spectify for removing and adding in the new list.
 * @param list1: a list of dictionary containing key and value pairs.
 * @param list2: a new list of dictionary moving the specified key and value to the most front.
 *
 * Examples:
 *
 * ?- define(b,2,[[a,1],[b,2]],[[b,2],[a,1]]).
 * true
 * 
 * ?- define(b,2,[[a,1],[b,2]],[[a,1],[b,2]]).
 * fail
 *
 * ?- define(b,3,[[a,1],[b,2]],[[b,3],[a,1]]).
 * true
 * 
 * ?- define(b,3,[],X).
 * [X = [[b,3]]]
 *
 * ?- define(b,2,[[a,1],[b,2]],X).
 * [X = [[b,2],[a,1]]]
 */ 
del(X,[X|T],T).
del(X,[Y|T],[Y|Tn]) :- del(X,T,Tn).
define(Key,Value,[[Key,Value]|T],[[Key,Value]|T]).
define(Key,Value,Old,[[Key,Value]|New]) :- 
	del([Key,_],Old,New).
define(Key,Value,Old,[[Key,Value]|Old]) :-
	\+ lookup(Key,_,Old).

/**
 * lookup(key:atom, value:atom, dict:list).
 *
 * Succeeds if the give key as first parameter and value as second parameter are the same as a pair within the dictionary.
 *
 * @param key: a key for lookup the dictionary.
 * @param value: a value for lookup the dictionary.
 * @param list: a dictionary for lookup the key and value.
 *
 * Examples:
 *
 * ?- lookup(a,1,[[b,3],[a,1]]).
 * true
 * 
 * ?- lookup(a,1,[[b,3],[a,2]]).
 * fail
 *
 * ?- lookup(a,X,[[b,3],[a,2]]).
 * [X = 2]
 * 
 * ?- lookup(X,3,[[b,3],[a,2]]).
 * [X = b]
 *
 * ?- lookup(a,3,[]).
 * fail 
 */
lookup(K,V,[[K,V]|_]).
lookup(K,V,[_|T]) :- lookup(K,V,T). 

/**
 * sublist(list1:list, start:int, end:int, list2:list).
 *
 * Succeeds if the sublist as forth parameter consists of all the elements in the list as first parameter beginning at index start as second parameter and ending at index end as third parameter.
 *
 * @param list1: an original list.
 * @param start: a beginning index for generating sublist.
 * @param end: an end index for generating sublist.
 * @param list2: a sublist.
 *
 * Examples:
 *
 * ?- sublist([a,b,c,d],0,3,[a,b,c]).
 * true
 * 
 * ?- sublist([a,b,c,d],0,3,[a,b,e]).
 * fail
 *
 * ?- sublist([a,b,c,d],1,2,[b]).
 * true
 * 
 * ?- sublist([a,b,c,d],-1,2,X).
 * [X = [a,b]]
 *
 * ?- sublist([a,b,c,d],1,6,[b,c,d]).
 * true
 *
 * ?- sublist([],0,1,X).
 * [X = []]
 */
sublist([],0,_,[]).
sublist([_|List],Start,End,Sublist) :-
	Start > 0, End >= Start,!,sublist(List,Start - 1, End - 1, Sublist).
sublist([H|List],Start,End,[H|Sublist]) :- 
	Start =< 0, End > 0,!,sublist(List,0,End - 1,Sublist).
sublist(_,0,_,[]).	
