#include "/include/HelperCommands.inc"
#include "/include/New.inc"
#include "/include/Enum.inc"
#include "/include/Define.inc"

enum furInfo
{
	fiID,
	fiModel,
	Float: fiX,
	Float: fiY,
	Float: fiZ,
	Float: fiRotX,
	Float: fiRotY,
	Float: fiRotZ,
	fiVirtual,
	fiHouse,
	fiObject
}
enum QuestE
{
	Float:Pozitie[3]
}
enum brazi
{
	Float:PozitieBrad[4]
}
enum mbinfo
{
        Float:XPOS,
        Float:YPOS,
        Float:ZPOS,
        PositionSac[33]
}
enum ArmeJos
{
	ArmID,
	Float:ArmPos[3],
	ArmData[2]
};
enum beforeSpectateInfo //iFordawin
{
 	Float: pOldPos[3],
 	pWorld,
 	pInt,
 	pState,
 	pInVehicle,
 	bool: pSpectating
};
enum spikeE
{
    sObjID,
	Float:sPos[4],
	sDeployer[MAX_PLAYER_NAME],
}
enum zInfo
{
    zID,
    zOwned,
    Float:zMinX,
    Float:zMinY,
    Float:zMaxX,
    Float:zMaxY
};
enum wInfo
{
    wFaction,
	wAttacker,
	wTime,
};
new WarInfo[sizeof(TurfInfo)][wInfo],
	WarScoreF[16][sizeof(TurfInfo)],
	ucideri[MAX_PLAYERS][sizeof(TurfInfo)],
	decese[MAX_PLAYERS][sizeof(TurfInfo)],
	worstscoreat[sizeof(TurfInfo)],
	worstmemberat[sizeof(TurfInfo)],
	worstscoredf[sizeof(TurfInfo)],
	worstmemberdf[sizeof(TurfInfo)],
	bestscoreat[sizeof(TurfInfo)],
	bestmemberat[sizeof(TurfInfo)],
	bestscoredf[sizeof(TurfInfo)],
	bestmemberdf[sizeof(TurfInfo)],
	DeelayWar[16],
	InWar[16];
