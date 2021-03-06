/**
 * helper rules
 * same(List1:list,List2:list)
 * Succeeds if the second list is equal to the first list.
 */ 
same([],[]).
same([H1|X],[H2|Y]) :- H1 = H2, same(X,Y).

/**
 * helper rules
 * member(Key:atom,List1:list)
 * Succeeds if the key exists in the list gave as a second parameter.
 */ 
member(X,[X|Y]).
member(X,[_|Y]) :- member(X,Y).

/**
 * helper rules
 * right(Left:atom,Right:atom,List1:list)
 * Succeeds if both Left and Right exists in the List1, and Left is on the left of Right in that list.
 */ 
right(Left,Right,[Left,Right|_]).
right(Left,Right,[_|Y]) :- right(Left,Right,Y).

/**
 * helper rules
 * adjacent(X:atom,Y:atom,List1:list)
 * Succeeds if both X and Y exists in the List1, and X, Y are next to each other in that list. 
 */ 
adjacent(X,Y,S) :- right(X,Y,S); right(Y,X,S).

/** 
 * helper rules
 * are_unique(A:atom,B:atom,C:atom,D:atom,E:atom)
 * Succeed if A,B,C,D,E are different from each other
 */ 
are_unique(A, B, C, D, E) :-
	not(A=B),not(A=C), not(A=D),not(A=E),not(B=C),not(B=D),not(B=E),not(C=D),not(C=E),not(D=E).

/**
 * helper rules
 * Succeed when the guess information(parameters) are correct in the range as given.
 */ 
guess_house(Nationality,Pet,Drink,Dessert) :-
	member(Nationality,[englishman,japanese,norwegian,spaniard,ukrainian]),
	member(Pet,[dog,fox,horse,snails,zebra]),
	member(Drink,[coffee,milk,orange_juice,tea,water]),
	member(Dessert,[ice_cream,pie,cake,chocolate,mousse]).

/** guess
 * Succeed when the guess result fullfil the clues provided.
 *
 * Examples:
 *
 * ?- house_solution(Blue_Nationality,Blue_Pet,Blue_Drink,Blue_Dessert,Green_Nationality,Green_Pet,Green_Drink,Green_Dessert,Ivory_Nationality,Ivory_Pet,Ivory_Drink,Ivory_Dessert,Red_Nationality,Red_Pet,Red_Drink,Red_Dessert,Yellow_Nationality,Yellow_Pet,Yellow_Drink,Yellow_Dessert).
 * [Blue_Nationality = ukrainian, Blue_Pet = snails, Blue_Drink = tea, Blue_Dessert = ice_cream, Green_Nationality = spaniard, Green_Pet = dog, Green_Drink = coffee, Green_Dessert = cake, Ivory_Nationality = japanese, Ivory_Pet = horse, Ivory_Drink = milk, Ivory_Dessert = mousse, Red_Nationality = englishman, Red_Pet = fox, Red_Drink = orange_juice, Red_Dessert = chocolate, Yellow_Nationality = norwegian, Yellow_Pet = zebra, Yellow_Drink = water, Yellow_Dessert = pie]
 */
house_solution(
	Blue_Nationality,Blue_Pet,Blue_Drink,Blue_Dessert,
	Green_Nationality,Green_Pet,Green_Drink,Green_Dessert,
	Ivory_Nationality,Ivory_Pet,Ivory_Drink,Ivory_Dessert,
	Red_Nationality,Red_Pet,Red_Drink,Red_Dessert,
	Yellow_Nationality,Yellow_Pet,Yellow_Drink,Yellow_Dessert) :-
	    /* Define street */
		same([house(_,norwegian,_,_,_),_,
		      house(_,_,_,milk,_),_,_],Street),
		
	    /* Clues */
		member(house(red,englishman,_,_,_),Street),
		member(house(_,spaniard,dog,_,_),Street),
		member(house(green,_,_,coffee,_),Street),
		member(house(_,ukrainian,_,tea,_),Street),
		right(house(ivory,_,_,_,_),house(green,_,_,_,_),Street),
		member(house(_,_,snails,_,ice_cream),Street),
		member(house(yellow,_,_,_,pie),Street),
		adjacent(house(_,_,_,_,cake),house(_,_,fox,_,_),Street),
		adjacent(house(_,_,_,_,cake),house(_,_,horse,_,_),Street),
		member(house(_,_,_,orange_juice,chocolate),Street),
		member(house(_,japanese,_,_,mousse),Street),
		adjacent(house(_,norwegian,_,_,_),house(blue,_,_,_,_),Street),
		member(house(_,englishman,fox,_,_),Street),
	    
	    /* Define parameters */
		member(house(blue,Blue_Nationality,Blue_Pet,Blue_Drink,Blue_Dessert),Street),
		member(house(green,Green_Nationality,Green_Pet,Green_Drink,Green_Dessert),Street),
		member(house(ivory,Ivory_Nationality,Ivory_Pet,Ivory_Drink,Ivory_Dessert),Street),
		member(house(red,Red_Nationality,Red_Pet,Red_Drink,Red_Dessert),Street),
		member(house(yellow,Yellow_Nationality,Yellow_Pet,Yellow_Drink,Yellow_Dessert),Street),
		guess_house(Blue_Nationality,Blue_Pet,Blue_Drink,Blue_Dessert),
		guess_house(Green_Nationality,Green_Pet,Green_Drink,Green_Dessert),
		guess_house(Ivory_Nationality,Ivory_Pet,Ivory_Drink,Ivory_Dessert),
		guess_house(Red_Nationality,Red_Pet,Red_Drink,Red_Dessert),
		guess_house(Yellow_Nationality,Yellow_Pet,Yellow_Drink,Yellow_Dessert),
		are_unique(Blue_Nationality,Green_Nationality,Ivory_Nationality,Red_Nationality,Yellow_Nationality),
		are_unique(Blue_Pet,Green_Pet,Ivory_Pet,Red_Pet,Yellow_Pet),
		are_unique(Blue_Drink,Green_Drink,Ivory_Drink,Red_Drink,Yellow_Drink),
		are_unique(Blue_Dessert,Green_Dessert,Ivory_Dessert,Red_Dessert,Yellow_Dessert).
