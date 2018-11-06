% Description
% Dans notre tableau i correspond aux jours et j aux equipes
% Chaque cellule du tableau est un couple dont le premier element correspond a l equipe contre laquelle joue j
% et le deuxieme est un booleen indiquant si le match est a domicile pour j 
include "alldifferent.mzn";
int: nbTeams = 14; % Taille du problème
array [1..nbTeams, 1..nbTeams] of int: pv =[|
0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1|
1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1|
0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0|
0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0|
1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0|
1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0|
0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1|
1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0|
1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0|
1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1|
0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0|
0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0|
0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0|
0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0|];

set of int: Team = 1..nbTeams;  % on a nbTeams equipes de 1 à nbTeams 
set of int: Day = 1..nbTeams-1; % on a nbTeams-1 jours de 1 à nbTeams-1  

array [Day,Team] of var Team : Tableau;

% Predicats
predicate row_diff(int: r) = alldifferent([Tableau[r, c] | c in Team]); % Valeurs différentes sur la ligne r
predicate col_diff(int: c) = alldifferent([Tableau[r, c] | r in Day]); % Valeurs différentes sur la colonne c

% Contraintes
constraint forall (r in Day) (row_diff(r)); % Pas de répétition sur les lignes
constraint forall (c in Team) (col_diff(c)); % Pas de répétition sur les colonnes
constraint forall(i in Day, j in Team)(Tableau[i,Tableau[i,j]]= j /\ Tableau[i,j] != j); %Contrainte sur les equipes
constraint forall(j in Team) (
              forall(i in 1..nbTeams-5)(
                    let {var int: somme = pv[j,Tableau[i,j]]+pv[j,Tableau[i+1,j]]+pv[j,Tableau[i+2,j]]+pv[j,Tableau[i+3,j]]} in 
                    (
                      (somme != 4) /\ (somme != 0)
                   )
               )
         );


% Résolution du CSP
solve satisfy;

% Affichage
output [ show(Tableau[i,j])
            ++ (if (j mod nbTeams == 0) then "\n" else " " endif)
         | i in Day, j in Team ];