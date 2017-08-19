(**
  *
  *The goal is to parse this kind of text:

def toto = {
  var1: string;
  var2: string list;
  }
  
  *
  *)

type token =
  | STRUCT (* or DEF *)
  | EQ
  | LET
  | OPEN_BRACK
  | CLOSE_BRACK
  | CLOSE_BRACK
  | AFFECT  (* = *)
  | COLON (* : *)
  | SEMICOLON (* ; *)
  | TYPENAME of string
  | VARNAME of string
  | EOF





(** FROM OCAML, might be usefull *)


