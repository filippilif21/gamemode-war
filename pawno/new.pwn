#define FILTERSCRIPT

#include <a_samp>
#include <sscanf2>
#include <zcmd>

#if defined FILTERSCRIPT

#define SCM SendClientMessage

new CerereTrimisa[MAX_PLAYERS];
new DejaCasatorit[MAX_PLAYERS];
new CererePrimitaDe[MAX_PLAYERS];
new CererePrimita[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" System married"); // nuj daca am scris bine sal pa
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif



public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Blank Script");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

CMD:marriedwith(playerid,params[]) {

	new player,string[100];

	if(CerereTrimisa[playerid] == 1) return SCM(playerid, -1, "Ai trimis deja o cerere.");
	if(DejaCasatorit[playerid] == 1) return SCM(playerid, -1, "Esti deja casatorit. Foloseste /divorce %d pentru a divorta");

	if(sscanf(params, "u", player)) return SCM(playerid, -1, "/marriedwith <Name/PlayerID>");

	if(DejaCasatorit[player] == 1) return SCM(playerid, -1, "%s este deja casatorit.");

	format(string,sizeof(string), "%s doreste sa se casatoreasca cu tine. Foloseste comanda /acceptmarried %d pentru a te casatori cu %s.", GetName(playerid),playerid,GetName(playerid));
	SCM(player, -1, string);

	SCM(playerid, -1, "Asteapta un raspuns.");

	CerereTrimisa[playerid] = 1;
	CererePrimitaDe[player] = playerid;
	CererePrimita[player] = 1;

	return 1;

}

CMD:acceptmarried(playerid,params[]) {

	new player,string[100];

	if(CererePrimita[playerid] == 0) return SCM(playerid, -1, "Nu ai primit nici o cerere.");
	if(DejaCasatorit[playerid] == 1) return SCM(playerid, -1, "Nu poti folosi aceasta comanda.");

	if(sscanf(params, "u", player)) return SCM(playerid, -1, "/acceptmarried <Name/PlayerID>");

	if(CererePrimitaDe[playerid] == player) {

		format(string,sizeof(string),"Un nou cuplu de gay este in oras. %s[%d] & %s[%d] s-au casatorit. Casa de piatra !"GetName(playerid),playerid,GetName(player),player);
	    SendClientMessageToAll(-1, string);

	    DejaCasatorit[playerid] == 1;
		CererePrimita[playerid] == 0;
		CererePrimitaDe[playerid] == 0;
		CerereTrimisa[player] == 0;
		CererePrimita[player] == 0;
	} else { SCM(playerid, -1, "Nu ai primit nici o cerere de la acest jucator.");



	return 1;
}
forawrd GetName(playerid);
public GetName(playerid) {

	new Name[MAX_PLAYER_NAME];

	GetPlayerName(playerid,Name,MAX_PLAYER_NAME);

	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
