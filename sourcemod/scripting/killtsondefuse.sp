#include <sourcemod>
#include <sdktools>
#include <cstrike>

#pragma newdecls required
#pragma semicolon 1

ConVar hPluginEnabled = null;

public Plugin myinfo = {
    name = "[KTOD] Kill Terrorists on Defuse",
    author = "B3none, Olle Thunberg",
    description = "Kills remaining teorists if bomb has been defused.",
    version = "1.0.1",
    url = "https://github.com/b3none"
}

public void OnPluginStart()
{
    HookEvent("bomb_defused", Event_BombDefused, EventHookMode_PostNoCopy);
    
    hPluginEnabled = CreateConVar("sm_ktod_enabled", "1", "If the plugin is enabled or not 1 = enabled, 0 = disabled", _, true, 0.0, true, 1.0);
    AutoExecConfig(true, "ktod");
}

public void Event_BombDefused(Event event, const char[] name, bool dontBroadcast)
{
    if (GetConVarInt(hPluginEnabled) == 1)
    {
    	for (int i = 1; i <= MaxClients; i++)
	{
	    if (IsValidClient(i) && IsPlayerAlive(i) && GetClientTeam(i) == CS_TEAM_T)
	    {
	        ForcePlayerSuicide(i);
	    }
	}
    }
}

stock bool IsValidClient(int client)
{
    return client > 0 && client <= MaxClients && IsClientInGame(client) && IsClientConnected(client) && IsClientAuthorized(client) && !IsFakeClient(client);
}
