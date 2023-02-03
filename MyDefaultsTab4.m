function handle = MyDefaultsTab4(source,event,handle)

set(handle.GasFlowRateeditTab4,'string','1');
set(handle.ReactantGasConceditTab4,'string','0.8');
set(handle.TemperatureeditTab4,'string','450');
set(handle.ViscosityeditTab4,'string','1');
set(handle.GasStarteditTab4,'string','1');
set(handle.GasStopeditTab4,'string',get(handle.MaxItereditTab2,'string'));