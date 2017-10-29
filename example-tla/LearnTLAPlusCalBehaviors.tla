\* from: https://www.learntla.com/pluscal/behaviors/
---- MODULE flags ----
EXTENDS TLC, Integers
(* --algorithm flags
variables flags \in [1..3 -> BOOLEAN], next = TRUE;
begin
  while next do
    with f \in DOMAIN flags, n \in BOOLEAN do
      flags[f] := ~flags[f];
      next := n;
    end with;
  end while;
end algorithm; *)

====