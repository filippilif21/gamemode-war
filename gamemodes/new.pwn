#include <a_samp>
#include <streamer>
#include <a_mysql>
#include <zcmd>
#include <foreach>
#include <beaZone>

#pragma dynamic 3996516

/*ChangeLogs:

V - 000.1
- Facut sistemul de login si Register pe mysql.
- Facut sistemul deaths
- Acum daca mori iti pica armele si viata pe jos
Am abandonat proiectul.


V - 000.1B
- Am reinceput proiectul
- Acum gamemode ul este nemodular
- Acum se incarca toate datele din baza de date
- Adaugat anti money hack
- Acum cei de la FFA se spawneaza intr-un loc
- Acum cei de la grupuri se spawneaza intr un loc anume
- Comanda /stats adaugata

test
*/

enum
{
    DIALOG_LOGIN, 
    DIALOG_REGISTER,
    DIALOG_PAGE,
    DIALOG_SELECTGROUP
};

#define MAX_TURFS 100

enum TurfsInfo
{
    zID,
    Float:zMinX,
    Float:zMinY,
    Float:zMaxX,
    Float:zMaxY,
};
new tTurfs[MAX_TURFS][TurfsInfo], Turfs[MAX_TURFS];

enum pInfo
{
    pParola,
    pID,
    pAge,
    pAdmin,
    pHelper,
    pTester,
    pLevel,
    pKills,
    pDeaths,
    pPremiumAcc,
    pMoney,
    Float:pConnectTime,
    pGroup,
    pGroupRank
};
new PlayerData[MAX_PLAYERS][pInfo];

enum dInfo { 
    ID,
    Type,
    Weapon,
    Ammo,
    Text3D: Label
}
new DropInfo[MAX_PICKUPS][dInfo],
    activeHeal = 1,
    money[MAX_PLAYERS],
    handle;
main() {}

#define SCM SendClientMessage
#define AdmOnly "{5CAD5C}Error: Your admin/helper level isn't high enough to use this command."
#define Plconn  "Playerul nu este conectat"
#define function%0(%1) forward%0(%1); public%0(%1)
#define COLOR_WHITE         0xFFFFFFFF
#define COLOR_SERVER        0xA9C4E4FF
#define COLOR_RED           0xAA3333AA
#define COLOR_GRAD1         0xB4B5B7FF
#define COLOR_GRAD2         0xBFC0C2FF
#define COLOR_GRAD3         0xCBCCCEFF
#define COLOR_GRAD4         0xD8D8D8FF
#define COLOR_GRAD5         0xE3E3E3FF
#define COLOR_FADE1         0xE6E6E6E6
#define COLOR_FADE2         0xC8C8C8C8
#define COLOR_FADE3         0xAAAAAAAA
#define COLOR_FADE4         0x8C8C8C8C
#define COLOR_FADE5         0x6E6E6E6E
#define COLOR_YELLOW        0xDABB3EAA
#define COLOR_YELLOW2       0xF5DEB3AA
#define COLOR_PURPLE        0xC2A2DAAA
#define COLOR_LIGHTRED      0xFF6347AA
#define COLOR_HOTORANGE     0xF97804FF
#define COLOR_TEAL          0x67AAB1FF
#define COLOR_NEWBIE        0xBED9EFFF
#define COLOR_GREENOX      	0xB98300FF
#define COLOR_ADMCMD      	0xFFC000FF
#define COLOR_HELLOB     	0xCC8E33C8
#define COLOR_PNOB       	0xCEF0ACFF
#define COLOR_IN2         	0xe7aaa5a5

#define mysql_host "localhost" 
#define mysql_db "youtube"
#define mysql_user "root"
#define mysql_pass "muie"


/*

	PUBLICS

*/

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

    SetTimer("Timer1", 1000, true);
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
    mysql_format(handle, query, sizeof(query), "SELECT name FROM users WHERE name = '%s'", GetName(playerid));
    mysql_tquery(handle, query, "OnPlayerLogin", "i", playerid);

	for(new i = 1; i < sizeof(Turfs); i++) GangZoneShowForPlayerEx(playerid, Turfs[i], 0x0CAB3C99);

    return 1;
}


public OnPlayerDisconnect(playerid, reason)
{
    Update();

	return 1;
}

