/*
 * Only Up! Autosplitter
 *
 * Made by/with the help of:
 *	- wRadion
 *	- traumvogel
 *	- t0mz3r
 *	- NeKRooZz
 *	- MkLoM
 *
 */

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
	settings.Add("split0", false, "Favelas Elevator");
	settings.Add("split1", false, "Train Station");
	settings.Add("split2", false, "Rails Start");
	settings.Add("split3", false, "Oil Refinery");
	settings.Add("split4", false, "Factory");
	settings.Add("split5", false, "Subway");
	settings.Add("split6", false, "Drone");
	settings.Add("split7", false, "Highway");
	settings.Add("split8", false, "Elevator");
	settings.Add("split9", false, "Fake Winner Platform");
	settings.Add("split10", false, "Elevator to Heaven");
	settings.Add("split11", false, "Heaven");
	settings.Add("split12", false, "Hand");
	settings.Add("split13", false, "After Chess");
	settings.Add("split14", false, "Ship");
	settings.Add("split15", false, "Cannon");
	settings.Add("split16", false, "Golden Apple Elevator");
	settings.Add("split17", false, "Dragon Maze");
	settings.Add("split18", false, "Hoverboard");
	settings.Add("split19", false, "Space Start");
	settings.Add("split20", false, "Space First Bumper");
	
	refreshRate = 30;
	vars.currSplit = 0;
	
	Func<double, double, double, double, double> GetDistance2 = (x1, y1, x2, y2) => {
		double dx = x2 - x1;
		double dy = y2 - y1;

		return Math.Sqrt(dx * dx + dy * dy);
	};
	vars.GetDistance2 = GetDistance2;
	
	Func<double, double, double, double, double, double, double> GetDistance3 = (x1, y1, z1, x2, y2, z2) => {
		double dx = x2 - x1;
		double dy = y2 - y1;
		double dz = z2 - z1;

		return Math.Sqrt(dx * dx + dy * dy + dz * dz);
	};
	vars.GetDistance3 = GetDistance3;
	
	Action UpdateCurrSplit = () => {
		if (timer.Run.Count == 1)
			vars.currSplit = vars.splits.Count;
	};
	vars.UpdateCurrSplit = UpdateCurrSplit;
	
	vars.DistEnd = vars.GetDistance2(-4543.74, 19306.0, -4908.92, 18861.9);
	
	timer.OnUndoSplit += (s, e) => {
		if (vars.currSplit > 0)
			vars.currSplit--;
	};
	timer.OnSkipSplit += (s, e) => {
		if (vars.currSplit < vars.splits.Count)
			vars.currSplit++;
	};
}

init
{
	vars.softReset = false;

	// central point coords x/y/z and radius for each sphere
	vars.splitsCoords = new double[,] {
		{ 1675.95, 4147.05, -3111.73, 132 },    // Favelas Elevator
		{ 3537.17, 17051.4, 9916.54, 1600 },      // Station
		{ 4276.85, 13362.6, 9386.93, 313 }, 	// Rails
		{ 4623.09, 4867.59, 33884.4, 170 },     // Oil
		{ 1140.69, 5483.92, 43327.6, 250 },		// Factory
		{ 2257.24, 18548.2, 48138.5, 1254 },    // Subway
		{ -2794.33, 11254.3, 50514.1, 306 },	// Drone
		{ 5434.17, 8707.72, 83707.9, 814 },     // Highway
		{ 4229.35, 12127.4, 90037.4, 92 },      // Elevator
		{ 2936, 8172.93, 105057, 2921 },        // Winner?
		{ 3094.08, 8919.15, 105688, 462 },		// Elevator (to heaven)
		{ 508.38, 15258.2, 138287, 194 },		// Heaven
		{ 1064.72, 3701.3, 156054, 453 },       // Hand
		{ -1537.41, 3881.58, 171863, 1392 },    // En Passant
		{ -12363.2, 21183.6, 189660, 984 },		// Ship
		{ -1209.93, 9218.39, 198943, 50 },      // Cannon
		{ 1005.6, 24691.5, 244610, 97 },	    // Apple
		{ 2279.77, 18551, 260399, 291 }, 		// Pipe Exit (Drake)
		{ -2243.08, 9062.34, 270368, 120 },		// Hoverboard
		{ 1353.83, 15993, 283501, 3000 },       // Illuminati
	};
	vars.maxSplits = (vars.splitsCoords.Length / 4) + 1;
	
	vars.splits = new List<int>();
	for (int i = 0; i < vars.maxSplits - 1; ++i) {
		if (settings["split" + i.ToString()])
			vars.splits.Add(i);
	}
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
		vars.UpdateCurrSplit();
		vars.softReset = false;
		return true;
	}
}

start
{
	if (current.velocX != 0 || current.velocY != 0)
	{
		vars.UpdateCurrSplit();
		vars.softReset = false;
		return true;
	}
}

split
{
	print("--");
	print(vars.currSplit.ToString());
	print(vars.splits.Count.ToString());
	if (vars.currSplit < vars.splits.Count)
	{
		var i = vars.splits[vars.currSplit];

		double dist = vars.GetDistance3(current.coordX, current.coordY, current.coordZ, vars.splitsCoords[i, 0], vars.splitsCoords[i, 1], vars.splitsCoords[i, 2]);
		double radius = vars.splitsCoords[i, 3];
	
		if (dist <= radius)
			return true;
	}
	else if (324000 <= current.coordZ && current.coordZ <= 324300) // End Split
	{
		double dist1 = vars.GetDistance2(current.coordX, current.coordY, -4543.74, 19306.0);
		double dist2 = vars.GetDistance2(current.coordX, current.coordY, -4908.92, 18861.9);
		double total = dist1 + dist2;
		
		if (Math.Abs(vars.DistEnd - total) <= 30)
			return true;
	}
}

onSplit
{
	if (vars.currSplit < vars.splits.Count)
		vars.currSplit++;
}

onReset
{
	vars.currSplit = 0;
}
