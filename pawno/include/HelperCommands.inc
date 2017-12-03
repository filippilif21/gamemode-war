CMD:helperduty(playerid, params[])
{
	if(PlayerData[playerid][pHelper] < 1) return SCM(playerid, -1, "Nu ai gradul necesar de helper pentru a utiliza aceasta comanda.");
	new string[264];
	switch(HelperDuty[playerid])
	{
		case 0:
		{
			HelperDuty[playerid] = 1;
			format(string, sizeof(string), "{6aec80}Helper %s este acum Duty.Puteti pune intrebati folosind /n.", GetName(playerid));
			SCMTA(-1, string);
		}
		case 1:
		{
			HelperDuty[playerid] = 0;
			format(string, sizeof(string), "{6aec80}Helper %s este acum Duty Off.", GetName(playerid));
			SCMTA(-1, string);
		}
	}
	return 1;
}
CMD:n(playerid, params[])
{
	if(PlayerQuestioned[playerid] > 0) return SCM(playerid, -1, "Trebuie sa astepti 15 secunde pentru a utiliza comanda din nou.");
	SetTimerEx("QuestionRemove", 15000, 0, "d", playerid);
	new text[512], string[512];
	if(sscanf(params, "s[512]", text)) return SCM(playerid, -1, "Use:/n <text>");
	if(strlen(text) > 500) SCM(playerid, -1, "Intrebarea ta este mai mare de 500 de caractere.");
	format(newbiequestion[playerid], 512, "%s", text);
	format(string, sizeof(string), "{26a13b}Question from %s[ID:%d]. | %s", GetName(playerid), playerid, newbiequestion[playerid]);
	new count = 0;
	new helpers = 0;
	foreach(new i : Player)
	{
		if(PlayerData[i][pHelper] > 0)
		{
			helpers++;
		}
	}
	if(helpers >= 1)
	{
		new playerr = random(helpers) + 1;
		PlayerQuestioned[playerid] = 15;
		foreach(new i : Player)
		{
			if(PlayerData[i][pHelper] > 0 && QuestionHelper[i] == 0 )
			{
				if(++count == playerr)
				{
					SCM(i, -1, string);
					NewbieID[playerid] = i;
					format(string, sizeof(string), "{f6c058}Solicitarea ta a fost preluata de Helperul %s, astepata raspunsul.", GetName(i));
				}
			}
		}
	}
	else{SCM(playerid, -1, "Nu este niciun Helper Online.");}
	
	return 1;
}
forward QuestionRemove(playerid);
public QuestionRemove(playerid)
{
	PlayerQuestioned[playerid] = 0;
	SCM(playerid, -1, "{6aec80}Acum, poti pune o alta intrebare pe /n.");
	return 1;
}
CMD:nskip(playerid, params[])
{
	if(PlayerData[playerid][pHelper] < 1) return SCM(playerid, -1, "Nu ai gradul necesar de helper pentru a utiliza aceasta comanda.");
	new count = 0, string[256];
	new playerr = Iter_Random(Player);
	foreach(new i : Player)
	{
		if(NewbieID[i] == playerid)
		{
			format(string, sizeof(string), "{dfce2d}Helperul %s a sarit peste solicitarea ta.", GetName(NewbieID[i]));
			SCM(NewbieID[i], -1, string);
		}
		if(PlayerQuestioned[i] == 1 && strlen(newbiequestion[i]) > 0 && NextQuestion[playerid] != i)
		{
			if(++count == playerr)
			{
				SCM(playerid, -1, newbiequestion[i]);
				NextQuestion[playerid] = i;
			}
		}
	}
	return 1;
}
CMD:nre(playerid, params[])
{
	if(PlayerData[playerid][pHelper] < 1 || PlayerData[playerid][pAdmin] < 1) return SCM(playerid, -1, "Nu ai gradul necesar de helper sau de admin pentru a utiliza aceasta comanda.");
	new id, raspuns[512], string[1024];
	if(sscanf(params, "us[512]", id, raspuns)) return SCM(playerid, -1, "/nre <id> <raspuns>");
	if(strlen(newbiequestion[id]) < 1) return SCM(playerid, -1, "Acel player nu a pus o intrebare!");
	format(string, sizeof(string), "{6aec80}Intrebarea lui %s este: %s", GetName(id), newbiequestion[id]);
	SCMTA(-1, string);
	format(string, sizeof(string), "{6aec80}Raspunsul lui %s este: @%s, %s", GetName(playerid), GetName(id), raspuns);
	SCMTA(-1, string);
	NextQuestion[playerid] = -1;
	PlayerQuestioned[id] = 0;
	format(newbiequestion[id], 512, "");
	return 1;
}