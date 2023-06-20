// OnlyUP autosplitter

state("OnlyUP-Win64-Shipping")		// pointer paths
{
	double coordX  : 0x073C5ED8, 0x180, 0xA0, 0x98, 0xA8, 0x60, 0x328, 0x260;
	double coordY  : 0x073C5ED8, 0x180, 0xA0, 0x98, 0xA8, 0x60, 0x328, 0x268;
	double coordZ  : 0x073C5ED8, 0x180, 0xA0, 0x98, 0xA8, 0x60, 0x328, 0x270;
	double velocX  : 0x07356580, 0x0, 0x30, 0xA8, 0x50, 0xAB8, 0x20, 0x320, 0xB8;
	double velocY  : 0x07356580, 0x0, 0x30, 0xA8, 0x50, 0xAB8, 0x20, 0x320, 0xC0;
}

startup
{
	refreshRate = 30;
	
	vars.softReset = false;
	vars.currSplit = 0;

	// central point coords x/y/z and radius for each sphere
	vars.splitsCoords = new double[,] {
		{ 3062.76, 16389.2, 8697.5, 134 },      // Station
		{ 4623.09, 4867.59, 33884.4, 170 },     // Oil
		{ 2257.24, 18548.2, 48138.5, 1254 },    // Subway
		{ 5434.17, 8707.72, 83707.9, 814 },     // Highway
		{ 4229.35, 12127.4, 90037.4, 92 },      // Elevator
		{ 2936, 8172.93, 105057, 2921 },        // Winner?
		{ 1064.72, 3701.3, 156054, 453 },       // Hand
		{ -1537.41, 3881.58, 171863, 1392 },    // En Passant
		{ -1209.93, 9218.39, 198943, 88 },      // Cannon
		{ 1005.6, 24691.5, 244610, 97 },	    // Apple
		{ 1353.83, 15993, 283501, 2760 },       // Illuminati
		{ -4753.2, 19013.4, 324117.0, 100 },	// End
	};
	vars.maxSplits = vars.splitsCoords.Length / 4;
	
	if (timer.Run.Count == 1)
		vars.currSplit = vars.maxSplits - 1;
		
	timer.OnUndoSplit += (s, e) => vars.currSplit--;
	timer.OnSkipSplit += (s, e) => vars.currSplit++;
}

update
{
	if (current.coordX == 0 && current.coordY == 0 && current.coordZ == 0)
	{
		vars.softReset = true;
		return false;
	}
}

reset
{
	if (vars.softReset && current.velocX == 0 && current.velocY == 0)
	{
		vars.softReset = false;
		return true;
	}
}

start
{
	if (current.velocX != 0 || current.velocY != 0)
	{
		vars.softReset = false;
		return true;
	}
}

split
{
	var i = vars.currSplit;

	double dx = current.coordX - vars.splitsCoords[i, 0];
	double dy = current.coordY - vars.splitsCoords[i, 1];
	double dz = current.coordZ - vars.splitsCoords[i, 2];

	double distSquared = dx * dx + dy * dy + dz * dz;
	double radius = vars.splitsCoords[i, 3];

	if (distSquared <= radius * radius)
		return true;
}

onSplit
{
	if ((vars.currSplit + 1) < vars.maxSplits)
			vars.currSplit++;
}

onReset
{
	vars.currSplit = 0;
}
