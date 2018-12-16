#include <sourcemod>
public Plugin myinfo = {
    name="KillTsOnDefuse",
    author="Olle Thunberg",
	description = "Kills remaining teorists if bomb has been defused.",
	version = "1.0",
	url = "http://www.sourcemod.net/"
}

ConVar sm_enabled = null;

public void OnPluginStart(){

    HookEvent("bomb_defused", Event_KillT, EventHookMode_PostNoCopy);
    sm_enabled = CreateConVar("sm_enabled", "1", "If the plugin is enabled or not 1 = enabled, 2 = disabled");
	AutoExecConfig(true, "KillTsOnDefuse");
}
public void Event_KillT(Event event, const char[] name, bool dontBroadcast){
    int defuser_id = event.GetInt("userid");

    int defuser = GetClientOfUserId(defuser_id);

    char defuserName[MAX_NAME_LENGTH];

    GetClientName(defuser, defuserName, sizeof(defuserName));

    if(GetConVarInt(sm_enabled) == 1){
        ServerCommand("sm_slay @t");
    }
}