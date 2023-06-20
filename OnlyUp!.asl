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
		{2944.7, 16212.3, 8622.9, 150},		// Station
		{4708.9, 5209.9, 33897.7, 150},		// Oil
		{2543.8, 18042.9, 48138.8, 150},	// Subway
		{6202.0, 9771.4, 84020.1, 150},		// Highway
		{4110.1, 12163.9, 90032.4, 150},	// Elevator
		{604.1, 15248.9, 138287.0, 150},	// Heaven
		{1602.2, 3773.3, 156149.0, 150},	// Hand
		{-613.3, 5418.3, 171682.0, 150},	// Chess
		{-1235.0, 9267.1, 198913.0, 150},	// Cannon
		{1010.1, 24550.3, 2445463.0, 150},	// Apple
		{2273.9, 16354.5, 283501.0, 150},	// Space
		{-4753.2, 19013.4, 324117.0, 100},	// End
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
