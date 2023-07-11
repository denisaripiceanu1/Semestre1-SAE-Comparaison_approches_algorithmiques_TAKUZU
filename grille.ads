with Coordonnee; use Coordonnee;
with Chiffre;    use Chiffre;
with Rangee;     use Rangee;

package Grille is

   type Type_Grille is private;

   TAILLE_GRILLE_INVALIDE : exception;
   CASE_VIDE              : exception;
   VIDER_CASE_VIDE        : exception;
   FIXER_CHIFFRE_NON_NUL  : exception;
   GRILLE_REMPLIE         : exception;

   -- cree une grille vide de taille t necessite 4 <= t <= TAILLE_MAX et t pair
   -- leve l'exception TAILLE_GRILLE_INVALIDE sinon
   function ConstruireGrille (T : Integer) return Type_Grille;

   -- retourne la taille de la grille g
   function Taille (G : in Type_Grille) return Integer;

   -- retourne VRAI si la case de coordonnee c de la grille g est vide FAUX
   -- sinon
   function estCaseVide
     (G : in Type_Grille; C : in Type_Coordonnee) return Boolean;

   -- retourne la valeur de la case de coordonnee c de la grille g necessite
   -- que la case c ne soit pas vide leve l'exception CASE_VIDE si la case c
   -- est vide
   function ObtenirChiffre
     (G : in Type_Grille; C : in Type_Coordonnee) return Type_Chiffre;

   -- retourne le nombre de cases remplies dans la grille g
   function NombreChiffresConnus (G : in Type_Grille) return Integer;

   -- retourne VRAI si la grille est totalement remplie et FAUX sinon
   function EstRemplie (G : in Type_Grille) return Boolean;

   -- construit une rangee a partir de la ligne l de la grille g
   function extraireLigne
     (G : in Type_Grille; L : in Integer) return Type_Rangee;

   -- construit une rangee a partir de la colonne c de la grille g
   function extraireColonne
     (G : in Type_Grille; C : in Integer) return Type_Rangee;

   -- construit une nouvelle grille dont les valeurs sont celles de g SAUF la
   -- case de coordonnee c qui prend la valeur v necessite que la case c de la
   -- grille g soit vide leve l'exception FIXER_NON_NUL si la case est vide
   function FixerChiffre
     (G : in Type_Grille; C : in Type_Coordonnee; V : in Type_Chiffre)
      return Type_Grille;

   -- construit une nouvelle grille dont les valeurs sont celles de g SAUF la
   -- case de coordonnÃ©es c qui prend la valeur INCONNU nÃ©cessite
   -- que la case c de la grille g ne soit pas vide leve l'exception
   -- VIDER_CASE_VIDE si c est vide
   function ViderCase
     (G : in Type_Grille; C : in Type_Coordonnee) return Type_Grille;

   -- Analyse la colonne c de la grille g et renvoie VRAI si elle comporte une
   -- erreur. FAUX sinon.
   function ComporteErreurColonne
     (G : in Type_Grille; C : in Integer) return Boolean;

   -- Analyse la ligne l de la grille g et renvoie VRAI si elle comporte une
   -- erreur. FAUX sinon.
   function ComporteErreurLigne
     (G : in Type_Grille; L : in Integer) return Boolean;

   -- Analyse la grille g et renvoie VRAI si elle comporte une erreur. FAUX
   -- sinon.
   function ComporteErreurGrille (G : in Type_Grille) return Boolean;

   -- Parcours la grille g ligne par ligne et renvoie les coordonnÃ©es
   -- de la premiere case vide trouvee. Necessite une grille non remplie. Leve
   -- l'exception GRILLE_REMPLIE si estRemplie(g).
   function TrouverPremiereCaseVide
     (G : in Type_Grille) return Type_Coordonnee;

   -- (Re)met a zero le nombre de modifications de la grille.
   function RazModifications (G : in Type_Grille) return Type_Grille;

   -- Renvoie le nombre de modifications effectuées sur la grille G.
   function ObtenirModification (G : in Type_Grille) return Integer;

private
   TAILLE_MAX : constant Integer := 100;
   type Type_Tableau_Grille is
     array (1 .. TAILLE_MAX, 1 .. TAILLE_MAX) of Type_Chiffre;
   type Type_Grille is record
      G             : Type_Tableau_Grille;
      Taille        : Integer;
      Modifications : Integer;
   end record;

end Grille;
