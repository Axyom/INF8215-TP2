% Student exercise profile
:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space
:- discontiguous anglais/1.
:- discontiguous politicien/1.
% Your program goes here
/*ask(vivant) :-
  format('Est-il vivant ? '),
  read(Reponse),
  Reponse = 'oui'.
ask(artiste) :-
  format('Est ce un artiste? '),
  read(Reponse),
  Reponse = 'oui'.
ask(fictif) :-
  format('Est il fictif? '),
  read(Reponse),
  Reponse = 'oui'.
ask(anglais) :-
  format('Est il anglophone? '),
  read(Reponse),
  Reponse = 'oui'.
ask(jeux) :-
  format('Est ce un personnage de jeux-video? '),
  read(Reponse),
  Reponse = 'oui'.
ask(chant) :-
  format('Est ce un/e chanteur/chanteuse? '),
  read(Reponse),
  Reponse = 'oui'.
ask(cinema) :-
  format('Est-il dans le monde du cinema? '),
  read(Reponse),
  Reponse = 'oui'.
ask(ecrire) :-
  format('Est ce un/e auteur? '),
  read(Reponse),
  Reponse = 'oui'.
ask(homme) :-
  format('Est ce un hommme? '),
  read(Reponse),
  Reponse = 'oui'.
ask(femme) :-
  format('Est ce une femme? '),
  read(Reponse),
  Reponse = 'oui'.
ask(politicien) :-
  format('Est ce un/une politician/nne? '),
  read(Reponse),
  Reponse = 'oui'.
ask(realisateur) :-
  format('Est ce un/une realisateur/trice? '),
  read(Reponse),
  Reponse = 'oui'.
ask(sport) :-
  format('Fais-il du sport? '),
  read(Reponse),
  Reponse = 'oui'.
ask(religieux) :-
  format('Est ce un religieux? '),
  read(Reponse),
  Reponse = 'oui'.
ask(art, X) :-
  format('Est ce un artiste de ~w ? ', [X]),
  read(Reponse),
  Reponse = 'oui'.
ask(gouverne, Y) :-
  format('Gouverne-t il le ~w  ? ', [Y]),
  read(Reponse),
  Reponse = 'oui'.
ask(religion, Y) :-
  format('Est-il ~w  ? ', [Y]),
  read(Reponse),
  Reponse = 'oui'.
*/

ask(X) :-
  format('A t il cet attribut: ~w  ? ', [X]),
  read(Reponse),
  Reponse = 'oui'.

ask(X,Y) :-
  format('~w de ~w ? ', [X,Y]),
  read(Reponse),
  Reponse = 'oui'.

personne(X) :- ask(vivant), vivant(X).
personne(X) :- ask(politicien), politicien(X).
personne(X) :- ask(religieux), religieux(X).
personne(X) :-  ask(chant),chanteur(X).
personne(X) :- sportif(X), mort(X).

vivant(X) :-  (ask(artiste),artiste(X));(ask(fictif),fictif(X));(ask(religieux),chretien(X);(ask(russe),russe(X));(ask(sportif),(sportif(X),vit(X))));createur(X).
fictif(X) :- (ask(anglais), anglais(X));jeux(X).
anglais(X) :- ask(jeux),jeuxA(X).

artiste(X) :- (   ask(homme), artisteH(X));artisteF(X).

artisteF(X) :-  ask(cinema), actrice(X).
artisteF(X) :-  (ask(litterature), auteure(X));chanteuse(X).

artisteH(X) :-  (ask(cinema), cinema(X));( peintre(X) ).
cinema(X) :- (ask(realisateur), realisateur(X));acteur(X).

politicien(X):- ask(anglais),((ask(raciste), raciste(X));(non_raciste(X))).
politicien(X) :- (ask(russe),gouverne(X,urss));((ask(homme),auteur(X));gouverne(X,egypt)).
religieux(X) :-  prophete(X,Y), religion(Y), ask(religion,Y).


sportif(fernando_alonso).
vit(fernando_alonso).
sportif(ayrton_senna).
mort(ayrton_senna).
peintre(bansky).
createur(hideo_Kojima).
chretien(pape_francois).
prophete(moise,juif).
prophete(jesus,chretien).
anglais(james_bond).
jeux(mario).
jeuxA(lara_croft).
chanteuse(celine_dion).
chanteur(michael_Jackson).
auteure(j_k_Rowling).
auteur(victor_Hugo).
raciste(richard_nixon).
non_raciste(dwighlight_D_eisenhower).
actrice(jennifer_lawence).
realisateur(quentin_Tarantino).
acteur(denzel_Washinton).
russe(mikhail_Gorbachev).
/*gouverne(mikhail_Gorbachev,urss).*/
gouverne(joseph_staline,urss).
gouverne(dwighlight_D_eisenhower,usa).
gouverne(richard_nixon,usa).
gouverne(cleopatre,egypt).
pays(urss).
pays(usa).
pays(egypt).
religion(juif).
religion(chretien).

/** <examples> Your example queries go here, e.g.
?- member(X, [cat, mouse]).
*/
