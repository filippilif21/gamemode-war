#include <a_samp>
#include <a_mysql>
#include <foreach>

#include "../inc/all_includes.pwn"
#include "../inc/new.pwn"
#include "../inc/public.pwn"
#include "../inc/dialogs.pwn"

forward OnPlayerLogin(playerid);
public OnPlayerLogin(playerid)
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



forward OnLogin(playerid);
public OnLogin(playerid)
{
    new rows, fields,temporar[200];

    cache_get_data(rows, fields);
    if(rows)
    {
        cache_get_field_content(0, "password",temporar), format(P_Data[playerid][pParola], 25, temporar);
        P_Data[playerid][pID] = cache_get_field_content_int(0, "id");
        P_Data[playerid][pAge] = cache_get_field_content_int(0, "Age");
        P_Data[playerid][pAdmin] = cache_get_field_content_int(0, "Admin");
        P_Data[playerid][pHelper] = cache_get_field_content_int(0, "Helper");
        P_Data[playerid][pTester] = cache_get_field_content_int(0, "Tester");
        P_Data[playerid][pLevel] = cache_get_field_content_int(0, "Level");
        P_Data[playerid][pKills] = cache_get_field_content_int(0, "Kills");
        P_Data[playerid][pDeaths] = cache_get_field_content_int(0, "Deaths");
        P_Data[playerid][pPremiumAcc] = cache_get_field_content_int(0, "PremiumAccount");
        P_Data[playerid][pMoney] = cache_get_field_content_int(0, "Money");
        P_Data[playerid][pConnectTime] = cache_get_field_content_float(0, "ConnectTime");
        SpawnPlayer(playerid);
        loadmoney(playerid);

        SendClientMessage(playerid, -1, "asd");

    }
    else return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FFFFFF}Login Step:", "{FFFFFF}This isn't your account password. Please retype your account password below:\n\n{FFFFFF}If you aren't remember your account password, you can recover it from out website.", "Login", "Exit");

    return 1;
}