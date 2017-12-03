#include <a_samp>
#include <zcmd>
#include <foreach>

#include "../inc/all_includes.pwn"
#include "../inc/new.pwn"
#include "../inc/public.pwn"
#include "../inc/reglog.pwn"
#include "../inc/dialogs.pwn"
#include "../inc/stock.pwn"


CMD:selectgroup(playerid,params[]) {

	if(P_Data[playerid][pGroup] != 0) return SendClientMessage(playerid,-1,"You are already in a group");

	ShowPlayerDialog(playerid, DIALOG_SELECTGROUP, DIALOG_STYLE_LIST, "Choose Group", "Group 1\nGroup 2\nGroup 3", "Ok", "FFA");

	return 1;
}

CMD:leavegroup(playerid,params[]) {


	if(P_Data[playerid][pGroup] == 0) return SendClientMessage(playerid,-1,"You are not in a group");
	if(GetPlayerMoney(playerid) < 1000000) return SendClientMessage(playerid,-1,"You need 1,000,000$");

	LeaveGroup(playerid);

	return 1;
}

CMD:givemoney(playerid,params[]) {

	GivePlayerMoney(playerid, 1000000);

	P_Data[playerid][pMoney] = 1000000;

	return 1;
}

CMD:update(playerid,params[]) {
	Update();
	return 1;
}