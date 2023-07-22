/*
 * Only Up! Autosplitter
 *
 * Made by/with the help of:
 *	- wRadion
 *	- MkLoM
 *	- traumvogel
 *	- t0mz3r
 *	- NeKRooZz
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
	// central point coords x/y/z and radius for each sphere
	vars.splitsCoords = new Dictionary<string, double[]> {
		{ "Favelas Elevator", new double[] {1675.95, 4147.05, -3111.73, 132} },
		{ "Pipe Maze Start", new double[] {2433.23, 5994.06, 1943.62, 106} },
		{ "Train Station", new double[] {3537.17, 17051.4, 9916.54, 1600} },
		{ "Rails Start", new double[] {4276.85, 13362.6, 9386.93, 313} },
		{ "Bed Rails Skip", new double[] {4464.73, 9947.69, 9343.95, 211} },
		{ "Oil Refinery", new double[] {4623.09, 4867.59, 33884.4, 170} },
		{ "Factory", new double[] {1140.69, 5483.92, 43327.6, 250} },
		{ "Subway", new double[] {2257.24, 18548.2, 48138.5, 1254} },
		{ "Drone", new double[] {-2794.33, 11254.3, 50514.1, 306} },
		{ "Hidden Drone", new double[] {-5419.74, 17765.7, 48451.3, 142} }, // Bedless
		{ "First Crane Moving Platform", new double[] {-2748.96, 17716.8, 51106.9, 300} }, // Bedless
		{ "Second Crane Moving Platform", new double[] {163.299, 9072.25, 53293.8, 1000} }, // Bedless
		{ "Wind Turbine", new double[] {-575.563, 5428.8, 60235.8, 359} }, // Bedless
		{ "Road Dog", new double[] {-5964.56, 19767.6, 67297.3, 1405} }, // Bedless
		{ "Dumpsters", new double[] {1994.05, 13085.2, 73074.5, 685} }, // Bedless
		{ "Storage", new double[] {-3051.13, 22349.7, 74827.4, 1935} }, // Bedless
		{ "Supermarket", new double[] {-1960.63, 10287.2, 79651, 1074} }, // Bedless
		{ "Highway", new double[] {5434.17, 8707.72, 83707.9, 814} }
		{ "Bus After Highway", new double[] {5002.46, 18339.7, 86105.2, 66} },
		{ "Big Wheel End", new double[] {-4061.07, 8049.63, 89914.4, 313} }, // Bedless
		{ "Elevator", new double[] {4235.71, 12152.4, 90037.1, 105} },
		{ "Fake Winner Platform", new double[] {2936, 8172.93, 105057, 2921} },
		{ "Crown", new double[] {2757.16, 6867.43, 104860, 90} }, // All Collectibles
		{ "Elevator to Heaven", new double[] {3094.08, 8919.15, 105688, 462} },
		{ "Heaven", new double[] {-417.533, 15277.4, 138394, 1101} },
		{ "Hand", new double[] {1064.72, 3701.3, 156054, 453} },
		{ "After Chess", new double[] {-1537.41, 3881.58, 171863, 1392} },
		{ "Brain", new double[] {-1396.83, 3699.18, 172261, 90} }, // All Collectibles
		{ "Rose", new double[] {8949.83, 1516.15, 174676, 90} }, // All Collectibles
		{ "Turtle", new double[] {10802.4, 8502.28, 175005, 282} }, // Bedless
		{ "Heart", new double[] {-2327.15, 24100.7, 184913, 90} }, // All Collectibles
		{ "Ship", new double[] {-12363.2, 21183.6, 189660, 984} },
		{ "Cannon", new double[] {-1209.93, 9218.39, 198943, 50} },
		{ "Orange", new double[] {9238.43, 17127.9, 213186, 120} }, // All Collectibles
		{ "Beer", new double[] {1675.55, 19096, 218573, 100} }, // All Collectibles
		{ "Helicopter", new double[] {3034.85, -509.768, 216340, 89} }, // Bedless
		{ "Mask", new double[] {7714.49, 21642.4, 232480, 80} }, // All Collectibles
		{ "Flower", new double[] {3426.76, 7402.79, 236601, 100} }, // All Collectibles
		{ "Coin 1", new double[] {8049.2, 6327.75, 240145, 80} }, // All Collectibles
		{ "Coin 2", new double[] {7692.07, 6424.53, 240165, 80} }, // All Collectibles
		{ "Small Boat", new double[] {7592.33, 6797.72, 240088, 214} }, // Bedless
		{ "Golden Apple Elevator", new double[] {1005.6, 24691.5, 244610, 97} },
		{ "Golden Apple", new double[] {982.74, 24728.4, 244655, 90} }, // All Collectibles
		{ "Dragon Maze", new double[] {2279.77, 18551, 260399, 291} },
		{ "Hoverboard", new double[] {-2243.08, 9062.34, 270368, 120} },
		{ "Space Start", new double[] {1353.83, 15993, 283501, 3000} },
		{ "Egg", new double[] {2218.67, 16104, 283501, 100} }, // All Collectibles
		{ "Space First Bumper", new double[] {2380.47, 16558.2, 283679, 295} },
	};

	vars.anySegmentsList = new string[] {
		"Favelas Elevator",
		"Pipe Maze Start",
		"Train Station",
		"Rails Start",
		"Bed Rails Skip",
		"Oil Refinery",
		"Factory",
		"Subway",
		"Drone",
		"Highway",
		"Bus After Highway",
		"Elevator",
		"Fake Winner Platform",
		"Elevator to Heaven",
		"Heaven",
		"Hand",
		"After Chess",
		"Ship",
		"Cannon",
		"Golden Apple Elevator",
		"Dragon Maze",
		"Hoverboard",
		"Space Start",
		"Space First Bumper",
	};

	vars.bedlessSegmentsList = new string[] {
		"Favelas Elevator",
		"Pipe Maze Start",
		"Train Station",
		"Rails Start",
		"Oil Refinery",
		"Factory",
		"Subway",
		"Drone",
		"Hidden Drone", // Bedless
		"First Crane Moving Platform", // Bedless
		"Second Crane Moving Platform", // Bedless
		"Wind Turbine", // Bedless
		"Road Dog", // Bedless
		"Dumpsters", // Bedless
		"Storage", // Bedless
		"Supermarket", // Bedless
		"Highway",
		"Bus After Highway",
		"Big Wheel End", // Bedless
		"Elevator",
		"Fake Winner Platform",
		"Elevator to Heaven",
		"Heaven",
		"Hand",
		"After Chess",
		"Turtle", // Bedless
		"Ship",
		"Cannon",
		"Helicopter", // Bedless
		"Small Boat", // Bedless
		"Golden Apple Elevator",
		"Dragon Maze",
		"Hoverboard",
		"Space Start",
		"Space First Bumper",
	};

	vars.collectiblesSegmentsList = new string[] {
		"Favelas Elevator",
		"Pipe Maze Start",
		"Train Station",
		"Rails Start",
		"Bed Rails Skip",
		"Oil Refinery",
		"Factory",
		"Subway",
		"Drone",
		"Highway",
		"Bus After Highway",
		"Elevator",
		"Fake Winner Platform",
		"Crown", // All Collectibles
		"Elevator to Heaven",
		"Heaven",
		"Hand",
		"After Chess",
		"Brain", // All Collectibles
		"Rose", // All Collectibles
		"Heart", // All Collectibles
		"Ship",
		"Cannon",
		"Coin 1", // All Collectibles
		"Coin 2", // All Collectibles
		"Flower", // All Collectibles
		"Mask", // All Collectibles
		"Orange", // All Collectibles
		"Beer", // All Collectibles
		"Golden Apple Elevator",
		"Golden Apple", // All Collectibles
		"Dragon Maze",
		"Hoverboard",
		"Space Start",
		"Egg",
		"Space First Bumper",
	};

	settings.Add("segments_any", false, "Any%");
	settings.Add("segments_bedless", false, "Bedless");
	settings.Add("segments_collectibles", false, "All Collectibles");

	for (int i = 0; i < vars.anySegmentsList.Length; ++i)
		settings.Add("any_split" + i.ToString(), false, vars.anySegmentsList[i], "segments_any");

	for (int i = 0; i < vars.bedlessSegmentsList.Length; ++i)
		settings.Add("bedless_split" + i.ToString(), false, vars.bedlessSegmentsList[i], "segments_bedless");

	for (int i = 0; i < vars.collectiblesSegmentsList.Length; ++i)
		settings.Add("collectibles_split" + i.ToString(), false, vars.collectiblesSegmentsList[i], "segments_collectibles");

	settings.Add("advanced", false, "Advanced Settings");
	settings.SetToolTip("advanced", "Number of splits in \"Edit Splits\" = (Number of splits checked in \"Autosplitter\") + 1");
	settings.Add("enable_debug_logs", false, "Enable Debug Logs", "advanced");
	settings.Add("enable_segments_autofill", false, "Enable Segments Autofill (WARNING: Will delete all your splits, including times)", "advanced");
	settings.SetToolTip("enable_segments_autofill", "WARNING: Any of your current splits Segments in \"Edit Splits\" will be removed, including their times!\nIf you want to keep them do \"Save Splits As...\" before!");

	refreshRate = 30;
	vars.currSplit = 0;
	vars.currentCategory = null;
	vars.splits = new List<string>();
	vars.enabledSplitsCount = 0;

	Func<double, double, double, double, double, double, double> GetDistance = (x1, y1, z1, x2, y2, z2) => {
		double dx = x2 - x1;
		double dy = y2 - y1;
		double dz = z2 - z1;

		return Math.Sqrt(dx * dx + dy * dy + dz * dz);
	};
	vars.GetDistance = GetDistance;

	Action UpdateCurrSplit = () => {
		if (timer.Run.Count == 1)
			vars.currSplit = vars.splits.Count;
	};
	vars.UpdateCurrSplit = UpdateCurrSplit;

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

	// Print logs if setting enable_debug_logs is enabled
	Action<string> Log = (message) => {
		if (settings["enable_debug_logs"])
			print("[ASL][OnlyUP] " + message);
	};
	vars.Log = Log;

	// Get Current Checked Category
	Func<string> GetCategory = () => {
		if (settings["segments_any"])
			return "any";
		else if (settings["segments_bedless"])
			return "bedless";
		else if (settings["segments_collectibles"])
			return "collectibles";
		else
			return null;
	};
	vars.GetCategory = GetCategory;

	// Get Current Segments from Category
	Func<string[]> GetSegmentsList = () => {
		if (settings["segments_any"])
			return vars.anySegmentsList;
		else if (settings["segments_bedless"])
			return vars.bedlessSegmentsList;
		else if (settings["segments_collectibles"])
			return vars.collectiblesSegmentsList;
		else
			return null;
	};
	vars.GetSegmentsList = GetSegmentsList;

	// Count enabled splits in settings
	Func<bool> TriggerRefreshSplits = () => {
		string category = vars.GetCategory();
		string[] segments = vars.GetSegmentsList();

		if (category == null)
			return vars.splits.Count == 0;

		int count = 0;
		for (int i = 0; i < segments.Length; ++i)
		{
			if (settings[category + "_split" + i.ToString()])
				++count;
		}

		bool result = category != vars.currentCategory || count != vars.splits.Count;
		vars.currentCategory = category;

		return result;
	};
	vars.TriggerRefreshSplits = TriggerRefreshSplits;

	// Reload enabled vars.splits list
	Action UpdateEnabledSplits = () => {
		string category = vars.GetCategory();
		string[] segments = vars.GetSegmentsList();

		if (category != null)
		{
			vars.splits.Clear();
			for (int i = 0; i < segments.Length; ++i)
			{
				if (settings[category + "_split" + i.ToString()])
					vars.splits.Add(segments[i]);
			}
			vars.UpdateCurrSplit();

			vars.Log("Splits enabled => { " + String.Join(", ", vars.splits) + " }");
		}
		else
			vars.Log("No Splits enabled!");
	};
	vars.UpdateEnabledSplits = UpdateEnabledSplits;
	vars.UpdateEnabledSplits();

	// Reload segments when autofill is enabled
	Action AutoFillSegments = () => {
		// Remove all current splits
		var segmentCount = timer.Run.Count;
		for (int i = 0; i < segmentCount - 1; ++i)
		{
			timer.Run.RemoveAt(0);
		}

		// Add all checked splits
		foreach (var seg in vars.splits)
		{
			vars.Log("Add segment => { " + seg + " }");
			timer.Run.Add(new Segment(seg));
		}

		timer.Run.RemoveAt(0);
		vars.Log("Add segment => { The End }");
		timer.Run.Add(new Segment("The End"));
		timer.CallRunManuallyModified();
		vars.UpdateCurrSplit();
	};
	vars.AutoFillSegments = AutoFillSegments;
	vars.autoFillSegmentsLastValue = settings["enable_segments_autofill"];
	if (vars.autoFillSegmentsLastValue)
		vars.AutoFillSegments();

	// Endgame cutscene start detection
	IntPtr DisableInputPtr = modules.First().BaseAddress + 0x191FE80;
	if (game != null && memory.ReadValue<ulong>(DisableInputPtr) == 0x74894810245C8948) // Check we're at the right place
	{
		vars.endSeqPtr = game.AllocateMemory(4+6+15+14);
		vars.injCodePtr = vars.endSeqPtr + 4;

		vars.Log("pointer to hook code : " + vars.injCodePtr.ToString("X"));

		List<byte> codetoinj = new List<byte>();
		byte[] incSeq = { 0xFF, 0x05, 0xF6, 0xFF, 0xFF, 0xFF };
		codetoinj.AddRange(incSeq);
		codetoinj.AddRange(memory.ReadBytes((IntPtr)(modules.First().BaseAddress + 0x191FE80), 0xF));
		byte[] jmpback = { 0xFF, 0x25, 0, 0, 0, 0 };	// jmp DisableInput+0xF
		codetoinj.AddRange(jmpback);
		codetoinj.AddRange(BitConverter.GetBytes((long)(DisableInputPtr+0xF)));
		memory.WriteBytes((IntPtr)vars.injCodePtr, codetoinj.ToArray());

		byte[] overwrjmp = { 0xFF, 0x25, 0, 0, 0, 0 };	// jmp to injected code
		memory.WriteBytes((IntPtr)(modules.First().BaseAddress + 0x191FE80), overwrjmp);
		memory.WriteBytes((IntPtr)(modules.First().BaseAddress + 0x191FE86), BitConverter.GetBytes((long)vars.injCodePtr));
		memory.WriteValue<byte>((IntPtr)(modules.First().BaseAddress + 0x191FE86 + 8), 0x90);	// add a nop in that 1 byte gap

		vars.sigPtr = IntPtr.Zero;
	}
}

update
{
	if (vars.currSplit < vars.splits.Count)
		vars.Log("Current Split: " + vars.splits[vars.currSplit]);
	else
		vars.Log("Current Split: The End");

	if (timer.CurrentPhase != TimerPhase.Ended)
	{
		// If the number of enabled splits changes => reload splits and soft reset
		if (vars.TriggerRefreshSplits())
		{
			vars.Log("reload enabled split settings");
			vars.UpdateEnabledSplits();
			if (settings["enable_segments_autofill"])
				vars.AutoFillSegments();
			vars.softReset = true;
			return false;
		}

		// Trigger autofill segments if settings is enabled
		if (!vars.autoFillSegmentsLastValue && settings["enable_segments_autofill"])
		{
			vars.AutoFillSegments();
			vars.autoFillSegmentsLastValue = settings["enable_segments_autofill"];
			vars.softReset = true;
			return false;
		}
		// Set autofill segments last value if settings is disabled
		if (vars.autoFillSegmentsLastValue && !settings["enable_segments_autofill"])
		{
			vars.autoFillSegmentsLastValue = settings["enable_segments_autofill"];
		}
	}

	if (vars.sigPtr != IntPtr.Zero)
	{
		if (memory.ReadValue<ulong>((IntPtr)vars.sigPtr) == 0x10002080C21)
		{
			return true;
		}
		else
		{
			vars.sigPtr = IntPtr.Zero;		// sig lost
			vars.Log("Sig lost");
		}
	}

	if (current.coordX == 0 && current.coordY == 0 && current.coordZ == 0)
	{
		vars.softReset = true;
		return false;
	}
	else if (vars.sigPtr == IntPtr.Zero) // Game running, initialize sig
	{
		IntPtr sig;
		new DeepPointer(0x073C5ED8, 0x180, 0xA0, 0x98, 0xA8, 0x60, 0x328, 0x188).DerefOffsets(game, out sig);
		vars.sigPtr = sig;
		vars.Log("Sig address = " + vars.sigPtr.ToString("X"));
	}
}

reset
{
	if (vars.softReset && current.velocX == 0 && current.velocY == 0)
	{
		vars.Log("Do soft reset");
		vars.UpdateCurrSplit();
		vars.softReset = false;
		return true;
	}
}

start
{
	if (current.velocX != 0 || current.velocY != 0)
	{
		vars.Log("Do start");
		vars.UpdateCurrSplit();
		vars.softReset = false;
		return true;
	}
}

split
{
	if (vars.currSplit < vars.splits.Count)
	{
		var seg = vars.splits[vars.currSplit];

		double dist = vars.GetDistance(current.coordX, current.coordY, current.coordZ, vars.splitsCoords[seg][0], vars.splitsCoords[seg][1], vars.splitsCoords[seg][2]);
		double radius = vars.splitsCoords[seg][3];

		if (dist <= radius) {
			var distance = dist - radius;
			vars.Log("Trigger split with distance " + distance.ToString() + " => " + seg);
			return true;
		}
	}
	else if (memory.ReadValue<int>((IntPtr)vars.endSeqPtr) > 0) // End Split
	{
		memory.WriteValue<int>((IntPtr)vars.endSeqPtr, 0); // Reset flag for next time
		return true;
	}
}

onSplit
{
	if (vars.currSplit < vars.splits.Count)
	{
		vars.currSplit++;
	}
}

onReset
{
	vars.currSplit = 0;
}

shutdown
{
	if (game != null) // Remove our hook and free mem
	{
		var origcode = memory.ReadBytes((IntPtr)(vars.injCodePtr + 6), 0xF);
		memory.WriteBytes((IntPtr)(modules.First().BaseAddress + 0x191FE80), origcode);
		memory.FreeMemory((IntPtr)vars.endSeqPtr);
	}
}
