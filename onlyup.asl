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

	// lower/upper limits for x/y/z
	vars.splitsCoords = new double[,,] {
	{ { 2845, 3005 }, { 16270, 16500 }, { 8695, 8700 } },		// station
	{ { 4200, 5100 }, { 4100, 5000 }, { 33800, 33915 } },		// oil
	{ { 2330, 3045 }, { 17270, 18250 }, { 47910, 48140 } },		// subway
	{ { 3825, 6325 }, { 6200, 9475 }, { 83575,  83920} },		// highway
	{ { 4121, 4354 }, { 12032, 12254 }, { 90034,  90038} },		// elevator
	{ { 950, 2550 }, { 5525, 7150 }, { 104644, 104645 } },		// winner
	{ { 900, 1500 }, { 3700, 3900 }, { 156025, 156150 } },		// hand
	{ { -1300, -450 }, { 4750, 5250 }, { 171860, 171863 } },	// enpassant
	{ { -1225, -1190 }, { 9215, 9240 }, { 198845, 198865 } },	// cannon
	{ { 990, 1180 }, { 24550, 24745 }, { 244575, 244600 } },	// apple
	{ { 250, 900 }, { 13100, 13800 }, { 283340, 283950 } },		// illuminati
	{ { -5030, -4580 }, { 18900, 19230 }, { 324115, 324210 } },	// congrats
	};
	
	vars.maxSplits = vars.splitsCoords.Length / 6;
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

	if(current.coordX > vars.splitsCoords.GetValue(i,0,0) && current.coordX < vars.splitsCoords.GetValue(i,0,1) &&
			current.coordY > vars.splitsCoords.GetValue(i,1,0) && current.coordY < vars.splitsCoords.GetValue(i,1,1) &&
			current.coordZ > vars.splitsCoords.GetValue(i,2,0) && current.coordZ < vars.splitsCoords.GetValue(i,2,1))
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