public OnPlayerSpawn(playerid)
{
    switch(PlayerData[playerid][pGroup]) {
        case 0: SetPlayerPos(playerid, 184.7070, -79.5437, 1.5703);
        case 1: SetPlayerPos(playerid, 229.3555, -307.3364, 1.5869);
        case 2: SetPlayerPos(playerid, 86.6632, -181.4275, 1.5094);
        case 3: SetPlayerPos(playerid, 51.1927, -141.4645, 0.7199);
    }

    GivePlayerWeapon(playerid,24,999);
	GivePlayerWeapon(playerid,30,999);

	if(PlayerData[playerid][pPremiumAcc] > 0) return SendClientMessage(playerid,-1,"Te-ai conectat cu cont premium");	

	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid != INVALID_PLAYER_ID) {

		PlayerData[killerid][pKills] ++;
		PlayerData[playerid][pDeaths] ++;

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
    new query[128];
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
		               
                        mysql_format(handle, query, sizeof(query), "INSERT INTO users (name, password) VALUES ('%s', '%e')", GetName(playerid), inputtext);
                        mysql_tquery(handle, query, "", "");
                  		
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
	        		if(strval(inputtext) < 10 || strval(inputtext) > 65)	return ShowPlayerDialog(playerid, DIALOG_PAGE, DIALOG_STYLE_INPUT, "{FFFFFF}Age step:", "{FFFFFF}Your age must be between 14 and 65 years old. Please retype your age below:", "Ok", "Exit");

	                PlayerData[playerid][pAge] += strval(inputtext);
	                PlayerData[playerid][pLevel]++;

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
						if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FFFFFF}Login Step:", "{FFFFFF}This isn't your account password. Please retype your account password below:\n\n{FFFFFF}If you aren't remember your account password, you can recover it from out website.", "Login", "Exit");
		               
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
        				case 0: EnterGroup(playerid,1,"Ai intrat in grupul 1");
        				case 1: EnterGroup(playerid,2,"Ai intrat in grupul 2");
        				case 2: EnterGroup(playerid,3,"Ai intrat in grupul 3");
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

function OnPlayerLogin(playerid)
{
    new rows, fields;
    cache_get_data(rows, fields);

    switch(rows)
    {
    	case 0: return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "{FFFFFF}Register Step:", "{FFFFFF}Your account isn't registered in our database.\n\n{FFFFFF}Please type below a password for your new account:", "Register", "Exit");
    	case 1: return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FFFFFF}Login Step:", "{FFFFFF}Your account is registered in our database.\n\n{FFFFFF}Please type below your account password:", "Login", "Exit");
    }
    return 1;
}

function OnLogin(playerid)
{
    new rows, fields,temporar[25];

    cache_get_data(rows, fields, handle);
    if(rows)
    {
        cache_get_field_content(0, "password",temporar), format(PlayerData[playerid][pParola], 25, temporar);
        PlayerData[playerid][pID] = cache_get_field_content_int(0, "id");
        PlayerData[playerid][pAge] = cache_get_field_content_int(0, "Age");
        PlayerData[playerid][pAdmin] = cache_get_field_content_int(0, "Admin");
        PlayerData[playerid][pHelper] = cache_get_field_content_int(0, "Helper");
        PlayerData[playerid][pTester] = cache_get_field_content_int(0, "Tester");
        PlayerData[playerid][pLevel] = cache_get_field_content_int(0, "Level");
        PlayerData[playerid][pKills] = cache_get_field_content_int(0, "Kills");
        PlayerData[playerid][pDeaths] = cache_get_field_content_int(0, "Deaths");
        PlayerData[playerid][pPremiumAcc] = cache_get_field_content_int(0, "PremiumAccount");
        PlayerData[playerid][pMoney] = cache_get_field_content_int(0, "Money");
        PlayerData[playerid][pConnectTime] = cache_get_field_content_float(0, "ConnectTime");
        PlayerData[playerid][pMoney] = cache_get_field_content_int(0, "Money");
        PlayerData[playerid][pGroup] = cache_get_field_content_int(0, "Group2");
        PlayerData[playerid][pGroupRank] = cache_get_field_content_int(0, "GroupRank");
        SpawnPlayer(playerid);
        LoadMoney(playerid);

    }
    else return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FFFFFF}Login Step:", "{FFFFFF}This isn't your account password. Please retype your account password below:\n\n{FFFFFF}If you aren't remember your account password, you can recover it from out website.", "Login", "Exit");

    return 1;
}

/*

	FOLOSITOARE

*/

function MySQLConnect()
{
    handle = mysql_connect(mysql_host, mysql_user, mysql_db, mysql_pass);

    switch(mysql_errno() !=0)
    {
        case 1:
        {
            printf("Conectarea la baza de date %s a esuat. Serverul a fost oprit.", mysql_db);
            SendRconCommand("exit");
        }
        case 0: printf("Conectarea la baza de date '%s' a fost executata cu succes !", mysql_db, mysql_user);
    }
    return 1;
}