enum pSpec
{
	Float:Coords[3],
	Float:sPx,
	Float:sPy,
	Float:sPz,
	sPint,
	sLocal,
	sCam,
};
enum rInfo
{
	rCreated,
    Float:rX,
    Float:rY,
    Float:rZ,
    rObject,
};
enum clanE
{
    cClanName[64],
	cClanMOTD[128],
	cClanRankName1[32],
	cClanRankName2[32],
	cClanRankName3[32],
	cClanRankName4[32],
	cClanRankName5[32],
	cClanRankName6[32],
	cClanRankName7[32],
	cClanTag[32],
	cClanTagType,
	cClanID,
	cClanExpire,
	cClanActive,
	cClanSlots,
	cClanColor[10],
};
enum pInfo
{
    pUsername[MAX_PLAYER_NAME],
	pKey[128],
	pNormalName[30],
	pLevel,
	pAWarn,
	pGPoints,
	pPhousekey,
	pExperience,
	pTotalExperience,
	pOnlineExperience,
	pReferral,
	pAdmin,
	pMining,
	pMineTime,
	pAdminPoints,
	pHelperPoints,
	pCases,
	pMineCount,
	pMinedRock,
	pReportMute,
	pColor,
	pBGDQuest[NRQUEST],
	pBGDNRQuest,
	pNeon,
	pDaillyQuests[9],
	pChar,
	pHelper,
	pVip,
	pYoutuber,
	pPremiumAccount,
	pPremiumPoints,
	pConnectTime,
	pReg,
	pSex,
	pAge,
	pOrigin,
	pMuted,
	pMuteTime,
	pGasCan,
	pExp,
	pPaydayuri,
	pCash,
	pAccount,
	pCrimes,
	pKills,
	pDeaths,
	pArrested,
	pWantedDeaths,
	pPhoneBook,
	pPhone,
 	pWantedLevel,
 	pSelected[MAX_PLAYER_NAME],
	pFishes,
	pJob,
	pPayCheck,
	pHeadValue,
	pJailed,
	pJailTime,
	pMats,
	pDrugs,
	pLeader,
	pMember,
	pRank,
	pGlasses,
	pHats,
	pFACWarns,
	pFpunish,
	pLawyer,
	pFishSkill,
	pFlyMode,
	pSpawnChange,
	pFishPrice,
	Float:pHealth,
	Float:pValoare,
	Float:pSHealth,
 	p1RaportR1,
 	p1RaportR2,
 	p1RaportR3,
 	p1RaportR4,
 	p1RaportR5,
 	p2RaportR1,
 	p2RaportR2,
 	p2RaportR3,
 	p2RaportR4,
 	p2RaportR5,
 	pBonus,
 	pSanta,
	pInt,
	pLocal,
	pTeam,
	pRequestingBackup,
	pModel,
	pPnumber,
	pPhouseKey,
	pPbiskey,
	Float:pPos_x,
	Float:pPos_y,
	Float:pPos_z,
	pCarLicSuspend,
	pGunLicSuspend,
	pCarLicT,
	pCarLic,
	pFlyLicT,
	pFlyLic,
	pBoatLicT,
	pBoatLic,
	pGunLicT,
	pGunLic,
	pPayDay,
 	pRobSkill,
 	pRobTimes,
 	pRobRem,
 	pTruckSkill,
 	pTruckTimes,
 	pTruckRem,
 	pFarmSkill,
 	pFarmTimes,
 	pFarmRem,
	pPizzaSkill,
	pPizzaTimes,
	pPizzaRem,
	pArmsSkill,
	pArmsTimes,
	pArmsRem,
	pBusSkill,
	pBusTimes,
	pBusRem,
 	pFishTimes,
 	pFishRem,
	pRob,
	pTut,
	pWarns,
	pLanguage,
	pFuel,
    pSleeping,
	pGarbageTime,
    pRented,
    pSpeaker,
    pWTalkie,
   	pEmail[200],
    pRegistredDate[200],
	pClanTag,
	pClan,
	pHitT,
 	pCRank,
	pCWarns,
	pSQLID,
	pPcarkey,
	pmotokey,
	pFirstPerson,
	phelikey,
	pprcarkey,
	pprcarkey2,
	pPPluscarkey,
	pPPluscarkey2,
	pPlusSlot1,
	pPlusSlot2,
    pVictim[64],
    pAccused[64],
	pCrime1[184],
	pCrime2[184],
	pCrime3[184],
	pNMessage[128],
	pNMessage2[128],
	pNewbieEnabled,
	pFirstAnswer,
	pNMuted,
	pNewbieTimeout,
	pHelpedPlayers,
	pNRE,
	pStatus,
	pALeader,
	pFWorks,
	pVirtualPD,
	pFactionTime,
	pCredits,
	pHost[25],
	pOneHost,
	pHiddenColor,
	pMP3,
	pFightStyle,
	pHUD1,
	pHUD2,
	pHUD3,
	pFPS,
	pLoialitate1,
    pLoialitate2,
    pLoialitate3,
    pLoialitate4,
    pLoialitate5,
    pLoialitate6,
    pLoialitate7,
    pLoialitate8,
    pLoialitate9,
    pLoialitate10,
    pLoialitate11,
    pLoialitate12,
    pSalarLuat,
    
    pLoialitate1Luat,
    pLoialitate2Luat,
    pLoialitate3Luat,
    pLoialitate4Luat,
    pLoialitate5Luat,
    pLoialitate6Luat,
    pLoialitate7Luat,
    pLoialitate8Luat,
    pLoialitate9Luat,
    pLoialitate10Luat,
    pLoialitate11Luat,
    pLoialitate12Luat,
    
