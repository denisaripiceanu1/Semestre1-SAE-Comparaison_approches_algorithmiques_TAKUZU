with Grille;     use Grille;
with Coordonnee; use Coordonnee;
with Chiffre;    use Chiffre;
with Rangee;     use Rangee;

package Resolution_Takuzu is

   -- RÃ¨gle 1 : complÃ¨te la lignes l qui ont dÃ©jÃ 4 UN
   -- ou 4 ZERO
   procedure CompleterLigne
     (G : in out Type_Grille; L : in Integer; V : in Type_Chiffre);

   -- RÃ¨gle 1 : complÃ¨te les colonnes qui ont dÃ©jÃ 4 UN
   -- ou 4 ZERO
   procedure CompleterColonne
     (G : in out Type_Grille; Col : in Integer; V : in Type_Chiffre);

   procedure ResoudreDoubleHaut
     (G : in out Type_Grille; C : in Type_Coordonnee);

   procedure ResoudreDoubleBas
     (G : in out Type_Grille; C : in Type_Coordonnee);

   procedure ResoudreDoubleGauche
     (G : in out Type_Grille; C : in Type_Coordonnee);

   procedure ResoudreDoubleDroite
     (G : in out Type_Grille; C : in Type_Coordonnee);

   procedure ResoudreSandwichHorizontal
     (G : in out Type_Grille; C : in Type_Coordonnee);

   procedure ResoudreSandwichVertical
     (G : in out Type_Grille; C : in Type_Coordonnee);

   procedure ResoudreDouble (G : in out Type_Grille; C : in Type_Coordonnee);

   procedure ResoudreSandwich (G : in out Type_Grille; C : in Type_Coordonnee);

   procedure ResoudreLignePresqueFinie
     (G : in out Type_Grille; L : in Integer);

   procedure ResoudreColonnePresqueFinie
     (G : in out Type_Grille; L : in Integer);

   procedure ResoudreTakuzuNaif (G : in out Type_Grille);

   procedure ResoudreTakuzuBacktracking
     (G : in out Type_Grille; Trouve : out Boolean);

   -- si la solution a ete trouve pour la grille g, alors Trouve est a VRAI et
   -- la grille est complete sinon Trouve est a FAUX et la grille n'a aucune
   -- valeur significative parcours la grille
   procedure ResoudreTakuzu (G : in out Type_Grille; Trouve : out Boolean);

end Resolution_Takuzu;
