open Core_kernel
open Async_kernel

type t = string

let touch_and_truncate path =
  Out_channel.create ~append:false path
  |> Out_channel.close

let init ?(updates_per_minute=12) path =
  let send_frequency = Time_ns.Span.of_int_sec @@ 60/updates_per_minute in
  Clock_ns.every send_frequency @@ fun () ->
    touch_and_truncate path
