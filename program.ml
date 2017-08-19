type mvars = {
  mva_name: string;
  mva_type: mtype;
  mva_value: mtype_val;
}

type mcmd_val = {
  mcm_cmd : string;
  mcm_args : string list;
  res : int option; (*if res is None, the command has not already been executed*)
  print: string option;
  print_error: string option;
  print_std: string option;
}

type mbase_type = 
  | MTypeString
  | MTypeInt
  | MTypeCmd

type mbase_type_val = 
  | MTypeStringVal of string
  | MTypeIntVal of int
  | MTypeCmdVal of mcmd_val

type mtype_field = {
  mtf_name : string;
  mtf_type: mtype;
}

type mtype_field_val = {
  mtfv_name : string;
  mtfv_type: mtype_val;
}

type mcomposed_type = {
  mct_name: string;
  mct_type: mtype_field list;
}

type mcomposed_type_val = {
  mcv_type: mtype_field_val list;
}

type msimple_type =
  | MBase_type of mbase_type
  | MList_type of msimple_type
  | MSet_type of msimple_type
  | MMap_type of mbase_type * msimple_type


type mtype =
  | MComposed_type of mcomposed_type
  | MBase_type of msimple_type

type mtype_val = {
  | MComposed_val of mcomposed_type_val
  | MBase_val of mbase_type_val


(** A scope contains types and variables*)
type mscope = {
  msc_father = mscope option; (* None when toplevel*)
  msc_vars = mvars list;
  msc_type = mtype list; (* always MComposed_type except for toplevel*) 
}

type mmodule = {
  mmo_name = string (*should start with uppercase*)
  mmo_scope = mscope (*upper scope*)
}

type mprogram = {
  mpr_modules = mmodule list;
  mpr_scopes = mscope list;
}
