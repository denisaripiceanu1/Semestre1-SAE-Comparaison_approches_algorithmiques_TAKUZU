package body Coordonnee is

   ---------------------------
   -- ConstruireCoordonnees --
   ---------------------------

   function ConstruireCoordonnees
     (Ligne, Colonne : in Integer) return Type_Coordonnee
   is
      Coordonnees : Type_Coordonnee;
   begin
      Coordonnees.Ligne   := Ligne;
      Coordonnees.Colonne := Colonne;

      return Coordonnees;

   end ConstruireCoordonnees;

   ------------------
   -- ObtenirLigne --
   ------------------

   function ObtenirLigne (C : in Type_Coordonnee) return Integer is
   begin
      return C.Ligne;
   end ObtenirLigne;

   --------------------
   -- ObtenirColonne --
   --------------------

   function ObtenirColonne (C : in Type_Coordonnee) return Integer is
   begin

      return C.Colonne;
   end ObtenirColonne;

   ----------
   -- Haut --
   ----------

   function Haut (C : in Type_Coordonnee) return Type_Coordonnee is
   begin
      return ConstruireCoordonnees (ObtenirLigne (C) - 1, ObtenirColonne (C));
   end Haut;

   ---------
   -- Bas --
   ---------

   function Bas (C : in Type_Coordonnee) return Type_Coordonnee is
   begin
      return ConstruireCoordonnees (ObtenirLigne (C) + 1, ObtenirColonne (C));
   end Bas;

   ------------
   -- Droite --
   ------------

   function Droite (C : in Type_Coordonnee) return Type_Coordonnee is
   begin
      return ConstruireCoordonnees (ObtenirLigne (C), ObtenirColonne (C) + 1);
   end Droite;

   ----------
   -- Gauche --
   ----------

   function Gauche (C : in Type_Coordonnee) return Type_Coordonnee is
   begin
      return ConstruireCoordonnees (ObtenirLigne (C), ObtenirColonne (C) - 1);
   end Gauche;

end Coordonnee;