	pDrunkLevelLast,
	pPaintBallG,
	pPaintBallKills,
	pPaintBallVoted,
	pPaintBallVoted2,
	pPhoneBlock,
	pNextNotification,
	pQuestMap,
	pLastLogin[75],
	pDConfiscate,  //test
	pLConfiscate, //test
	pContracts, //test
	pRunners, //test
	pArrestss, //test
	pTickets, //test
	pWDeaths, //test
	pWKills, //test
	pLGiven, //test
	pMoneyD, //test
	pMDeposit, //test
	pOrders, //test
	pDDeposit, //test
	pPHeals, //test
	pMUsed, //test
	pNews, //test
	pManagerDepartamente, //test
	pLives //test
};
enum bpInfo
{
	bpName[30],
	bpNumar1,
	bpNumar2,
	bpNumar3,
	bpNumar4,
	bpNumar5,
	bpNumar6,
	bpNumar7,
	bpNumar8,
	bpNumar9,
	bpNumar10,
	bpNume1[30],
	bpNume2[30],
	bpNume3[30],
	bpNume4[30],
	bpNume5[30],
	bpNume6[30],
	bpNume7[30],
	bpNume8[30],
	bpNume9[30],
	bpNume10[30]
}
enum hInfo
{
	hID,
	Float:hEntrancex,
	Float:hEntrancey,
	Float:hEntrancez,
	Float:hExitx,
	Float:hExity,
	Float:hExitz,
	hOwner[25],
	hDiscription[64],
	hValue,
	hHel,
	hArm,
	hInterior,
	hLock,
	hOwned,
	hRent,
	hRentabil,
	hTakings,
	hLevel,
	hVirtual,
	hFurniture
};
enum bInfo
{
	bID,
    bOwned,
	bOwner[25],
	bMessage[50],
	Float:bEntranceX,
	Float:bEntranceY,
	Float:bEntranceZ,
	Float:bExitX,
	Float:bExitY,
	Float:bExitZ,
	bLevelNeeded,
	bBuyPrice,
	bEntranceCost,
	bTill,
	bLocked,
	bInterior,
	bVirtual,
	bSbiz,
	bType
};
enum codInfo
{
	codID,
	codNumar
};
enum ConInf
{
	cID,
	cMesaj[256]
};
enum cInfo
{
	cID,
	cModel,
	Float:cLocationx,
	Float:cLocationy,
	Float:cLocationz,
	Float:cAngle,
	cColorOne,
	cColorTwo,
	cOwner[MAX_PLAYER_NAME],
	cDescription[128],
	cValue,
	cLicense[64],
	cOwned,
	cLock,
	cTimed,
	cInscarprice,
	cInsurancecar,
	Float:cKM,
	cSell,
	Float:cHP,
	cDamage1,
	cDamage2,
	cDamage3,
	cDamage4,
	cGas,
	mod1,
	mod2,
	mod3,
	mod4,
	mod5,
	mod6,
	mod7,
	mod8,
	mod9,
	mod10,
	mod11,
	mod12,
	mod13,
	mod14,
	mod15,
	mod16,
	mod17,
	cDays,
	cVIP,
	cVIPname,
	cPaintJ
};
enum vInfo
{
	vID,
	vStock,
	vPrice,
	vModel,
	vSpeed,
	vName[255],
	vType
};
enum Factions
{
	fID,
	fName[128],
	Float:fcX,
	Float:fcY,
	Float:fcZ,
	fMats,
	fDrugs,
	fBank,
	fPaydayMoney,
	fAnn[128],
	fWin,
	fLost,
	fMembers,
	fMaxMembers,
	fMinLevel,
	fApplication,
	fRankName1[64],
	fRankName2[64],
	fRankName3[64],
	fRankName4[64],
	fRankName5[64],
	fRankName6[64],
	fRankName7[64],
	fRRank1,
	fRRank2,
	fRRank3,
	fRRank4,
	fRRank5,
	fR2Rank1,
	fR2Rank2,
	fR2Rank3,
	fR2Rank4,
	fR2Rank5,
};
enum LIST_ANTIFLOOD
{
	lastCheck,
	floodRate
}