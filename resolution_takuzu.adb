with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO;         use Ada.Text_IO;
package body Resolution_Takuzu is

   --------------------
   -- CompleterLigne --
   --------------------

   procedure CompleterLigne
     (G : in out Type_Grille; L : in Integer; V : in Type_Chiffre)
   is
      ligne : Type_Rangee;
   begin
      ligne := extraireLigne (G, L);
      for i in 1 .. Taille (G) loop
         if estCaseVide (G, ConstruireCoordonnees (L, i)) then
            G := FixerChiffre (G, ConstruireCoordonnees (L, i), V);
         end if;
      end loop;
   end CompleterLigne;

   ----------------------
   -- CompleterColonne --
   ----------------------

   procedure CompleterColonne
     (G : in out Type_Grille; Col : in Integer; V : in Type_Chiffre)
   is
      colonne : Type_Rangee;
   begin
      colonne := extraireColonne (G, Col);
      for i in 1 .. Taille (G) loop
         if estCaseVide (G, ConstruireCoordonnees (i, Col)) then
            G := FixerChiffre (G, ConstruireCoordonnees (i, Col), V);
         end if;
      end loop;

   end CompleterColonne;

   ------------------------
   -- ResoudreDoubleHaut --
   ------------------------

   procedure ResoudreDoubleHaut
     (G : in out Type_Grille; C : in Type_Coordonnee)
   is
   begin
      if ObtenirLigne (C) > 2
        and then
        (estCaseVide (G, C) and (not estCaseVide (G, Haut (C))) and
         (not estCaseVide (G, Haut (Haut (C)))))
      then
         if ObtenirChiffre (G, Haut (C)) = ObtenirChiffre (G, Haut (Haut (C)))
         then
            G :=
              FixerChiffre (G, C, Complement (ObtenirChiffre (G, Haut (C))));
         end if;
      end if;
   end ResoudreDoubleHaut;

   -----------------------
   -- ResoudreDoubleBas --
   -----------------------

   procedure ResoudreDoubleBas (G : in out Type_Grille; C : in Type_Coordonnee)
   is
   begin
      if ObtenirLigne (C) < Taille (G) - 1
        and then
        (estCaseVide (G, C) and (not estCaseVide (G, Bas (C))) and
         (not estCaseVide (G, Bas (Bas (C)))))
      then
         if ObtenirChiffre (G, Bas (C)) = ObtenirChiffre (G, Bas (Bas (C)))
         then
            G := FixerChiffre (G, C, Complement (ObtenirChiffre (G, Bas (C))));
         end if;
      end if;
   end ResoudreDoubleBas;

   --------------------------
   -- ResoudreDoubleDroite --
   --------------------------

   procedure ResoudreDoubleDroite
     (G : in out Type_Grille; C : in Type_Coordonnee)
   is
   begin
      if ObtenirColonne (C) < Taille (G) - 1
        and then
        (estCaseVide (G, C) and (not estCaseVide (G, droite (C))) and
         (not estCaseVide (G, droite (droite (C)))))
      then
         if ObtenirChiffre (G, droite (C)) =
           ObtenirChiffre (G, droite (droite (C)))
         then
            G :=
              FixerChiffre (G, C, Complement (ObtenirChiffre (G, droite (C))));
         end if;
      end if;
   end ResoudreDoubleDroite;

   --------------------------
   -- ResoudreDoubleGauche --
   --------------------------

   procedure ResoudreDoubleGauche
     (G : in out Type_Grille; C : in Type_Coordonnee)
   is
   begin
      if ObtenirColonne (C) > 2
        and then
        (estCaseVide (G, C) and (not estCaseVide (G, gauche (C))) and
         (not estCaseVide (G, gauche (gauche (C)))))
      then
         if ObtenirChiffre (G, gauche (C)) =
           ObtenirChiffre (G, gauche (gauche (C)))
         then
            G :=
              FixerChiffre (G, C, Complement (ObtenirChiffre (G, gauche (C))));
         end if;
      end if;
   end ResoudreDoubleGauche;

   ---------------------------------
   -- ResoudreSandwichHorizontal --
   ---------------------------------

   procedure ResoudreSandwichHorizontal
     (G : in out Type_Grille; C : in Type_Coordonnee)
   is
   begin
      if (ObtenirColonne (C) > 1 and ObtenirColonne (C) < Taille (G))
        and then
        (estCaseVide (G, C) and (not estCaseVide (G, droite (C))) and
         (not estCaseVide (G, gauche (C))))
      then
         if ObtenirChiffre (G, gauche (C)) = ObtenirChiffre (G, droite (C))
         then
            G :=
              FixerChiffre (G, C, Complement (ObtenirChiffre (G, gauche (C))));
         end if;
      end if;
   end ResoudreSandwichHorizontal;

   ---------------------------------
   -- ResoudreSandwichVertical --
   ---------------------------------

   procedure ResoudreSandwichVertical
     (G : in out Type_Grille; C : in Type_Coordonnee)
   is
   begin
      if (ObtenirLigne (C) > 1 and ObtenirLigne (C) < Taille (G))
        and then
        (estCaseVide (G, C) and (not estCaseVide (G, Haut (C))) and
         (not estCaseVide (G, Bas (C))))
      then
         if ObtenirChiffre (G, Haut (C)) = ObtenirChiffre (G, Bas (C)) then
            G :=
              FixerChiffre (G, C, Complement (ObtenirChiffre (G, Haut (C))));
         end if;
      end if;
   end ResoudreSandwichVertical;

   --------------------
   -- ResoudreDouble --
   --------------------

   procedure ResoudreDouble (G : in out Type_Grille; C : in Type_Coordonnee) is
   begin
      ResoudreDoubleBas (G, C);
      ResoudreDoubleHaut (G, C);
      ResoudreDoubleGauche (G, C);
      ResoudreDoubleDroite (G, C);
   end ResoudreDouble;

   -----------------------
   -- ResoudreSandwich --
   -----------------------

   procedure ResoudreSandwich (G : in out Type_Grille; C : in Type_Coordonnee)
   is
   begin
      ResoudreSandwichVertical (G, C);
      ResoudreSandwichHorizontal (G, C);
   end ResoudreSandwich;

   -------------------------------
   -- ResoudreLignePresqueFinie --
   -------------------------------

   procedure ResoudreLignePresqueFinie (G : in out Type_Grille; L : in Integer)
   is
      Ligne : Type_Rangee;

   begin
      Ligne := extraireLigne (G, L);
      if nombreChiffresDeValeur (Ligne, UN) = Taille (Ligne) / 2 then
         CompleterLigne (G, L, ZERO);
      elsif nombreChiffresDeValeur (Ligne, ZERO) = Taille (Ligne) / 2 then
         CompleterLigne (G, L, UN);
      end if;
   end ResoudreLignePresqueFinie;

   --------------------------------
   -- ResoudreColonePresqueFinie --
   --------------------------------

   procedure ResoudreColonnePresqueFinie
     (G : in out Type_Grille; L : in Integer)
   is
      Ligne : Type_Rangee;

   begin
      Ligne := extraireColonne (G, L);
      if nombreChiffresDeValeur (Ligne, UN) = Taille (Ligne) / 2 then
         CompleterColonne (G, L, ZERO);
      elsif nombreChiffresDeValeur (Ligne, ZERO) = Taille (Ligne) / 2 then
         CompleterColonne (G, L, UN);
      end if;
   end ResoudreColonnePresqueFinie;

   -------------------------
   -- ResoudreTakuzu Naif --
   -------------------------

   procedure ResoudreTakuzuNaif (G : in out Type_Grille) is
      CompteurModificationGrille : Integer;
      C                          : Type_Coordonnee;
   begin
      CompteurModificationGrille := -1;
      while CompteurModificationGrille /= ObtenirModification (G) loop
         CompteurModificationGrille := ObtenirModification (G);
         for i in 1 .. Taille (G) loop
            for j in 1 .. Taille (G) loop
               C := ConstruireCoordonnees (i, j);
               ResoudreDouble (G, C);
               ResoudreSandwich (G, C);
            end loop;
            ResoudreLignePresqueFinie (G, i);
            ResoudreColonnePresqueFinie (G, i);
         end loop;
      end loop;
   end ResoudreTakuzuNaif;

   ---------------------------------
   -- ResoudreTakuzu BackTracking --
   ---------------------------------

   procedure ResoudreTakuzuBacktracking
     (G : in out Type_Grille; Trouve : out Boolean)
   is
      coord : Type_Coordonnee;
   begin
      if ComporteErreurGrille (G) then
         Trouve := False;
      elsif EstRemplie (G) then
         Trouve := True;
      else
         coord := TrouverPremiereCaseVide (G);
         G     := FixerChiffre (G, coord, ZERO);
         ResoudreTakuzuBacktracking (G, Trouve);
         if not Trouve then
            G := ViderCase (G, coord);
            G := FixerChiffre (G, coord, UN);
            ResoudreTakuzuBacktracking (G, Trouve);
            if not Trouve then
               G      := ViderCase (G, coord);
               Trouve := False;
            end if;
         end if;
      end if;
   end ResoudreTakuzuBacktracking;

   --------------------
   -- ResoudreTakuzu --
   --------------------

   procedure ResoudreTakuzu (G : in out Type_Grille; Trouve : out Boolean) is

   begin
      G := RazModifications (G);
      ResoudreTakuzuNaif (G);
      ResoudreTakuzuBacktracking (G, Trouve);
      Put ("Nombre de modifications : ");
      Put (ObtenirModification (G), 0);
      Put (" ");
   end ResoudreTakuzu;
end Resolution_Takuzu;
