function handle = MyShowSchematicdiagramTab3(handle)
fName = [pwd,'\Schematic of the obstacle.jpg'];
imshow(imread(fName), 'Parent',handle.SchematicdiagramAxesTab3)
set(handle.SchematicdiagramAxesTab3,'xtick',[], 'xticklabel',{},'ytick',[], 'yticklabel',{})