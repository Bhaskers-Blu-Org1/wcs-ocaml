(*
 *  This file is part of the Watson Conversation Service OCaml API project.
 *
 * Copyright 2016-2017 IBM Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *)

(** Generic bot runtime. *)

open Wcs_t

val before_default : message_request -> message_request
val after_default : message_response -> message_response
val user_input_default : unit -> string

val interpret :
  ?before:(message_request -> message_request) ->
  ?after:(message_response -> message_response) ->
  credential ->
  string -> message_request -> string * message_response * json option
(**
   [interpret cred ws_id msg_req] executes a complet conversation turn
   (including skip_user_input and calls) on the workspace id [ws_id]
   with the message request [msg_req]. The result is composed of the
   workspace id for the next conversation turn, the message response
   and the value of the field [return] in the context if it is
   defined.
*)


val exec :
  ?before:(message_request -> message_request) ->
  ?after:(message_response -> message_response) ->
  ?user_input:(unit -> string) ->
  ?output:(string -> unit) ->
  credential ->
  string -> json -> string -> json
(**
   [exec cred ws_id ctx_init txt_init] executes the workspace [ws_id]
   with the initial context [ctx_init] and the initial input text
   [txt_init]. The execution is completed when the field [return] is
   defined in the context.  The return value is the value of the field
   [return].
*)


val get_credential : string option -> credential
(**
   [get_credential file_name] read the credential in json format from
   the file [file_name]. If no file name is provided, the functions looks
   up in the environment if the variable [WCS_CRED] contains the file name
   with the credentials. If there is a problem while loading the credentials,
   [Log.Error] is raised.
*)
