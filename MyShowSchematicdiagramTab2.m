function handle = MyShowSchematicdiagramTab2(handle)
fName = [pwd,'\Schematic diagram of the simulation.jpg'];
imshow(imread(fName), 'Parent',handle.SchematicdiagramAxesTab2)
set(handle.SchematicdiagramAxesTab2,'xtick',[], 'xticklabel',{},'ytick',[], 'yticklabel',{})