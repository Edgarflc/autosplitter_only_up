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
	vars.segmentsList = new Dictionary<string,string> {
		{"split0", "Favelas Elevator"},
		{"split1", "Train Station"},
		{"split2", "Rails Start"},
		{"split3", "Oil Refinery"},
		{"split4", "Factory"},
		{"split5", "Subway"},
		{"split6", "Drone"},
		{"split7", "Highway"},
		{"split8", "Elevator"},
		{"split9", "Fake Winner Platform"},
		{"split10","Elevator to Heaven"},
		{"split11","Heaven"},
		{"split12","Hand"},
		{"split13","After Chess"},
		{"split14","Ship"},
		{"split15","Cannon"},
		{"split16","Golden Apple Elevator"},
		{"split17","Dragon Maze"},
		{"split18","Hoverboard"},
		{"split19","Space Start"},
		{"split20","Space First Bumper"},
	};

	foreach(var Segment in vars.segmentsList) {
		settings.Add(Segment.Key, false, Segment.Value);
	};
	settings.Add("advanced", false, "Advanced settings");
	settings.SetToolTip("advanced", "Number of splits Segments in \"Edit Splits\" = (Number of splits checked in \"Autosplitter\") + 1");
	settings.Add("disable_autosplitter", false, "Disable autosplitter", "advanced");
	settings.Add("enable_debug_logs", false, "Enable debug logs", "advanced");
	settings.Add("enable_segments_autofill", false, "Enable segments autofill", "advanced");
	settings.SetToolTip("enable_segments_autofill", "WARNING Any of your current splits Segments in \"Edit Splits\" will be overwritten !\nIf you want to keep them do \"Save Splits As...\" before !");

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
		{ 3537.17, 17051.4, 9916.54, 1600 },    // Station
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
		{ 1353.83, 15993, 283501, 3000 },       // Space Start
		{ 2380.47, 16558.2, 283679, 295 },		// First Space Bumper
	};
	vars.maxSplits = (vars.splitsCoords.Length / 4) + 1;

	// Print logs if setting enable_debug_logs is enabled
	Action<string> Log = (message) => {
		if (settings["advanced"] && settings["enable_debug_logs"])
			print("[ASL][OnlyUP] " + message);
	};
	vars.Log = Log;

	// Count enabled splits in settings
	Func<int> CountEnabledSplits = () => { 
		return ((IEnumerable<KeyValuePair<string,string>>)vars.segmentsList)
			.Where(segment => settings[segment.Key])
			.ToList()
			.Count;
	};
	vars.CountEnabledSplits = CountEnabledSplits;

	// Reload enabled vars.splits list
	Action UpdateEnabledSplits = () => {
		vars.splits = new List<int>();
		for (int i = 0; i < vars.maxSplits - 1; ++i) {
			if (settings["split" + i.ToString()])
				vars.splits.Add(i);
		}
		vars.Log("splits enabled => { " + String.Join(", ", vars.splits) + " }");
	};
	vars.UpdateEnabledSplits = UpdateEnabledSplits;
	vars.UpdateEnabledSplits();

	// Reload segments when autofill is enabled 
	Action AutoFillSegments = () => {
		var segmentCount = timer.Run.Count;
		for (int i = 0; i < segmentCount - 1; ++i) {
			timer.Run.RemoveAt(0);
		}
		foreach(var i in vars.splits) {
			var segmentName = vars.segmentsList["split" + i.ToString()];
			vars.Log("Add segment => { " + segmentName.ToString() + " }");
			timer.Run.Add(new Segment(segmentName));
		}
		timer.Run.RemoveAt(0);
		vars.Log("Add segment => { The End }");
		timer.Run.Add(new Segment("The End"));
		timer.CallRunManuallyModified();
	};
	vars.AutoFillSegments = AutoFillSegments;
	vars.autoFillSegmentsLastValue = settings["advanced"] && settings["enable_segments_autofill"];
	if (vars.autoFillSegmentsLastValue)
		vars.AutoFillSegments();
}

update
{
	// Disable autosplitter script
	if (settings["advanced"] && settings["disable_autosplitter"]) {
		return false;
	}

	if (timer.CurrentPhase != TimerPhase.Ended) {
		// If the number of enabled splits changes => reload splits and soft reset
		if (vars.CountEnabledSplits() != vars.splits.Count)
		{
			vars.Log("reload enabled split settings");
			vars.UpdateEnabledSplits();
			if (settings["advanced"] && settings["enable_segments_autofill"])
				vars.AutoFillSegments();
			vars.softReset = true;
			return false;
		}

		// Trigger autofill segments if settings is enabled
		if (!vars.autoFillSegmentsLastValue && settings["advanced"] && settings["enable_segments_autofill"]) {
			vars.AutoFillSegments();
			vars.autoFillSegmentsLastValue = settings["advanced"] && settings["enable_segments_autofill"];
		}
		// Set autofill segments last value if settings is disabled
		if (vars.autoFillSegmentsLastValue && !(settings["advanced"] && settings["enable_segments_autofill"]))
			vars.autoFillSegmentsLastValue = settings["advanced"] && settings["enable_segments_autofill"];
	}

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
		vars.Log("do soft reset");
		vars.UpdateCurrSplit();
		vars.softReset = false;
		return true;
	}
}

start
{
	if (current.velocX != 0 || current.velocY != 0)
	{
		vars.Log("do start");
		vars.UpdateCurrSplit();
		vars.softReset = false;
		return true;
	}
}

split
{
	if (vars.currSplit < vars.splits.Count)
	{
		var i = vars.splits[vars.currSplit];

		double dist = vars.GetDistance3(current.coordX, current.coordY, current.coordZ, vars.splitsCoords[i, 0], vars.splitsCoords[i, 1], vars.splitsCoords[i, 2]);
		double radius = vars.splitsCoords[i, 3];
	
		if (dist <= radius) {
			var distance = dist - radius;
			vars.Log("trigger split with distance " + distance.ToString() + " => {" + i.ToString() + ", " + vars.segmentsList["split" + i.ToString()] + "}");
			return true;
		}
	}
	else if (324000 <= current.coordZ && current.coordZ <= 324300) // End Split
	{
		double dist1 = vars.GetDistance2(current.coordX, current.coordY, -4543.74, 19306.0);
		double dist2 = vars.GetDistance2(current.coordX, current.coordY, -4908.92, 18861.9);
		double total = dist1 + dist2;
		
		if (Math.Abs(vars.DistEnd - total) <= 30){
			var distance = Math.Abs(vars.DistEnd - total) - 30;
			vars.Log("trigger end split with distance " +  distance.ToString());
			return true;
		}
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
