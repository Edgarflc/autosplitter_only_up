state("Only Up!) {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("UnrealEngine.Runtime.AslHelper");
    vars.Helper.GameName = "Only Up!";   
}

split
{
    return true;
    vars.Log("SPLIT");
}

reset
{
    return old.runStartTime > 0 && current.runStartTime == 0;
}
