The kind of program we want to read
===================================

Exemple 0 : declare a comment
--------------------------
#this is a comment
 

Exemple 1 : declare a type
--------------------------
  struct $toto = {
    var1: string;
    var2: string list;
  }


Exemple 2 : run a simple command
--------------------------
  ls -l

Comment
-------
It is decided to use this form instead of: ls "-l"
this means that -l cannot be considered as a variable.


Exemple 3: use a var (script mode)
--------------------------
  let $pattern = "*.txt" in
    find -iname "$pattern"

Comment
-------
Variable start by a $.

Exemple 4: use a var (prompt mode)
--------------------------
  let $pattern = '"*.txt"' \\
  find -iname $pattern

Exemple 5: Pourquoi réflechir aux guillemets
--------------------------
  let $pattern = '-l -a' \\
  ls $pattern --color

Exemple 6: le type option
--------------------------


Exemple 6: variable containing the result of a command
--------------------------
  let $res = ls -l
  #une commande possède:
	- un programme appelé
	- une liste d'arguments
	- un résultat entier (succés, code d'erreur)
	- un résultat d'erreur affiché
	- un résultat standard affiché
	- un résultat affiché (erreur + standard)
  struct $cmd = {
    cmdinstr : string;
    cmdlist : string list;
    res : int option;
    print : string option;
    print_error : string option;
    print_std :string option;


Exemple 7: run a piped command
--------------------------
  ls -l | grep toto

Exemple 8: run a piped command
--------------------------
  $res | grep toto

Exemple 9: int computation
--------------------------
  let $res = + 5 8 
  #$res = 13

Exemple 10: les listes
--------------------------
    let $malist = ["-l", "-a", "-b"] // le type de $mavar est string list.
    echo $malist[1]
    list_lenght $malist
    let $malist = list_append $malist "toto"
    let $malist = list_rm_last $malist 
    let $malist = list_prepend $malist "titi"
    let $malist = list_rm_first $malist
    #Pour modifier une liste: 
    let $malist = $malist with [_,_,_,_,_,"tata"]
    #Qui peut être abrégé:
    let $malist = [_,_,_,_,_,"tata"]
    #Qui peut être abrégé:
    let $malist = [5:"tata"] 

    #avec les lists il n'est possible de n'insérer ou supprimer qu'en tête ou en fin.
Comment
-------
Tous les éléments d'un tableaux doivent être du même type


Exemple 12: les ensembles
--------------------------
    let $monset = ~ 3 4 7 ~
    #add to a set:
    let $monset = $monset with ~ 5 ~
    set_is_in 5 $monset

Exemple 13: les maps
--------------------------
    let $mamap = ~ 1:3 23:4 3:7 ~
    #add to a map:
    let $mamap = $mamap with [5:34]
    $mamap[1]

Exemple 14: toutes les variables sont immutables (sauf redeclaration via let)
-----------------------------------------------------------------------------
    let $monset = ~ 3 4 7 ~
    let $monset2 = ~ 5 ~ $monset
    $monset2 


Exemple 15: struct var
--------------------------
  struct $toto = {
    var1: string;
    var2: string list;
  }
 
  let $mavar = $toto{
    var1 = "-l -a";
    var2 = ["-l", "-a", "-b"]
  }

  #utilisation var1
  echo $mavar.var1

  #on peut faire une structure "n-uplet":
  struct $tuple = {
    : string;
    : int;
  }
 
  let $mavar = $tuple{"test", 3}

Exemple 16: fonctions
---------------------

let $mafun arg1 arg2 = arg1 + arg2

Exemple 17: fonctions
---------------------

let $mafun arg = ls arg

Exemple 18: commandes
---------------------

let $mafun arg = 
	let $tmp = arg in
	  (ls $tmp)


Rules
=====

A variable start by a $.
A string variable is never computed/transformed
A command variable is applied when needed (to apply immediatly, use "let $res = ! (ls -l)"
A int operation variable is applied when needed (to apply immediatly, use "let $res = ! (+ 5 8)"

Les scopes:
les variables sont définis à l'intérieur de leur "in" sinon, elles sont toplevel.

Un fichier est implicitement un module.
