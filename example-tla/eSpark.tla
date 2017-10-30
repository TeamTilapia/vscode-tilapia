\* By Hillel Wayne at
\*   https://medium.com/espark-engineering-blog/formal-methods-in-practice-8f20d72bce4f

EXTENDS Integers, TLC, Sequences
CONSTANTS Devices

(* --algorithm BatchInstall
variables
  AppScope \in [Devices -> {0, 1}];
  Installs \in [Devices -> BOOLEAN];
  batch_pool = {};
  lock = FALSE;
define
  PoolNotEmpty == batch_pool # {}
end define
procedure ChangeAppScope()
variables cache;
begin
  GetLock:
    await ~lock;
    lock := TRUE;
  Cache:
    cache := batch_pool;
  Filter:
    cache := cache \intersect {d \in Devices: AppScope[d] = 0};
  Add:  
    AppScope := [d \in Devices |->
        IF d \in cache THEN AppScope[d] + 1
        ELSE AppScope[d] 
     ]; 
  Clean:
    batch_pool := batch_pool \ cache;
    lock := FALSE;
  return;
end procedure
fair process SyncDevice \in Devices
begin 
  Sync:
    if Installs[self] then
        batch_pool := batch_pool \union {self};
    end if;
    if PoolNotEmpty then
      either 
        call ChangeAppScope();
      or
        skip;
      end either;
    end if;
end process;
fair process TimeLoop = 0
begin 
  Start:
    while TRUE do
      await PoolNotEmpty;
      call ChangeAppScope();
    end while;
end process
end algorithm; *)
