state("OnlyUp") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("UnrealEngine.Runtime.AslHelper");
    vars.Helper.GameName = "OnlyUp";
    vars.Helper["GameProcess"] = vars.Helper.MakeStruct("_instance", "GameProcess", "IsRunning");

    vars.Helper["Player"] = vars.Helper.MakeStruct("_instance", "Player", "Position");
}


update
{
    current.IsGameRunning = vars.Helper["GameProcess"].Value;
    current.PlayerPosition = vars.Helper["Player"].Value;
}


onStart
{
    vars.Log("START");
}

start
{
    // Ici, vous définissez quand le timer doit démarrer.
    // Par exemple, si le timer doit démarrer quand le joueur entre dans la première sphère, vous pouvez le faire comme ça:
    return old.PlayerPosition != sphereCenters["apple"] && current.PlayerPosition == sphereCenters["apple"];
}

split
{
    // Ici, vous définissez quand le timer doit faire un split.
    // Par exemple, si le timer doit faire un split à chaque fois que le joueur entre dans une nouvelle sphère, vous pouvez le faire comme ça:
    foreach (var sphere in sphereCenters) {
        if (old.PlayerPosition != sphere.Value && current.PlayerPosition == sphere.Value) {
            return true;
            vars.Log("SPLIT");
        }
    }
    return false;
}

onReset
{
    vars.Log("RESETTING");
}

reset
{
    if (!current.IsGameRunning) {
        return old.runStartTime > 0 && current.runStartTime == 0;
    }
}

exit
{
    vars.Helper.Dispose();
}

shutdown
{
    vars.Helper.Dispose();
}