
%token STRUCT 
%token LET
%token EQ 
%token OPEN_BRACK
%token CLOSE_BRACK
%token CLOSE_BRACK
%token AFFECT  
%token COLON 
%token SEMICOLON 
%token <string> TYPE
%token <string> VARNAME
%token EOF

%start <Json.value option> prog
%%

prog:
    | EOF   { None }
    | v = mprogram { Some p }
;


mprogram:
  | LEFT_BRACE; obj = object_fields; RIGHT_BRACE
    { `Assoc obj }


mtype:
  | STRUCT; name = TYPENAME; EQ; OPEN_BRACK ; vars = mvars ; CLOSE_BRACK;
	{ MComposed_type {mct_name = name mct_type = vars} }
