pragma Ada_2012;
package body Grille is

   ----------------------
   -- ConstruireGrille --
   ----------------------

   function ConstruireGrille (T : Integer) return Type_Grille is
      G : Type_Grille;
   begin
      if T < 4 or T > TAILLE_MAX or T mod 2 /= 0 then
         raise TAILLE_GRILLE_INVALIDE;
      end if;

      G.Taille := (T);

      for i in 1 .. G.Taille loop
         for j in 1 .. G.Taille loop
            G.G (i, j) := INCONNU;
         end loop;
      end loop;
      G.Modifications := 0;
      return G;
   end ConstruireGrille;

   ------------
   -- Taille --
   ------------

   function Taille (G : in Type_Grille) return Integer is
   begin
      return G.Taille;
   end Taille;

   -----------------
   -- estCaseVide --
   -----------------

   function estCaseVide
     (G : in Type_Grille; C : in Type_Coordonnee) return Boolean
   is
   begin
      return ValeurChiffre (G.G (ObtenirLigne (C), ObtenirColonne (C))) = -1;
   end estCaseVide;

   --------------------
   -- ObtenirChiffre --
   --------------------

   function ObtenirChiffre
     (G : in Type_Grille; C : in Type_Coordonnee) return Type_Chiffre
   is
   begin
      if estCaseVide (G, C) then
         raise CASE_VIDE;
      end if;
      return G.G (ObtenirLigne (C), ObtenirColonne (C));
   end ObtenirChiffre;

   --------------------------
   -- NombreChiffresConnus --
   --------------------------

   function NombreChiffresConnus (G : in Type_Grille) return Integer is
      total : Integer;
   begin
      total := 0;
      for i in 1 .. G.Taille loop
         for j in 1 .. G.Taille loop
            if ValeurChiffre (G.G (i, j)) /= -1 then
               total := total + 1;
            end if;
         end loop;
      end loop;
      return total;
   end NombreChiffresConnus;

   ----------------
   -- EstRemplie --
   ----------------

   function EstRemplie (G : in Type_Grille) return Boolean is
   begin
      return NombreChiffresConnus (G) = G.Taille**2;
   end EstRemplie;

   -------------------
   -- extraireLigne --
   -------------------

   function extraireLigne
     (G : in Type_Grille; L : in Integer) return Type_Rangee
   is
      R : Type_Rangee;
   begin
      R := ConstruireRangee (G.Taille);
      for i in 1 .. G.Taille loop
         R := AjouterChiffre (R, i, G.G (L, i));
      end loop;
      return R;
   end extraireLigne;

   ---------------------
   -- extraireColonne --
   ---------------------

   function extraireColonne
     (G : in Type_Grille; C : in Integer) return Type_Rangee
   is
      R : Type_Rangee;
   begin
      R := ConstruireRangee (G.Taille);
      for i in 1 .. G.Taille loop
         R := AjouterChiffre (R, i, G.G (i, C));
      end loop;
      return R;
   end extraireColonne;

   ------------------
   -- FixerChiffre --
   ------------------

   function FixerChiffre
     (G : in Type_Grille; C : in Type_Coordonnee; V : in Type_Chiffre)
      return Type_Grille
   is
      Gsortie : Type_Grille;
   begin
      if not estCaseVide (G, C) then
         raise FIXER_CHIFFRE_NON_NUL;
      end if;

      Gsortie                                          := G;
      Gsortie.G (ObtenirLigne (C), ObtenirColonne (C)) := V;
      Gsortie.Modifications := Gsortie.Modifications + 1;
      return Gsortie;
   end FixerChiffre;

   ---------------
   -- ViderCase --
   ---------------

   function ViderCase
     (G : in Type_Grille; C : in Type_Coordonnee) return Type_Grille
   is
      Gsortie : Type_Grille;
   begin
      if estCaseVide (G, C) then
         raise VIDER_CASE_VIDE;
      end if;

      Gsortie                                          := G;
      Gsortie.G (ObtenirLigne (C), ObtenirColonne (C)) := INCONNU;
      return Gsortie;
   end ViderCase;

   ----------------------------
   -- ComporteErreurColonne --
   ----------------------------

   function ComporteErreurColonne
     (G : in Type_Grille; C : in Integer) return Boolean
   is
      R : Type_Rangee;
   begin
      R := extraireColonne (G, C);
      return ComporteErreur (R);
   end ComporteErreurColonne;

   -------------------------
   -- ComporteErreurLigne --
   -------------------------

   function ComporteErreurLigne
     (G : in Type_Grille; L : in Integer) return Boolean
   is
      R : Type_Rangee;
   begin
      R := extraireLigne (G, L);
      return ComporteErreur (R);
   end ComporteErreurLigne;

   --------------------------
   -- ComporteErreurGrille --
   --------------------------
   function ComporteErreurGrille (G : in Type_Grille) return Boolean is
   begin
      for i in 1 .. G.Taille loop
         if ComporteErreurLigne (G, i) or ComporteErreurColonne (G, i) then
            return True;
         end if;
      end loop;
      return False;
   end ComporteErreurGrille;

   -----------------------------
   -- TrouverPremiereCaseVide --
   -----------------------------

   function TrouverPremiereCaseVide (G : in Type_Grille) return Type_Coordonnee
   is
      Co : Type_Coordonnee;
   begin
      if EstRemplie (G) then
         raise GRILLE_REMPLIE;
      end if;

      for i in 1 .. G.Taille loop
         for j in 1 .. G.Taille loop
            if estCaseVide (G, ConstruireCoordonnees (i, j)) then
               Co := ConstruireCoordonnees (i, j);
            end if;
         end loop;
      end loop;
      return Co;
   end TrouverPremiereCaseVide;

   ----------------------
   -- RazModifications --
   ----------------------

   function RazModifications (G : in Type_Grille) return Type_Grille is
      Gsortie : Type_Grille;
   begin
      Gsortie               := G;
      Gsortie.Modifications := 0;
      return Gsortie;
   end RazModifications;

   -------------------------
   -- ObtenirModification --
   -------------------------

   function ObtenirModification (G : in Type_Grille) return Integer is
   begin
      return G.Modifications;
   end ObtenirModification;

end Grille;
