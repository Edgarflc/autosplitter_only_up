// OnlyUP autosplitter

state("OnlyUP-Win64-Shipping")		// pointer path to coords
{
	double coordX  : 0x073C5ED8, 0x180, 0xA0, 0x98, 0xA8, 0x60, 0x328, 0x260;
	double coordY  : 0x073C5ED8, 0x180, 0xA0, 0x98, 0xA8, 0x60, 0x328, 0x268;
	double coordZ  : 0x073C5ED8, 0x180, 0xA0, 0x98, 0xA8, 0x60, 0x328, 0x270;
}

startup
{
	refreshRate = 30;
	
	vars.currSplit = 0;

	// central point coords x/y/z and radius for each sphere
	vars.splitsCoords = new double[,] {
		{2944.743379317719, 16212.330863895946, 8622.992720833052, 150},		// station
		{4708.938725560206, 5209.9866486507935, 33897.75182034847, 150},		// oil
		{2506.8457100204464, 18064.940977585622, 48138.856266733674,150},	// subway
		// Continue for all points
	};
	
	vars.maxSplits = vars.splitsCoords.Length / 4;
}

update
{
	if(current.coordX == 0 && current.coordY == 0)
		return false;
}

start
{
	if((old.coordY - current.coordY) > 0)
		return true;
}

split
{
	var i = vars.currSplit;

	double dx = current.coordX - vars.splitsCoords[i, 0];
	double dy = current.coordY - vars.splitsCoords[i, 1];
	double dz = current.coordZ - vars.splitsCoords[i, 2];

	double distSquared = dx * dx + dy * dy + dz * dz;
	double radius = vars.splitsCoords[i, 3];

	if(distSquared <= radius * radius)
		return true;
}

onSplit
{
	if((vars.currSplit+1) < vars.maxSplits)
			vars.currSplit++;
}

onReset
{
	vars.currSplit = 0;
}
