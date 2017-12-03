CMD:n(playerid, params[]) return cmd_newbie(playerid, params);
CMD:needhelp(playerid, params[]) return cmd_newbie(playerid, params);

CMD:newbie(playerid, params[])
{
	new help[164], counth = 0, nrehelpers = 0, dutyhelpers = 0, gString[164];
	if(PlayerInfo[playerid][pMuted] == 1) return SendClientMessage(playerid, COLOR_ERROR, "Momentan ai mute si nu poti sa folosesti aceasta comanda.");
	if(PlayerInfo[playerid][pAdmin] >= 1) return SendClientMessage(playerid, COLOR_ERROR, "Helperii si administratorii nu au acces la aceasta comanda.");
	if(PlayerInfo[playerid][pHelper] >= 1) return SendClientMessage(playerid, COLOR_ERROR, "Helperii si administratorii nu au acces la aceasta comanda, foloseste /nre <jucator> <raspuns>.");
	if(sscanf(params,"s[164]",help)) return SendClientMessage(playerid, COLOR_SYN, "Sintaxa:{FFFFFF} (/n)ewbie <intrebare>");

    if((gettime() - Needhelp_Timer[playerid]) < 120) return SendClientMessage(playerid, COLOR_GREY, "Poti sa folosesti /n odata la 2 minute!");
	format(gString, sizeof(gString), "(Question) %s - lvl %d: %s", GetName(playerid), PlayerInfo[playerid][pLevel], help);

	foreach(new i : Player)
	{
        if(PlayerInfo[i][pHelper] >= 1 && HelperDuty[i] == 1) dutyhelpers++;
		if(PlayerInfo[i][pHelper] >= 1 && HelperDuty[i] == 1 && Question[i] == 1) nrehelpers++;
		if(nrehelpers > 0 && nrehelpers == dutyhelpers) { Question[i] = 0; }

		if(PlayerInfo[i][pHelper] >= 1 && HelperDuty[i] == 1 && HelperAnswer[i] == -1 && Question[i] == 0)
		{
		    SendClientMessage(i, COLOR_NEWBIE, gString);
			HelperAnswer[playerid] = i;
			HelperAnswer[i] = playerid;
//			pNewbieEnabled[i] = 1;
			Question[i] = 1;
			counth++;
			break;
		}
	}
	if(counth == 0) return SendClientMessage(playerid, COLOR_SYN, "(!) {FFFFFF}Nu exista helperi disponibili, intrebarea ta a fost plasata pe lista de asteptare.");

	format(gString, sizeof(gString), "Intrebarea ta a fost atribuita helperului %s, te rugam sa astepti raspunsul acestuia.", GetName(HelperAnswer[playerid]));
    SendClientMessage(playerid,COLOR_NOB,gString);
	SendClientMessage(playerid,COLOR_NOB,"Chat-ul (/n)ewbie a fost activat automat. Dupa ce primesti un raspuns il poti dezactiva (/nonewbie)");
	format(PlayerInfo[playerid][pNewbie],164,help);
//	pNewbieEnabled[playerid] = 1;
	Needhelp_Timer[playerid] = gettime();
	Questions++;
//	UpdateStaffTextdraw();
	return 1;
}

