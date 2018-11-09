%% BASE DE CONNAISSANCE

cours(inf1600).
cours(inf1900).
cours(inf2205).
cours(log1000).
cours(inf1005C).
cours(inf1500).
cours(inf1010).
cours(inf2010).
cours(inf2705).
cours(log2410).
cours(log2810).
cours(log2990).
cours(mth1007).

prerequis(inf1010,inf1005C).
prerequis(log1000,inf1005C).
prerequis(inf2705,inf2010).
prerequis(inf2010,inf1010).
prerequis(inf1600,inf1005C).
prerequis(inf1600,inf1500).
prerequis(log2410,log1000).
prerequis(log2410,inf1010).

corequis(inf2010,log2810).
corequis(inf2705,log2990).
corequis(inf2705,mth1007).
corequis(inf1900,log1000).
corequis(inf1900,inf1600).
corequis(inf1900,inf2205).

% symetrie de la propriete corequis. Cette forme permet de ne pas faire de suppositions supplementaire sur l'ordre lexicographique entre X et Y.
corequisSym(X,Y) :- corequis(X,Y) ; corequis(Y,X).

% propriete generale : requis
requis(X,Y) :- prerequis(X,Y) ; corequisSym(X,Y).

% L correspond a la liste permettant a la recursion de garder en memoire les variables deja comptees comme requises pour eviter une boucle infinie
% On initialise L a la liste vide (L = [])
% A est fixe, B est notre variable de retour
coursRequis(A, B, L) :-
						% on ne teste pas prerequis si deja corequis
						requis(A,B),
						% on verifie que B n'est pas dans L (non necessaire, mais evite des calculs redondants)
						not(member(B, L)).
coursRequis(A, B, L) :-
					% on trouve un cours X qui est requis pour A
					requis(A,X),
					% on cherche recursivement un cours B requis pour X s'il n'est pas deja dans la liste L
					not(member(X, L)),
					coursRequis(X, B, [X|L]),
					% on verifie que A est different de B maintenant que B est instancie
					A \= B.



coursAPrendreComplet(C, L) :- setof(X, coursRequis(C, X, []), L).
