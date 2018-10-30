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

coursPrerequis(A, B) :- prerequis(A, B).
coursPrerequis(A, B) :-
					prerequis(A, X),
					coursPrerequis(X, B).

coursCorequis(A, B) :- corequis(A, B).
coursCorequis(A, B) :-
					corequis(A, X),
					coursCorequis(X, B).

coursRequis(A, B) :- (corequis(A, B) ; prerequis(A, B)).
coursRequis(A, B) :-
					(corequis(A, X) ; prerequis(A, X)),
					coursRequis(X, B).

courAPrendreComplet(C, L) :- setof(X, coursRequis(C, X), L).