CMD:nre(playerid, params[])
{
	new message[164], nstring[164], gString[164];
	if(PlayerInfo[playerid][pHelper] == 0) return SendClientMessage(playerid, COLOR_ERROR, "Nu ai acces la aceasta comanda!");
	if(HelperAnswer[playerid] == -1) return SendClientMessage(playerid, COLOR_ERROR, "Nu ai primit o intrebare.");
	if(sscanf(params,"s[164]", message)) return SendClientMessage(playerid, COLOR_SYN,"Sintaxa:{FFFFFF} /nre <raspuns>");
	{
        if(PlayerInfo[playerid][pHelper] >= 1)
        {
//		    PlayerInfo[playerid][pStaffPoints]++;
//			Update(playerid, pStaffPointsx);
			Questions--;
//			UpdateStaffTextdraw();

			format(gString, sizeof(gString), "(N) Helper %s: @%s, %s", GetName(playerid),GetName(HelperAnswer[playerid]), message);
			new string2[128];
			if(strlen(gString) > 120)
			{
				strmid(string2, gString, 110, 256);
				strdel(gString, 110, 256);

				format(gString,128,"%s ...",gString);
				format(string2,128,"... %s",string2);
			}

			foreach(new x : Player)
		    {
                    format(nstring, sizeof(nstring), "(N) Newbie %s: %s", GetName(HelperAnswer[playerid]),PlayerInfo[HelperAnswer[playerid]][pNewbie]);
					SendClientMessage(x,COLOR_NOB, nstring);

					if(strlen(gString) > 120)
					{
						SendClientMessage(x,COLOR_NOB, gString);
						SendClientMessage(x,COLOR_NOB, string2);
					}
					else
					{
						SendClientMessage(x,COLOR_NOB, gString);
					}
					
                if(HelperAnswer[x] == playerid)
				{
				    format(PlayerInfo[x][pNewbie],164," ");
				    HelperAnswer[x] = -1;
				    HelperAnswer[playerid] = -1;
				}

				if(strlen(PlayerInfo[x][pNewbie]) > 1 && HelperAnswer[x] == -1)
			    {
                    format(gString, sizeof(gString), "(Question) %s - lvl %d: %s", GetName(x), PlayerInfo[x][pLevel], PlayerInfo[x][pNewbie]);
					SendClientMessage(playerid, COLOR_NEWBIE, gString);
					HelperAnswer[x] = playerid;
					HelperAnswer[playerid] = x;
					format(gString, sizeof(gString), "Intrebarea ta a fost atribuita helperului %s, te rugam sa astepti raspunsul acestuia.", GetName(HelperAnswer[playerid]));
    				SendClientMessage(x,COLOR_NOB,gString);
					SendClientMessage(x,COLOR_NOB,"Chat-ul (/n)ewbie a fost activat automat. Dupa ce primesti un raspuns il poti dezactiva (/nonewbie)");
					break;
			    }
			}
	    }
	    else return SendClientMessage(playerid, COLOR_GREY, "Nu ai gradul necesar ca sa folosesti aceasta comanda!");
	}
	return 1;
}

CMD:mar(playerid, params[]) return cmd_markasreport(playerid, params);
CMD:markasreport(playerid, params[])
{
	if(PlayerInfo[playerid][pHelper] < 1) return SendClientMessage(playerid, COLOR_ERROR, "Nu ai gradul necesar ca sa folosesti aceasta comanda!");
	if(HelperAnswer[playerid] == -1) return SendClientMessage(playerid, COLOR_ERROR, "Nu ai primit o intrebare.");
	new gString[164];
	new reports=0;
    format(gString, sizeof(gString), "Ai marcat intrebarea jucatorului %s ca report, echipa administrativa va oferi un raspuns.", GetName(HelperAnswer[playerid]));
    SendClientMessage(playerid, COLOR_SYN, gString);
    format(gString, sizeof(gString), "Helperul %s ti-a marcat intrebarea ca report, echipa administrativa o sa iti ofere un raspuns curand.", GetName(playerid));
    SendClientMessage(HelperAnswer[playerid], COLOR_SYN, gString);

	format(PlayerInfo[HelperAnswer[playerid]][pReport],164, PlayerInfo[HelperAnswer[playerid]][pNewbie]);
	format(PlayerInfo[HelperAnswer[playerid]][pNewbie],164," ");

	format(gString, sizeof(gString), "%s a marcat intrebarea jucatorului %s ca report.", GetName(playerid), GetName(HelperAnswer[playerid]));
//    CMDRaport(gString,gString, 1, 1);
    HelperAnswer[HelperAnswer[playerid]] = -1;
	HelperAnswer[playerid] = -1;
	Questions--;
	reports++;
//	UpdateStaffTextdraw();
    return 1;
}

CMD:nskip(playerid, params[])
{
    if(PlayerInfo[playerid][pHelper] == 0) return SendClientMessage(playerid, COLOR_ERROR, "Nu ai gradul necesar ca sa folosesti aceasta comanda!");
    if(PlayerInfo[playerid][pAdmin] > 0) return SendClientMessage(playerid, COLOR_ERROR, "Administratorii nu au acces la aceasta comanda!");
	if(HelperAnswer[playerid] == -1) return SendClientMessage(playerid, COLOR_ERROR, "Nu ai primit o intrebare.");

	new gString[164];

	format(gString, sizeof(gString), "Helperul %s a decis sa plaseze intrebarea ta pe lista de asteptare.", GetName(playerid));
	SendClientMessage(HelperAnswer[playerid], COLOR_NEWBIE, gString);
	format(gString, sizeof(gString), "Ai decis sa plasezi intrebarea jucatorului %s pe lista de asteptare.", GetName(HelperAnswer[playerid]));
	SendClientMessage(playerid, COLOR_NEWBIE, gString);
	format(gString, sizeof(gString), "%s a plasat intrebarea jucatorului %s pe lista de asteptare.", GetName(playerid), GetName(HelperAnswer[playerid]));
//    CMDRaport(gString, 1, 1);

    HelperAnswer[HelperAnswer[playerid]] = -1;
    HelperAnswer[playerid] = -1;
	return 1;
}
