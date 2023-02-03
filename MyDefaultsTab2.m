function handle = MyDefaultsTab2(source,event,handle)

set(handle.HeighteditTab2,'string','360');
set(handle.WidtheditTab2,'string','800');
set(handle.MaxItereditTab2,'string','1000');
set(handle.CurrentItereditTab2,'string','0');
set(handle.GraineditTab2,'string','8');
set(handle.SaveItereditTab2,'string','250');
add = [pwd,'\Obstacle0.mat'];
MyLoadTab2(source,event,handle,add)