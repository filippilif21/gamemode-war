#include <a_samp>
#include <a_mysql>
#include <foreach>

#include "../inc/new.pwn"

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

function loadmoney(playerid)
{
    GivePlayerMoney(playerid,P_Data[playerid][pMoney]);
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

function LeaveGroup(playerid) {

	P_Data[playerid][pGroup] = 0;
	P_Data[playerid][pGroupRank] = 0;

	P_Data[playerid][pMoney] -= 1000000;

	loadmoney(playerid);

}

function Update() {
	
	foreach(new i : Player) {
		new var[125];
		mysql_format(handle, var, sizeof(var), "UPDATE `users` SET `Admin`='%d',`Helper`='%d',`Tester`='%d',`Level`='%d',`Kills`='%d',`Deaths`='%d',`PremiumAcc`='%d',`Money`='%d',`ConnectTime`='%f',`Group`='%d',`GroupRank`='%d' WHERE `id`='%d'",
			P_Data[i][pAdmin],P_Data[i][pHelper],P_Data[i][pTester],P_Data[i][pLevel],P_Data[i][pKills],P_Data[i][pDeaths],P_Data[i][pPremiumAcc],P_Data[i][pMoney],P_Data[i][pConnectTime],P_Data[i][pGroup],P_Data[i][pGroupRank],P_Data[i][pID]);
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