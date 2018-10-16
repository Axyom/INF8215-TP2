int: nc = 5; %nombre de cases du pb
include "alldifferent.mzn";

% relations entre les nombres et les attributs :

% Nationalite :
% 1 - Anglais
% 2 - Espagnol
% 3 - Ukrainien
% 4 - Norvegien
% 5 - Japonais

% Animal
% 1 - Chien
% 2 - Escargot
% 3 - Renard
% 4 - Cheval
% 5 - Zebre (Nous le supposons)

% var [anglais, espagnol, ukrainien, norvegien, japonais] : Nationalite;
% var [eau, jus, the, cafe, lait] : Boisson;
% var [zebre, chien, escargot, renard, cheval] : Animal;
% var [rouge, vert, jaune, bleu, blanc] : CouleurMaison;
% var [sculpteur, diplomate, medecin, violoniste, acrobate] : Metier
% var array[Nationalite, Boisson, Animal, CouleurMaison, Metier] : Case
% var array[1..nbm] of var Case : cases; % state space

var 1..nc : anglais; 
var 1..nc : espagnol;
var 1..nc : ukrainien; 
var 1..nc : norvegien; 
var 1..nc : japonais;
var 1..nc : eau;
var 1..nc : jus; 
var 1..nc : the; 
var 1..nc : cafe; 
var 1..nc : lait; 
var 1..nc : zebre; 
var 1..nc : chien; 
var 1..nc : escargot; 
var 1..nc : renard;
var 1..nc : cheval; 
var 1..nc : rouge; 
var 1..nc : vert; 
var 1..nc : jaune; 
var 1..nc : bleu; 
var 1..nc : blanc; 
var 1..nc : sculpteur; 
var 1..nc : diplomate; 
var 1..nc : medecin; 
var 1..nc : violoniste; 
var 1..nc : acrobate;

constraint anglais = rouge;
constraint espagnol = chien;
constraint vert = cafe;
constraint ukrainien = the;
constraint vert = blanc+1;
constraint sculpteur = escargot;
constraint diplomate = jaune;
constraint lait = 3;
constraint norvegien = 1;
constraint ((medecin = renard+1) \/ (medecin = renard-1));
constraint ((diplomate = cheval-1) \/ (diplomate = cheval+1));
constraint violoniste = jus;
constraint japonais = acrobate;
constraint ((norvegien = bleu-1) \/ (norvegien = bleu+1));
constraint alldifferent([anglais, espagnol, ukrainien, norvegien, japonais]);
constraint alldifferent([eau, jus, the, cafe, lait]);
constraint alldifferent([zebre, chien, escargot, renard, cheval]);
constraint alldifferent([rouge, vert, jaune, bleu, blanc]);
constraint alldifferent([sculpteur, diplomate, medecin, violoniste, acrobate]);

solve satisfy;

%output if anglais == eau then show("anglais") elseif espagnol == eau then show("espagnol") elseif ukrainien == eau then show("ukrainien") elseif norvegien == eau then show("norvegien") elseif japonais == eau then show("japonais") else " " endif;

