pragma Ada_2012;
package body Rangee is

   ----------------------
   -- ConstruireRangee --
   ----------------------

   function ConstruireRangee (T : in Integer) return Type_Rangee is
      Rangee : Type_Rangee;
      i      : Integer;
   begin
      Rangee.Taille := T;
      i             := 1;
      while i <= T loop
         Rangee.R (i) := INCONNU;
         i            := i + 1;
      end loop;

      return Rangee;
   end ConstruireRangee;

   -------------
   -- EstVide --
   -------------

   function EstVide (R : in Type_Rangee) return Boolean is
      i    : Integer;
      Vide : Boolean;
   begin
      i    := 1;
      Vide := True;
      while i <= R.Taille and Vide loop
         if R.R (i) /= INCONNU then
            Vide := False;
         end if;
         i := i + 1;
      end loop;
      return Vide;

   end EstVide;

   ----------------
   -- EstRemplie --
   ----------------

   function EstRemplie (R : in Type_Rangee) return Boolean is
      Remplie : Boolean;
   begin
      Remplie := True;
      for i in 1 .. R.Taille loop
         if R.R (i) = INCONNU then
            Remplie := False;
         end if;
      end loop;
      return Remplie;
   end EstRemplie;

   ------------
   -- Taille --
   ------------

   function Taille (R : in Type_Rangee) return Integer is
   begin
      return R.Taille;

   end Taille;

   --------------------
   -- ObtenirChiffre --
   --------------------

   function ObtenirChiffre
     (R : in Type_Rangee; I : in Integer) return Type_Chiffre
   is
   begin
      if I < 1 or I > R.Taille then
         raise TRANCHE_INVALIDE;
      end if;
      return R.R (I);

   end ObtenirChiffre;

   --------------------------
   -- nombreChiffresConnus --
   --------------------------

   function nombreChiffresConnus (R : in Type_Rangee) return Integer is
      Cpt_Connus : Integer;
      i          : Integer;
   begin
      Cpt_Connus := 0;
      i          := 1;
      while i <= R.Taille loop
         if ObtenirChiffre (R, i) /= INCONNU then
            Cpt_Connus := Cpt_Connus + 1;
         end if;
         i := i + 1;
      end loop;
      return Cpt_Connus;
   end nombreChiffresConnus;

   ----------------------------
   -- nombreChiffresDeValeur --
   ----------------------------

   function nombreChiffresDeValeur
     (R : in Type_Rangee; V : in Type_Chiffre) return Integer
   is
      Nb_Chiffre_Valeur : Integer;
      i                 : Integer;
   begin
      Nb_Chiffre_Valeur := 0;
      i                 := 1;
      while i <= R.Taille loop
         if ObtenirChiffre (R, i) = V then
            Nb_Chiffre_Valeur := Nb_Chiffre_Valeur + 1;
         end if;
         i := i + 1;
      end loop;
      return Nb_Chiffre_Valeur;

   end nombreChiffresDeValeur;

   ---------------------
   -- chiffreDeDroite --
   ---------------------

   function chiffreDeDroite
     (E : in Type_Rangee; I : in Integer) return Type_Chiffre
   is
   begin
      if I < 1 or I > E.Taille then
         raise TRANCHE_INVALIDE;
      end if;
      if I < E.Taille then
         return E.R (I + 1);
      else
         return INCONNU;
      end if;

   end chiffreDeDroite;

   ---------------------
   -- chiffreDeGauche --
   ---------------------

   function chiffreDeGauche
     (E : in Type_Rangee; I : in Integer) return Type_Chiffre
   is
   begin
      if I < 1 or I > E.Taille then
         raise TRANCHE_INVALIDE;
      end if;
      if I > 1 then
         return E.R (I - 1);
      else
         return INCONNU;
      end if;

   end chiffreDeGauche;

   -----------------------------------
   -- SontDeuxChiffresDeDroiteEgaux --
   -----------------------------------

   function SontDeuxChiffresDeDroiteEgaux
     (E : in Type_Rangee; I : in Integer) return Boolean
   is
   begin
      if I < 1 or I > E.Taille then
         raise TRANCHE_INVALIDE;
      end if;

      if chiffreDeDroite (E, I) /= INCONNU
        and then chiffreDeDroite (E, I) = chiffreDeDroite (E, I + 1)
      then
         return True;
      else
         return False;
      end if;

   end SontDeuxChiffresDeDroiteEgaux;

   -----------------------------------
   -- SontDeuxChiffresDeGaucheEgaux --
   -----------------------------------

   function SontDeuxChiffresDeGaucheEgaux
     (E : in Type_Rangee; I : in Integer) return Boolean
   is
   begin
      if I < 1 or I > E.Taille then
         raise TRANCHE_INVALIDE;
      end if;

      return
        chiffreDeGauche (E, I) /= INCONNU
        and then chiffreDeGauche (E, I) = chiffreDeGauche (E, I - 1);

   end SontDeuxChiffresDeGaucheEgaux;

   --------------------
   -- AjouterChiffre --
   --------------------

   function AjouterChiffre
     (R : in Type_Rangee; I : in Integer; C : in Type_Chiffre)
      return Type_Rangee
   is
      E : Type_Rangee;
   begin
      if I < 1 or I > R.Taille then
         raise TRANCHE_INVALIDE;
      end if;

      E       := R;
      E.R (I) := C;
      return E;
   end AjouterChiffre;

   --------------------
   -- RetirerChiffre --
   --------------------

   function RetirerChiffre
     (R : in Type_Rangee; I : in Integer) return Type_Rangee
   is
      E : Type_Rangee;
   begin
      if I < 1 or I > R.Taille then
         raise TRANCHE_INVALIDE;
      end if;

      E := R;
      if E.R (I) /= INCONNU then
         E.R (I) := INCONNU;
      end if;
      return E;

   end RetirerChiffre;

   --------------------
   -- ComporteErreur --
   --------------------

   function ComporteErreur (R : in Type_Rangee) return Boolean is

   begin
      for i in 1 .. R.Taille - 2 loop
         if not EstInconnue (ObtenirChiffre (R, i))
           and then ObtenirChiffre (R, i) = chiffreDeDroite (R, i)
           and then SontDeuxChiffresDeDroiteEgaux (R, i)
         then
            return True;
         end if;
      end loop;
      if nombreChiffresDeValeur (R, UN) > R.Taille / 2 then
         return True;
      end if;
      return nombreChiffresDeValeur (R, ZERO) > R.Taille / 2;
   end ComporteErreur;

end Rangee;
