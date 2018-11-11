% Student exercise profile
:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space
:- discontiguous personne/1.
:-discontiguous metier_/1.
:- discontiguous politicien/1.
:- discontiguous artiste/1.
:- discontiguous chanteur/1.
:- discontiguous acteur/1.
:- discontiguous auteur/1.
:- discontiguous realisateur/1.
:- discontiguous peintre/1.
:- discontiguous createur/1.
:- discontiguous jeux_video/1.
:- discontiguous gouverne/2.
:- discontiguous confession/2.
:- discontiguous sportif/1.
:- discontiguous homme/1.
:- discontiguous fictif/1.
:- dynamic(known/3).

personne_(michael_Jackson).
personne_(mikhail_Gorbachev).
personne_(jennifer_Lawrence).
personne_(hideo_Kojima).
personne_(banksy).
personne_(lara_Croft).
personne_(mario).
personne_(j_K_Rowling).
personne_(lady_Gaga).
personne_(quentin_Tarantino).
personne_(joseph_Staline).
personne_(dwight_D_Eisenhower).
personne_(cleopatre).
personne_(victor_Hugo).
personne_(jesus).
personne_(ayrton_Senna).
personne_(moise).
personne_(fernando_Alonso).
personne_(pape_Francois).
personne_(james_Bond).
personne_(denzel_Washington).
personne_(richard_Nixon).

personne_(donald_trump).

/********  metierS *****************/
vivant(jennifer_Lawrence).
vivant(hideo_Kojima).
vivant(banksy).
vivant(lara_Croft).
vivant(mario).
vivant(j_K_Rowling).
vivant(lady_Gaga).
vivant(quentin_Tarantino).
vivant(fernando_Alonso).
vivant(pape_Francois).
vivant(james_bond).
vivant(denzel_Washington).
vivant(mikhail_Gorbachev).
vivant(donald_trump).
/************homme ****************/
homme(michael_Jackson).
homme(mikhail_Gorbachev).
homme(hideo_Kojima).
homme(banksy).
homme(mario).
homme(quentin_Tarantino).
homme(joseph_Staline).
homme(dwight_D_Eisenhower).
homme(victor_Hugo).
homme(jesus).
homme(ayrton_Senna).
homme(moise).
homme(fernando_Alonso).
homme(pape_Francois).
homme(james_bond).
homme(denzel_Washington).
homme(richard_Nixon).
homme(donald_trump).
/****** ARTISTES ***********/
/*******chanteurs**********/
chanteur(michael_Jackson).
chanteur(lady_Gaga).
/****** acteurs***********/
acteur(jennifer_Lawrence).
acteur(denzel_Washington).
/******* auteurs********/
auteur(j_K_Rowling).
auteur(victor_Hugo).
/****** peintre *******/
peintre(banksy).
/*******Createur *****/
createur(hideo_Kojima).
/*******realisateur***/
realisateur(quentin_Tarantino).

/*********Politicien *********/
gouverne(richard_Nixon,usa).
gouverne(joseph_Staline,urss).
gouverne(dwight_D_Eisenhower,usa).
gouverne(mikhail_Gorbachev,urss).
gouverne(cleopatre,egypt).
gouverne(donald_trump,usa).
raciste(richard_Nixon).
pays(urss).
pays(usa).
pays(egypt).
/******* RELIGIEUX********/
confession(pape_Francois,chretien).
confession(moise,juif).
confession(jesus,chretien).
religion(chretien).
religion(juif).
/********FICTIF*******/
jeux_video(mario).
jeux_video(lara_Croft).
film(james_bond).
anglais(james_bond).
anglais(lara_Croft).
/******** Sportif *******/
sportif(ayrton_Senna).
sportif(fernando_Alonso).

%-----------------SUPER CLASSE: personnne------------%
artiste(X):- personne_(X).
politicien(X) :- personne_(X).
fictif(X) :- personne_(X).
religieux(X) :- personne_(X).
sportif(X) :- personne_(X).
%--------------- SOUS CLASSE DE ARTISTE -------------%
chanteur(X) :- artiste(X).
acteur(X) :- artiste(X).
auteur(X) :- artiste(X).
peintre(X) :- artiste(X).
createur(X) :- artiste(X).
realisateur(X) :- artiste(X).
%--------------SOUS CLASSE POLITICIEN ----------------%
gouverne(X,_) :- politicien(X).
%------------- SOUS CLASSE RELIGIEUX ----------------%
confession(X,_):- religieux(X).
%-------------SOUS CLASSE FICTIF--------------------%
fictif(X) :- jeux_video(X).
fictif(X) :- film(X).


ask(Attr, Val) :-
  known(oui, Attr, Val),
  !.

ask(Attr, Val) :-
  known(_, Attr, Val),
  !,
  fail.

ask(Attr, Val) :-
  format('Votre personnage a t-il ces attributs (~w : ~w) ? ', [Attr, Val]),
  read(Reponse),
  asserta(known(Reponse, Attr, Val)),
  Reponse == 'oui'.

personne_(X) :- ask(vivant,oui),((ask(homme,oui), metier_(X), homme(X));(metier_(X),not(homme(X)))),vivant(X).
personne_(X) :- ((ask(homme,oui), metier_(X), homme(X));(metier_(X),not(homme(X)))),not(vivant(X)).

metier_(X) :-  ask(artiste,oui),art(X).
metier_(X) :-  ask(fictif,oui),fictif_(X).
metier_(X) :-  ask(religieux,oui),confession(X,_).
metier_(X) :- ask(politicien,oui), politicien_(X).
metier_(X) :-  ask(sportif,oui),sportif(X).

fictif_(X) :- (ask(anglais,oui),jeux_films(X),anglais(X));( jeux_films(X),not(anglais(X))).
jeux_films(X) :- ((ask(jeux_video,oui),(jeux_video(X)));(film(X))).

art(X) :-  ask(litterature,oui), auteur(X).
art(X) :-  ask(chant,oui), chanteur(X).
art(X) :-  ask(cinema,oui), cinema(X).
art(X) :- ask(peintre,oui), peintre(X).
art(X) :- ask(createur_Jeux,oui),createur(X).              
cinema(X) :-   ask(acteur,oui), acteur(X).
cinema(X) :-   ask(realisateur,oui),realisateur(X). 


politicien_(X):- ask(gouverne,usa),((ask(raciste,oui), raciste(X));(gouverne(X,usa), not(raciste(X)))).
politicien_(X):- gouverne(X,Y), pays(Y), ask(gouverne,Y).
                                                           
religieux_(X) :-  religion(Y), ask(religion,Y), confession(X,Y).