function LoadMoney(playerid)
{
	ResetPlayerMoney(playerid);
    money[playerid] = PlayerData[playerid][pMoney];
    GivePlayerCash(playerid,money[playerid]);
}

stock GetPlayerCash(playerid) { 
   return money[playerid]; 
}

function GivePlayerCash(playerid, money2) {

    money[playerid] = money2;
    PlayerData[playerid][pMoney] = money[playerid];
    GivePlayerMoney(playerid, money[playerid]);
}

stock GetName(playerid)
{
	new Name[MAX_PLAYER_NAME];

	GetPlayerName(playerid, Name, sizeof(Name));
	return Name;
}

function SendNearMessage(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
    if(IsPlayerConnected(playerid))
    {
        new Float:posx, Float:posy, Float:posz;
        new Float:oldposx, Float:oldposy, Float:oldposz;
        new Float:tempposx, Float:tempposy, Float:tempposz;
        GetPlayerPos(playerid, oldposx, oldposy, oldposz);

        foreach(new i : Player)
        {
            if(IsPlayerConnected(i) && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)))
            {

                GetPlayerPos(i, posx, posy, posz);
                tempposx = (oldposx -posx);
                tempposy = (oldposy -posy);
                tempposz = (oldposz -posz);
                if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
                {
                    SendClientMessage(i, col1, string);
                }
                else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
                {
                    SendClientMessage(i, col2, string);
                }
                else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
                {
                    SendClientMessage(i, col3, string);
                }
                else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
                {
                    SendClientMessage(i, col4, string);
                }
                else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
                {
                    SendClientMessage(i, col5, string);
                }
            }
        }
    }//not connected
    return 1;
}

function KickPl(id)
{
    Kick(id);

}

function EnterGroup(id, group, string[]) {

    PlayerData[id][pGroup] = group;
    PlayerData[id][pGroupRank] = 1;
    SendClientMessage(id,-1, string);

}

function LeaveGroup(playerid) {

	PlayerData[playerid][pGroup] = 0;
	PlayerData[playerid][pGroupRank] = 0;

	PlayerData[playerid][pMoney] -= 1000000;

	LoadMoney(playerid);

}

function Timer1() {
    foreach(new i : Player) {
        if(GetPlayerMoney(i) != money[i]) {
            LoadMoney(i);
        }
    }
}

function Update() {
	
	foreach(new i : Player) {
		new var[125];
		mysql_format(handle, var, sizeof(var), "UPDATE `users` SET `Admin`='%d',`Helper`='%d',`Tester`='%d',`Level`='%d',`Kills`='%d',`Deaths`='%d',`PremiumAcc`='%d',`Money`='%d',`ConnectTime`='%f',`Group`='%d',`GroupRank`='%d' WHERE `id`='%d'",
			PlayerData[i][pAdmin],PlayerData[i][pHelper],PlayerData[i][pTester],PlayerData[i][pLevel],PlayerData[i][pKills],PlayerData[i][pDeaths],PlayerData[i][pPremiumAcc],PlayerData[i][pMoney],PlayerData[i][pConnectTime],PlayerData[i][pGroup],PlayerData[i][pGroupRank],PlayerData[i][pID]);
		mysql_tquery(handle,var,"","");

	}

}

function ResetPickups() {
    for(new i = 0; i < MAX_PICKUPS; i++) {
        if(DropInfo[i][ID] != -1) DropInfo[i][ID] = -1;
    }
    return 1;
}

function DestroyPickups() {
    for(new i = 0; i < MAX_PICKUPS; i++) {
        if(DropInfo[i][ID] != -1) {
            DestroyPickup(DropInfo[i][ID]);
            Delete3DTextLabel(DropInfo[i][Label]);
            DropInfo[i][Type] = 0;
            DropInfo[i][ID] = -1;
        }
    }
    return 1;
}
 
