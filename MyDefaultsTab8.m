function handle = MyDefaultsTab8(source,event,handle)

set(handle.SaveAddeditTab8,'string',[pwd,'\Results']); % pwd returns the current directory of the Matlab!
set(handle.FigCheckTab8,'value',1);
set(handle.JpgCheckTab8,'value',1);
set(handle.TiffCheckTab8,'value',1);
set(handle.ReactantGasConcCheckTab8,'value',1);
set(handle.ProductGasConcCheckTab8,'value',1);
set(handle.TempratureCheckTab8,'value',1);
set(handle.PororsityCheckTab8,'value',1);
set(handle.VelocityCheckTab8,'value',1);
set(handle.ReactantSolidConcCheckTab8,'value',1);
set(handle.ConversionCheckTab8,'value',1);
set(handle.ProductSolidConcCheckTab8,'value',1);
set(handle.InitialObsCheckTab8,'value',1);
set(handle.FinalObsCheckTab8,'value',1);
set(handle.InitialSimCheckTab8,'value',1);
set(handle.FinalSimCheckTab8,'value',1);
set(handle.ParametersCheckTab8,'value',1);
set(handle.ReactionRateCheckTab8,'value',1);
set(handle.GasAdsorptionCheckTab8,'value',1);
set(handle.GasAdsorptionCheckTab8,'value',1);