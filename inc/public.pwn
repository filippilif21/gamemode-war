#include <a_samp>
#include <a_mysql>
#include <zcmd>
#include <foreach>
#include <beaZone>

#include "../inc/all_includes.pwn"
#include "../inc/new.pwn"
#include "../inc/connection.pwn"
#include "../inc/reglog.pwn"
#include "../inc/dialogs.pwn"
#include "../inc/stock.pwn"
#include "../inc/turfsystem.pwn"

main() {}



public OnGameModeInit()
{
	AddPlayerClass(0,158.7396,-107.5260,4.8965,273.4959,0,0,0,0,0,0);

	MySQLConnect();
	ResetPickups();
	LoadTurfs();

	LimitPlayerMarkerRadius(5.0);
    SetNameTagDrawDistance(30);
    ShowPlayerMarkers(2);
    EnableStuntBonusForAll(0);
    UsePlayerPedAnims();
    DisableInteriorEnterExits();
    AllowInteriorWeapons(1);

    foreach(new i : Player) {
    	Turfs[i] = GangZoneCreateEx(tTurfs[i][zMinX],tTurfs[i][zMinY],tTurfs[i][zMaxX],tTurfs[i][zMaxY],i,1);
    }


    SetTimer("Update", 300000, true);

	return 1;
}

public OnGameModeExit()
{
	mysql_close(handle);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
    new query[100];
    mysql_format(handle, query, sizeof(query), "SELECT * FROM users WHERE name = '%s'", GetName(playerid));
    mysql_tquery(handle, query, "OnPlayerLogin", "i", playerid);

	for(new i = 1; i < sizeof(Turfs); i++) GangZoneShowForPlayerEx(playerid, Turfs[i], 0x0CAB3C99);

    return 1;
}


public OnPlayerDisconnect(playerid, reason)
{
	new money = GetPlayerMoney(playerid);
	P_Data[playerid][pMoney] = money;


	for(new i = 1; i < sizeof(Turfs); i++) GangZoneHideForPlayerEx(playerid, Turfs[i]);

	return 1;
}

public OnPlayerSpawn(playerid)
{

    GivePlayerWeapon(playerid,24,999);
	GivePlayerWeapon(playerid,30,999);

	if(P_Data[playerid][pPremiumAcc] > 0) return SendClientMessage(playerid,-1,"Te-ai conectat cu cont premium");	

	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid != INVALID_PLAYER_ID) {

		P_Data[killerid][pKills] ++;
		P_Data[playerid][pDeaths] ++;

	}

	drop_player_weapons(playerid, 0);

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

	new string[456];
	format(string, sizeof(string), "%s says: %s", GetName(playerid), text);
	SendNearMessage(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
 	SetPlayerChatBubble(playerid, text, COLOR_YELLOW2, 4.0, strlen(text)*680);
	return 0;
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

public OnPlayerPickUpPickup(playerid, pickupid) {
    new string[128];
    for(new i = 0; i < MAX_PICKUPS; i++) {     
        if(pickupid == DropInfo[i][ID] && DropInfo[i][ID] != -1) { 
            if(DropInfo[i][Type] == 1) {
                SendClientMessage(playerid, COLOR_YELLOW2, "You picked up medic kit. (+10 hp)");
                new Float: HP;
                GetPlayerHealth(playerid, HP);
                if(HP < 90) SetPlayerHealth(playerid, HP+10);
                else SetPlayerHealth(playerid, 100);
            }
            else {
                new gunname[32];
                GetWeaponName(DropInfo[i][Weapon], gunname, sizeof(gunname));
                format(string, sizeof(string), "You picked up weapon %s (%d ammo).", gunname, DropInfo[i][Ammo]);
                SendClientMessage(playerid, COLOR_YELLOW2, string);
                GivePlayerWeapon(playerid, DropInfo[i][Weapon], DropInfo[i][Ammo]);
            }          
            DestroyPickup(DropInfo[i][ID]);
            Delete3DTextLabel(DropInfo[i][Label]);
            DropInfo[i][Type] = 0;
            DropInfo[i][ID] = -1;
            PlayerPlaySound(playerid, 1150, 0.0, 0.0, 10.0);   
        }  
    }
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
	if(newkeys == KEY_WALK) drop_player_weapons(playerid, 1);
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
    new query[128], ip[25];
    switch(dialogid)
    {
        case DIALOG_REGISTER:
        {
		     switch(response)
		     {

		            case 0: Kick(playerid);
		            case 1:
		            {
		                if(strlen(inputtext) < 8 || strlen(inputtext) > 24)		return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "{FFFFFF}Register Step:", "{FFFFFF}Your password must be between 8 and 24 characters.\n\nPlease retype below a password for your new account:", "Register", "Exit");

		                GetPlayerIp(playerid, ip, sizeof(ip));
		                mysql_format(handle, query, sizeof(query), "INSERT INTO users (name, password, IP) VALUES ('%s', '%e', '%s')", GetName(playerid), inputtext, ip);
		                mysql_query(handle, query);
		                P_Data[playerid][pMoney] += 5000;

                  		ShowPlayerDialog(playerid, DIALOG_PAGE, DIALOG_STYLE_INPUT, "{FFFFFF}Age step:", "{FFFFFF}Please type below your age:", "Ok", "Exit");
		            }
		    }
		     return 1;
        }
        case DIALOG_PAGE:
        {
        	switch(response)
        	{
	        	case 0: Kick(playerid);
	        	case 1:
	        	{
	        		if(strval(inputtext) < 14 || strval(inputtext) > 65)	return ShowPlayerDialog(playerid, DIALOG_PAGE, DIALOG_STYLE_INPUT, "{FFFFFF}Age step:", "{FFFFFF}Your age must be between 14 and 65 years old. Please retype your age below:", "Ok", "Exit");

	                P_Data[playerid][pAge] += strval(inputtext);
	                P_Data[playerid][pLevel]++;

	                SpawnPlayer(playerid);
	        	}
		    }
		    return 1;
        }
        case DIALOG_LOGIN:
        {
        	switch(response)
        	{
		            case 0: Kick(playerid);
		            case 1:
		            {
						if(!strlen(inputtext))
								return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FFFFFF}Login Step:", "{FFFFFF}This isn't your account password. Please retype your account password below:\n\n{FFFFFF}If you aren't remember your account password, you can recover it from out website.", "Login", "Exit");
		               
						mysql_format(handle, query, sizeof(query), "SELECT * FROM `users` WHERE `name`='%e' AND `password` = '%e'", GetName(playerid),inputtext);
						mysql_tquery(handle, query, "OnLogin", "i", playerid);
						SpawnPlayer(playerid);
		            }
		    }        
            return 1;
        }
        case DIALOG_SELECTGROUP:
        {
        	switch(response)
        	{
        		case 0: return 1;
        		case 1:
        		{
        			switch(listitem)
        			{
        				case 0:
        				{
        					P_Data[playerid][pGroup] = 1;
        					P_Data[playerid][pGroupRank] = 1;
        					SendClientMessage(playerid,-1, "Ai intrat in grupul 1");
        				}
        				case 1:
        				{
        					P_Data[playerid][pGroup] = 2;
        					P_Data[playerid][pGroupRank] = 2;
        					SendClientMessage(playerid,-1, "Ai intrat in grupul 2");
        				}
        				case 2:
        				{
        					P_Data[playerid][pGroup] = 3;
        					P_Data[playerid][pGroupRank] = 3;
        					SendClientMessage(playerid,-1, "Ai intrat in grupul 3");
        				}
        			}
        		}
        	}
        }

    }
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}