function drop_player_weapons(playerid, type) {
    new Float: Pos[3], string[128], gunname[32], sweapon, sammo, idd, result;
    GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
 
    for(new i = 0; i < 12; i++) {
        GetPlayerWeaponData(playerid, i, sweapon, sammo);
        if(sweapon != 0) {
            result++;
            idd = CheckIDEmpty();
            DropInfo[idd][ID] = CreatePickup(WeaponObject(sweapon), 23, Pos[0]+result, Pos[1]+2, Pos[2], -1);
            DropInfo[idd][Type] =  0;
            DropInfo[idd][Weapon] = sweapon;
            DropInfo[idd][Ammo] = sammo;
            GetWeaponName(sweapon, gunname, sizeof(gunname));          
            format(string, sizeof(string), "{90F037}%s\n{FFFFFF}%d bullets", gunname, sammo);          
            DropInfo[idd][Label] = Create3DTextLabel(string, 0xFFFFFFAA, Pos[0]+result, Pos[1]+2, Pos[2], 10.0, 0, 0);
        }
    }
    if(activeHeal == 1 && type == 0) {
        result++;
        idd = CheckIDEmpty();
        DropInfo[idd][ID] = CreatePickup(1240, 23, Pos[0]+result, Pos[1]+2, Pos[2], -1);
        DropInfo[idd][Type] = 1;
        DropInfo[idd][Weapon] = 0;
        DropInfo[idd][Ammo] = 0;
        DropInfo[idd][Label] = Create3DTextLabel("{DE1212}Medic kit", 0xFFFFFFFF, Pos[0]+result, Pos[1]+2, Pos[2], 10.0, 0, 0);
    }  
    ResetPlayerWeapons(playerid);
    return 1;
}
 
function CheckIDEmpty() {
    for(new i = 0; i < MAX_PICKUPS; i++) {
        if(DropInfo[i][ID] == -1) return i;
    }
    return 0;
}
 
function WeaponObject(wid) {
    if(wid == 1) return 331;
    else if(wid == 2) return 332;
    else if(wid == 3) return 333;
    else if(wid == 5) return 334;
    else if(wid == 6) return 335;
    else if(wid == 7) return 336;
    else if(wid == 10) return 321;
    else if(wid == 11) return 322;
    else if(wid == 12) return 323;
    else if(wid == 13) return 324;
    else if(wid == 14) return 325;
    else if(wid == 15) return 326;
    else if(wid == 23) return 347;
    else if(wid == 24) return 348;
    else if(wid == 25) return 349;
    else if(wid == 26) return 350;
    else if(wid == 27) return 351;
    else if(wid == 28) return 352;
    else if(wid == 29) return 353;
    else if(wid == 30) return 355;
    else if(wid == 31) return 356;
    else if(wid == 32) return 372;
    else if(wid == 33) return 357;
    else if(wid == 4) return 335;
    else if(wid == 34) return 358;
    else if(wid == 41) return 365;
    else if(wid == 42) return 366;
    else if(wid == 43) return 367;
    return 0;
}

function LoadTurfs()
{
	new result[100],index = 0;
    mysql_query(handle,"SELECT ID, MinX, MinY, MaxX, MaxY FROM `turfs` ORDER BY `turfs`.`ID` ASC");
    mysql_store_result();
    while(mysql_retrieve_row())
    {
		index++;
		new i = index;
		mysql_get_field("ID", result);				tTurfs[i][zID] = strval(result);
   	    mysql_get_field("MinX", result);			tTurfs[i][zMinX] = floatstr(result);
    	mysql_get_field("MinY", result);			tTurfs[i][zMinY] = floatstr(result);
        mysql_get_field("MaxX", result);			tTurfs[i][zMaxX] = floatstr(result);
        mysql_get_field("MaxY", result);			tTurfs[i][zMaxY] = floatstr(result);
	}
	mysql_free_result();
	printf("[MySQL Turfs]: %d", index);
	return 1;
}

/*

	CMDS

*/

CMD:selectgroup(playerid,params[]) {

	if(PlayerData[playerid][pGroup] != 0) return SendClientMessage(playerid,-1,"You are already in a group");

	ShowPlayerDialog(playerid, DIALOG_SELECTGROUP, DIALOG_STYLE_LIST, "Choose Group", "Group 1\nGroup 2\nGroup 3", "Ok", "FFA");

	return 1;
}

CMD:leavegroup(playerid,params[]) {


	if(PlayerData[playerid][pGroup] == 0) return SendClientMessage(playerid,-1,"You are not in a group");
	if(GetPlayerMoney(playerid) < 1000000) return SendClientMessage(playerid,-1,"You need 1,000,000$");

	LeaveGroup(playerid);

	return 1;
}

CMD:givemoney(playerid,params[]) {

	GivePlayerMoney(playerid, 1000000);

	PlayerData[playerid][pMoney] = 1000000;

	return 1;
}

CMD:stats(playerid, params[]) {

    new string[126];

    format(string, 126, "ID: %i Name: %s Varsta: %i Level: %i", playerid, GetName(playerid), PlayerData[playerid][pAge], PlayerData[playerid][pLevel]);
    SendClientMessage(playerid, -1, string);

    format(string, 126, "Kills: %i Deaths: %i", PlayerData[playerid][pKills], PlayerData[playerid][pDeaths], PlayerData[playerid][pGroup]);
    SendClientMessage(playerid, -1, "");

    return 1;
}

CMD:update(playerid,params[]) {
	Update();
	return 1;
}