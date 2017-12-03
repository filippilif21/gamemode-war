#include "/include/HelperCommands.inc"
#include "/include/New.inc"
#include "/include/Enum.inc"
#include "/include/Define.inc"

#if !defined isnull
    #define isnull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

#if !defined gpci
    native gpci(playerid, serial[], len);
#endif


new newbiequestion[MAX_PLAYERS][512];
new QuestionHelper[MAX_PLAYERS];
new NextQuestion[MAX_PLAYERS];
new PlayerQuestioned[MAX_PLAYERS];
new NewbieID[MAX_PLAYERS];


new FurnitureInfo[MAX_FURNITURE][furInfo];
new furnitures = mS_INVALID_LISTID;
new EditHouse[MAX_PLAYERS];
new SlotSel[MAX_PLAYERS];
new EditModel[MAX_PLAYERS];
new EditedObjectID[MAX_PLAYERS];
new SelMobila[MAX_PLAYERS][50];
new ObjectEdited[MAX_PLAYERS];
new EsteInPB[MAX_PLAYERS];
new InfoZone[1];
new PlayerText:Textdraw0[MAX_PLAYERS];
new PlayerText:Textdraw1[MAX_PLAYERS];
new PlayerText:Textdraw2[MAX_PLAYERS];
new PlayerText:Textdraw3[MAX_PLAYERS];
new PlayerText:Textdraw4[MAX_PLAYERS];
new PlayerText:Textdraw5[MAX_PLAYERS];
new PlayerText:Textdraw6[MAX_PLAYERS];
new PlayerText:Textdraw7[MAX_PLAYERS];
new bonus5ore[MAX_PLAYERS];
new TPOS[MAX_PLAYERS];
new NoReloading[MAX_PLAYERS];
new CurrentWeapon[MAX_PLAYERS];
new CurrentAmmo[MAX_PLAYERS];
new HaveCheats[MAX_PLAYERS];
new CheatsReason[MAX_PLAYERS][128];
new ObiectMasina[MAX_PLAYERS];
new vtextt[MAX_PLAYERS];
new PlayerText:StaffInfo[MAX_PLAYERS];
new hsend[MAX_PLAYERS];
new Reports = 0;
new updateversiune[100][128];
new updatedata[100][128];
new updatetext[40][100][1000];

new idupdate[MAX_PLAYERS];
new
	OXEVENT = 0,
	OXINPARTICIPARE[MAX_PLAYERS],
	OxBani = 0,
	OxPP = 0,
	OxRP = 0,
	OXPREMIUSETAT = 0;


new GunGame = 0;
new Echipa1;
new Echipa2;


new giftfolosit = 0;
new giftrp = 0;
new giftbani = 0;
new giftpp = 0;
new Text3D:giftlabel;

new AreCits[MAX_PLAYERS];
new PlayerText:ArmeSpec12[MAX_PLAYERS];
new JoinedGunGame[MAX_PLAYERS];
new woodt[MAX_PLAYERS];
new woodman[MAX_PLAYERS];
new woodl[MAX_PLAYERS];
new woodtaie[MAX_PLAYERS];
new GotoDisabled[MAX_PLAYERS];
new SpecMePRO[MAX_PLAYERS];
new vText;
new IncarcaQuestT = -1;
new questuri_incarcate = 0;
new PickupQuest[NRQUEST+1];
new QExistent[NRQUEST+1];
new pObj[MAX_PLAYERS];
new SpecFactiune[MAX_PLAYERS];
new prodck[MAX_PLAYERS];
new QuesT[NRQUEST+1][QuestE];
new PlayerText:QuestBGD[MAX_PLAYERS];
new ultimulbrad = 0;
new ObjectBrad[NR_BRAZI];
new Brad[NR_BRAZI][brazi];
new
	RestartTime,
	RestartReason[256],
	Timer,
	Text: RestartTD;
new Speeder[MAX_PLAYERS];
new afuratdeja[MAX_PLAYERS];
new Joacabarbut[MAX_PLAYERS],
	PlayerText:BarbutTD[17],
	pregatit[MAX_PLAYERS],
	aacceptatdice[MAX_PLAYERS],
	sumabarbut[MAX_PLAYERS],
	secundebarbut[MAX_PLAYERS];
new PlayerText:OCASES[6];
new gatehqa;

new IsBot[MAX_PLAYERS];

new PlayerText:LoadingBox[MAX_PLAYERS][5];
new NumarSelectat[MAX_PLAYERS];
new ArmaPreview[MAX_PLAYERS];
new Text:textile;
new Text:Testare;
new Text:SpecArme1;
new InPaint[MAX_PLAYERS];
new InputPass[MAX_PLAYERS][31];
new LoginRegister[MAX_PLAYERS];
new housestring[200][256];
new sarmale[MAX_PLAYERS];
new esteanunt = 0;
new Text:AnuntServer[1];
new barstring[100][256];
new Logare[MAX_PLAYERS];
new Float:spx, Float:spy, Float:spz;
new randombanimaxim[MAX_PLAYERS];
new Radarlimit[MAX_PLAYERS];
new Radaron[MAX_PLAYERS];
new LictatieActiva = 0;
new TogBidOn[MAX_PLAYERS];
new ParticipBid[MAX_PLAYERS];
new SumaLicitata[MAX_PLAYERS];
new SumaMare = 0;
new LiciteziPentru = 0; // 1 pentru casa si 2 pentru biz
new IDLicitatie = 0;// ID-ul casei sau bizz-ului
new TimerLicitatie;
new TimerLictiatii;

new ShowHelperChat[MAX_PLAYERS];
new SQL = -1;
new PlayerText:RegisterBonus[MAX_PLAYERS][16];
new PlayerText:TDWar[8];
new PlayerText:ArmTextdraw[MAX_PLAYERS][1];
new 
	PusiTombola[MAX_PLAYERS],
	pidi[MAX_PLAYERS],
	painttime=0,
	randgarba[MAX_PLAYERS],
	DeathP[MAX_PLAYERS],
	LastText[MAX_PLAYERS][128],
	LastTextTime[MAX_PLAYERS],
	examcar[MAX_PLAYERS],
	LastBiz[MAX_PLAYERS],
	countdown,
	Tigaanel[MAX_PLAYERS],
	LastPlayer[MAX_PLAYERS],
	Selectat[1000][MAX_PLAYERS],
	XCheckpoints[MAX_PLAYERS],
	LastCheckpoint[MAX_PLAYERS],
	Selected[MAX_PLAYERS][101],
	Selected2[MAX_PLAYERS],
	FastString[128],
	AdvMSG[MAX_PLAYERS][256],
	AdvPlayer[MAX_PLAYERS],
	AdvTimer[MAX_PLAYERS],
	Answered = 1,
	Casca[MAX_PLAYERS],
	viddd[MAX_PLAYERS],
	Trucker[MAX_PLAYERS],
	Trucker2[MAX_PLAYERS],
	Trucker3[MAX_PLAYERS],
	Trucker4[MAX_PLAYERS],
	TruckID[MAX_PLAYERS],
	OnDutymedic[MAX_PLAYERS],
	RepairTime[MAX_PLAYERS],
	pnsmoney[MAX_PLAYERS],
	AreFaina[MAX_PLAYERS],
	CarJacker[MAX_PLAYERS],
	OnlineExperience[MAX_PLAYERS],
	PlayerText:XPRemain,
	PlayerText:XPTLeft,
	PlayerText:XPTotal,
	PlayerBar:ExperienceBar,
	SleepXP[MAX_PLAYERS],
	Allowed[MAX_PLAYERS],
	BuyCar[MAX_PLAYERS],
	IsPlayerAFK[MAX_PLAYERS],
	QEvent[MAX_PLAYERS][50],
	object,
	object2,
	object3,
	object4,
	object5,
	iGMXTick,
	iGMXTimer,
	VehicleRent[MAX_VEHICLES],
	RentTime[MAX_PLAYERS],
	TotalTimeRent[MAX_PLAYERS],
	RentVeh[MAX_PLAYERS],
	RentTimerr[MAX_PLAYERS],
	waitwar[15],
	SelFac[MAX_PLAYERS],
	EnterInModShop[MAX_PLAYERS],
	PlayerEnterTime[MAX_PLAYERS],
	Undercover[MAX_PLAYERS],
	shotTime[MAX_PLAYERS],
	shot[MAX_PLAYERS],
	Float:xhq[15],
	Float:yhq[15],
	Float:zhq[15],
	WantedName[MAX_PLAYERS][256],
	WantedReason[MAX_PLAYERS],
	WantedTimer[MAX_PLAYERS],
    skinlist = mS_INVALID_LISTID,
	skinlist1 = mS_INVALID_LISTID,
	skinlist2 = mS_INVALID_LISTID,
	skinlist3 = mS_INVALID_LISTID,
	skinlist4 = mS_INVALID_LISTID,
	skinlist5 = mS_INVALID_LISTID,
	skinlist6 = mS_INVALID_LISTID,
	skinlist8 = mS_INVALID_LISTID,
	skinlist9 = mS_INVALID_LISTID,
	skinlist10 = mS_INVALID_LISTID,
	skinlist11 = mS_INVALID_LISTID,
	skinlist12 = mS_INVALID_LISTID,
	skinlist13 = mS_INVALID_LISTID,
	skinlist14 = mS_INVALID_LISTID,
	skinlist15 = mS_INVALID_LISTID,
	skinlist16 = mS_INVALID_LISTID,
	skinlist17 = mS_INVALID_LISTID,
	skinlist18 = mS_INVALID_LISTID,
	EmailId[MAX_PLAYERS][11],
	taxim[MAX_PLAYERS],
	Float:evex,
	Float:evey,
	Float:evez,
	eventenabled,
	pickup_event,
	virtuallevent,
	interiorevent,
	towo1,
	towo2,
	towo1b,
	towo2b,
	towo1c,
	towo2c,
	towo1d,
	towo2d,
	towo1e,
	towo2e,
	fight2[MAX_PLAYERS],
	reporttext[MAX_PLAYERS][128],
	reportcheater[MAX_PLAYERS] = -1,
	reportreason[MAX_PLAYERS] = 0,
	playerreported[MAX_PLAYERS] = -1,
	QuestP[50],
	pickuph,
	hitmanep,
	rusp,
	Float:Dst1[MAX_PLAYERS],
	Float:Dst2[MAX_PLAYERS],
	Float:Dst3[MAX_PLAYERS],
	sicp,
	porp,
	trdp,
	taxip,
	gslsenter1,
	gslsenter2,
	gslsenter3,
	gslsenter4,
	eventobjects=0,
	objectevent[11],
	eventprizeobj[11],
	toglc[MAX_PLAYERS],
	togvc[MAX_PLAYERS],
	raceoff[MAX_PLAYERS],
	Carspawn[MAX_VEHICLES],
	Destroycar = 0,
	masini = 0,
	stockss = 0,
	clanss = 0,
	factionss = 0,
	personalcar[MAX_PVEHS][MAX_PLAYERS],
	Diceid[MAX_PLAYERS],
	Dicem[MAX_PLAYERS],
	wantedlost[MAX_PLAYERS],
	CheckBus[MAX_PLAYERS],
	BusCheckk[MAX_PLAYERS],
	JobStep[MAX_PLAYERS],
	timerbus[MAX_PLAYERS],
	busc[MAX_PLAYERS],
	Float:Health[MAX_PLAYERS],
	Float:Armour[MAX_PLAYERS],
	SpamCheck[MAX_PLAYERS],
	antirem[MAX_PLAYERS],
	login[MAX_PLAYERS],
	Clanidoff[MAX_PLAYERS],
	Float: Aimx[MAX_PLAYERS],
	Float: Aimy[MAX_PLAYERS],
	Float: Aimz[MAX_PLAYERS],
	kickafk = 1,
	Speedlimit[MAX_PLAYERS],
	togip[MAX_PLAYERS],
	tazer[MAX_PLAYERS],
	PlayerHandsup[MAX_PLAYERS],
	curatj[MAX_PLAYERS],
	XDeaths[MAX_PLAYERS],
	LastDeath[MAX_PLAYERS],
	playerdeath[MAX_PLAYERS],
	drug[MAX_PLAYERS],
	bizid[MAX_PLAYERS],
	bizprice[MAX_PLAYERS],
	bizoffer[MAX_PLAYERS],
	bool:WeaponData[MAX_PLAYERS][13],
	TimerAtuPlayer[MAX_PLAYERS],
	Cash[MAX_PLAYERS],
	SwitchKey[MAX_PLAYERS],
	bussines = 0,
	coduri = 0,
	Msg = 0,
	housess = 0,
	turfsss = 0,
	togfind[MAX_PLAYERS],
	farmermoney[MAX_PLAYERS],
	Float:FRX[MAX_PLAYERS],
	Float:FRY[MAX_PLAYERS],
	Float:FRZ[MAX_PLAYERS],
	firerockettime[MAX_PLAYERS],
	Firerocket[MAX_PLAYERS],
	explosionrocket[MAX_PLAYERS],
	rocketsmoke[MAX_PLAYERS],
	Light[MAX_LIGHTS][MAX_PLAYERS],
	Float:RBX[MAX_PLAYERS],
	Float:RBY[MAX_PLAYERS],
	Float:RBZ[MAX_PLAYERS],
	RocketBoxTime[MAX_PLAYERS],
	RocketBox[MAX_PLAYERS],
	RocketBoxSmoke[MAX_PLAYERS],
	RocketBoxSprinkle[RBSprinkleid][MAX_PLAYERS],
	RBLight[MAX_LIGHTS][MAX_PLAYERS],
	TowAcc[MAX_PLAYERS],
	JackAcc[MAX_PLAYERS],
	Sunglasses[MAX_PLAYERS],
	Hatss[MAX_PLAYERS],
	vendi[MAX_PLAYERS],
	vendi2[MAX_PLAYERS],
	Vending[MAX_PLAYERS],
	FactionOffer[MAX_PLAYERS],
	hudactivated[MAX_PLAYERS],
	ReportTime[MAX_PLAYERS],
	timerreport[MAX_PLAYERS],
	Fishing[MAX_PLAYERS],
	FishTimer[MAX_PLAYERS],
	FishTimerr[MAX_PLAYERS],
	TipPeste[MAX_PLAYERS],
	farmerc[MAX_PLAYERS],
	farmercar[MAX_PLAYERS],
	farmertime[MAX_PLAYERS],
	timerfarmm[MAX_PLAYERS],
	timersoo[MAX_PLAYERS],
	soexpire[MAX_PLAYERS],
	BusinessRob[MAX_PLAYERS],
	RobOn,
	InRob[MAX_PLAYERS],
	RobObjects[MAX_PLAYERS],
	robobject[2],
	RobTime[MAX_PLAYERS],
	QuestWait[MAX_PLAYERS],
	RobTimer[MAX_PLAYERS],
	//timerfree1[MAX_PLAYERS],
	somatee[MAX_PLAYERS],
	SomatePermission[MAX_PLAYERS],
	somated[MAX_PLAYERS],
	somatename[MAX_PLAYERS][30],
	TimerFree[MAX_PLAYERS],
	pizzaj[MAX_PLAYERS],
	pizzatime[MAX_PLAYERS],
	pizzaprize[MAX_PLAYERS],
	failpizza[MAX_PLAYERS],
	PizzaCP[MAX_PLAYERS],
	timerrent[MAX_PLAYERS],
	walktime[MAX_PLAYERS],
	deathdeletetime[MAX_PLAYERS],
	WalkStyle[MAX_PLAYERS],
	targetfind[MAX_PLAYERS],
	InHouse[MAX_PLAYERS],
	InBussines[MAX_PLAYERS],
	InHQ[MAX_PLAYERS],
	cased[MAX_PLAYERS],
	caser[MAX_PLAYERS],
	adminacceptedhelp[MAX_PLAYERS] = -1,
	licenseaccepted[MAX_PLAYERS] = -1,
	licensesend[MAX_PLAYERS] = -1,
	bool: WTToggle[MAX_PLAYERS] = false,
	bool: CTOG[MAX_PLAYERS] = false,
	Float:WTChannel[MAX_PLAYERS] = 0.0,
	arrestcop[MAX_PLAYERS] = -1,
	eventorganizer[MAX_PLAYERS],
	requestingevent[MAX_PLAYERS],
	requestingtitle[MAX_PLAYERS][50],
	requestinglocation[MAX_PLAYERS][50],
	requestingdescription[MAX_PLAYERS][100],
	requestingprize[MAX_PLAYERS],
	requestingtime[MAX_PLAYERS][50],
	payala[MAX_PLAYERS],
	activeevent,
	eventtitle[50],
	eventlocation[50],
	eventdescription[100],
	eventprize,
	eventtime[50],
	gatelspd,
	gatelvpd,
	gatelvpd2,
	gateng,
	lspdbar,
	lvpdbar,
	taxibar,
	UsingDrugs[MAX_PLAYERS],
	Float:PlayerPos[MAX_PLAYERS][6],
	Float:PlayerPosii[MAX_PLAYERS][6],
	idletime = 3000000,
	idletimer,
	pickuptimer,
	vehEngine[MAX_VEHICLES],
	HelperDuty[MAX_PLAYERS],
	AdminDuty[MAX_PLAYERS],
	vehRadio[MAX_VEHICLES],
	IsCollectingRubbish[MAX_PLAYERS],
	GarbageEndTime[MAX_PLAYERS],
	GarbageTime[MAX_PLAYERS],
	BinTime[MAX_PLAYERS],
	gPlayerUsingLoopingAnim[MAX_PLAYERS],
	gPlayerAnimLibsPreloaded[MAX_PLAYERS],
	AcceptOffer[MAX_PLAYERS],
	AcceptPrice[MAX_PLAYERS],
	FreeOffer[MAX_PLAYERS],
	FreePlayer[MAX_PLAYERS],
	FreePrice[MAX_PLAYERS],
	MatsOffer[MAX_PLAYERS],
	MatsPrice[MAX_PLAYERS],
	MatsAmmo[MAX_PLAYERS],
	SellgunOffer[MAX_PLAYERS],
	SellgunPrice[MAX_PLAYERS],
	SellgunMats[MAX_PLAYERS],
	SellgunAmmo[MAX_PLAYERS],
	SellgunID[MAX_PLAYERS],
	HouseID[MAX_PLAYERS],
	HouseOffer[MAX_PLAYERS],
	HousePrice[MAX_PLAYERS],
	ofercar[MAX_PLAYERS],
	PlayerText:TruckInfo[MAX_PLAYERS],
	PlayerText:TruckDestinatie[MAX_PLAYERS],
	PlayerText:TruckDistanta[MAX_PLAYERS],
	PlayerText:TruckSalariul[MAX_PLAYERS],
	PlayerText:Reportss[MAX_PLAYERS],
	hiddenoffer[MAX_PLAYERS],
	hiddenprice[MAX_PLAYERS],
	carprice[MAX_PLAYERS],
	primesccar[MAX_PLAYERS],
	cartype[MAX_PLAYERS],
	CarID[MAX_PLAYERS],
	tradeofferer[MAX_PLAYERS],
	tradediff[MAX_PLAYERS],
	tradecars[MAX_PLAYERS],
	tradecars2[MAX_PLAYERS],
	tradetype[MAX_PLAYERS],
	tradetype2[MAX_PLAYERS],
	flymode[MAX_PLAYERS],
	Text3D:areap,
	areape = 0,
	Text3D:WantedScris[MAX_PLAYERS],
	Text3D:DeadScris[MAX_PLAYERS],
	Text3D:dynamicevent3DText,
	Float:posxxx[MAX_PLAYERS],
	Float:posyyy[MAX_PLAYERS],
	Float:poszzz[MAX_PLAYERS],
	PlayerName[MAX_PLAYER_NAME],
	AfterTutorial[MAX_PLAYERS],
	RegistrationStep[MAX_PLAYERS],
	TakingLesson[MAX_PLAYERS],
	UsedFind[MAX_PLAYERS],
	NoFuel[MAX_PLAYERS],
	MatsHolding[MAX_PLAYERS],
	GotoMats[MAX_PLAYERS],
	PlayerStoned[MAX_PLAYERS],
	ConsumingMoney[MAX_PLAYERS],
	TutTime[MAX_PLAYERS],
	PlayerDrunk[MAX_PLAYERS],
	PlayerDrunkTime[MAX_PLAYERS],
	LiveOffer[MAX_PLAYERS],
	TalkingLive[MAX_PLAYERS],
	PlacedNews[MAX_PLAYERS],
	SelectChar[MAX_PLAYERS],
	SelectCharID[MAX_PLAYERS],
	SelectCharPlace[MAX_PLAYERS],
	ChosenSkin[MAX_PLAYERS],
	CurrentMoney[MAX_PLAYERS],
	CP[MAX_PLAYERS],
	MoneyMessage[MAX_PLAYERS],
	giveexp = 50, // SET EVENT
	recivedexp = 3,
	recivedmoney = 30000,
	eventon = 0,
	Tax, // TAX
	TaxValue,
	PaintBallWinnerKills[5],
	PaintWinner[5],
	Medics = 0, // MEDIC - MECANIC - TAXI ( JOB DUTY )
	MedicCall[MAX_PLAYERS],
	MedicCallTime[MAX_PLAYERS],
	Mechanics = 0,
	MechanicCall[MAX_PLAYERS],
	MechanicCallTime[MAX_PLAYERS],
	TaxiDrivers = 0,
	TaxiCall[MAX_PLAYERS],
	TaxiCallTime[MAX_PLAYERS],
	TaxiAccepted[MAX_PLAYERS],
	TransportDuty[MAX_PLAYERS],
	TransportValue[MAX_PLAYERS],
	TransportMoney[MAX_PLAYERS],
	TransportTime[MAX_PLAYERS],
	TransportCost[MAX_PLAYERS],
	TransportDriver[MAX_PLAYERS],
	JobDuty[MAX_PLAYERS],
	MedicTime[MAX_PLAYERS],
	NeedMedicTime[MAX_PLAYERS],
	TicketOffer[MAX_PLAYERS], // TICKET
	TicketMoney[MAX_PLAYERS],
	GotHit[MAX_PLAYERS], // HITMAN
	GoChase[MAX_PLAYERS],
	GetChased[MAX_PLAYERS],
	OrderReady[MAX_PLAYERS],
	PlayerTied[MAX_PLAYERS], // CUFF - TIE - TAZER
	PlayerCuffed[MAX_PLAYERS],
	PlayerCuffed2[MAX_PLAYERS],
	PlayerCuffedTime[MAX_PLAYERS],
	PlayerTazeTime[MAX_PLAYERS],
	RepairOffer[MAX_PLAYERS], // REPAIR
	RepairPrice[MAX_PLAYERS],
	RefillOffer[MAX_PLAYERS],
	RefillPrice[MAX_PLAYERS],
	RepairCar[MAX_PLAYERS],
	TransferOffer[MAX_PLAYERS], // TRANSFER MONEY
	TransferMoney[MAX_PLAYERS],
	DrugOffer[MAX_PLAYERS], // DRUGS
	DrugPrice[MAX_PLAYERS],
	DrugGram[MAX_PLAYERS],
	JailPrice[MAX_PLAYERS], // BAIL PRICE
	WantedPoints[MAX_PLAYERS], // COPS
	OnDuty[MAX_PLAYERS],
	gPlayerCheckpointStatus[MAX_PLAYERS], //
	gPlayerLogged[MAX_PLAYERS],
	gPlayerLogTries[MAX_PLAYERS],
	gPlayerSpawned[MAX_PLAYERS],
	gLastCar[600],
	gOoc[MAX_PLAYERS],
 	gNews[MAX_PLAYERS],
	gFam[MAX_PLAYERS],
	BigEar[MAX_PLAYERS],
	Spectate[MAX_PLAYERS],
	SpectateState[MAX_PLAYERS],
	CellTime[MAX_PLAYERS],
	HireCar[MAX_PLAYERS],
	WarnCBUG[MAX_PLAYERS],
	SafeTime[MAX_PLAYERS],
	HidePM[MAX_PLAYERS],
	PhoneOnline[MAX_PLAYERS],
	PhoneOnlineCalls[MAX_PLAYERS],
	TurfsDisp[MAX_PLAYERS],
	FirstSpawn[MAX_PLAYERS],
	BanAdminAll[MAX_PLAYERS],
	BanAdminAllTentativa[MAX_PLAYERS],
	Mobile[MAX_PLAYERS],
	CallCost[MAX_PLAYERS],
	gPlayerAccount[MAX_PLAYERS],
	gLastDriver[600],
	paintp[5], //Players  --- Paintball
	paintm[5], //Map
	paintg[3], //Arma
	paintt[5], //Timp ramas
	paintrs[5], //Timp restart
	paintvoteg[3][3],//Vote gun
	paintvotem[5][5], //Vote map
	mapvoted[5], //Map voted or not
	gunvoted[3], //GUN voted or not
	gCarLock[600];


new serverrestart2 = -1;
//-------------------------------------------------------------------------TEXT:
new PlayerText:Logo[MAX_PLAYERS],
	PlayerText:PaintBallText[MAX_PLAYERS],
	Text:Time,
	Text:Date,
	PlayerText:LoginShow[MAX_PLAYERS][17],
	PlayerText:Coli[MAX_PLAYERS],
	PlayerText:Coli1[MAX_PLAYERS],
	PlayerText:Bus1[MAX_PLAYERS],
	PlayerText:Bus2[MAX_PLAYERS],
	PlayerText:TextDrawSpec[MAX_PLAYERS][6],
	PlayerText:Fuell[MAX_PLAYERS],
	PlayerText:Speedd[MAX_PLAYERS],
	PlayerText:consum[MAX_PLAYERS],
	PlayerText:Odom[MAX_PLAYERS],
	PlayerText:carlocked[MAX_PLAYERS],
	PlayerText:farmbox[MAX_PLAYERS],
	PlayerText:farmspeed[MAX_PLAYERS],
	PlayerText:farmwanted[MAX_PLAYERS],
	PlayerText:farmtime[MAX_PLAYERS],
	PlayerText:Jailtime[MAX_PLAYERS],
	PlayerText:Tutorial[MAX_PLAYERS],
	PlayerText:Step[MAX_PLAYERS][9],
	PlayerText:BusJob[MAX_PLAYERS],
	PlayerText:BusCheck[MAX_PLAYERS],
	PlayerText:DMVcheck[MAX_PLAYERS],
	PlayerText:DMVstats[MAX_PLAYERS],
	PlayerText:DMVinfo[MAX_PLAYERS],
	PlayerText:DMVinfo1[MAX_PLAYERS],
	PlayerText:WantedText[MAX_PLAYERS],
	PlayerText:UndercoverText[MAX_PLAYERS],
	PlayerText:HUD[4][MAX_PLAYERS],
	PlayerText:JobFind[2][MAX_PLAYERS],
	PlayerText:JobGarbage[2][MAX_PLAYERS],
	PlayerText:pizzadistanta[MAX_PLAYERS],
	PlayerText:pizzaplata[MAX_PLAYERS],
	PlayerText:RentCar[MAX_PLAYERS],
	PlayerText:DSBox1[MAX_PLAYERS],
	PlayerText:DSBox2[MAX_PLAYERS],
	PlayerText:DSBox3[MAX_PLAYERS],
	PlayerText:DSBox4[MAX_PLAYERS],
	PlayerText:DSPrev[MAX_PLAYERS],
	PlayerText:DSModel[MAX_PLAYERS],
	PlayerText:DSStock[MAX_PLAYERS],
	PlayerText:DSPrice[MAX_PLAYERS],
	PlayerText:DSSpeed[MAX_PLAYERS],
	PlayerText:DSBuy[MAX_PLAYERS],
	PlayerText:DSCancel[MAX_PLAYERS],
	PlayerText:LoginBox0[MAX_PLAYERS],
	PlayerText:LoginBox1[MAX_PLAYERS],
	PlayerText:LoginBox2[MAX_PLAYERS],
	PlayerText:LoginBox3[MAX_PLAYERS],
	PlayerText:LoginBox4[MAX_PLAYERS],
	PlayerText:LoginBox5[MAX_PLAYERS],
	PlayerText:LoginBox6[MAX_PLAYERS],
	PlayerText:LoginEnter[MAX_PLAYERS],
	PlayerText:LoginClick[MAX_PLAYERS],
	PlayerText:LoginMessage[MAX_PLAYERS],
	PlayerText:LoginName[MAX_PLAYERS],
	PlayerText:MP3Box0[MAX_PLAYERS],
	PlayerText:MP3Box1[MAX_PLAYERS],
	PlayerText:MP3Box2[MAX_PLAYERS],
	PlayerText:MP3Box3[MAX_PLAYERS],
	PlayerText:MP3Stop[MAX_PLAYERS],
	PlayerText:MP3Melodie[MAX_PLAYERS],
	PlayerText:MP3Back[MAX_PLAYERS],
	PlayerText:MP3Next[MAX_PLAYERS];
	new	EsteListat[MAX_PLAYERS];

new BonusLuat[MAX_PLAYERS];
new SantaLuat[MAX_PLAYERS];

new Copcar[33],
	Fbicar[17],
	LVpdcar[41],
	Ngcar[12],
	Vagosc[12],
	NFSC[7],
	Ballasc[15],
	Grovec[13],
	Aztecasc[15],
	taxic[12],
	news[18],
	towcar[6],
	ambcars[11],
	garbage[11],
	bus[17],
	pizza[15],
	rentls[10],
	rentlv[20],
	masinils[110],
	masinilv[40],
	thea[17],
	helpercars[6],
	admincars[6];

// VARIABILE GLOBALE
new Float:rx,
	Float:ry,
	Float:rz,
	//Timer[2],
	objstore[128],
	cbjstore[128],
	ghour = 0,
	gminute = 0,
	gsecond = 0,
	dollah = 100000,
	realtime = 1,
	wotime = 15,
	levelcost = 28000,
	realchat = 1,
	timeshift = -1,
	shifthour,
	othtimer,
	checkafktimer,
	synctimer,
	unjailtimer,
	preparepaint1,
	preparepaint2,
	preparepaint3,
	preparepaint4,
	paintrun1,
	paintrun2,
	pornestetimer,
	paintrun3,
	paintrun4,
	pnstimer,
	wantedicatimer,
	spectatetimer,
	productiontimer,
	savedatatimer,
	checkgastimer,
	checkvehinfotimer,
	stoppedvehtimer,
	cartimer,
	levelexp = 3,
	pickups,
	Float:TeleportDest[MAX_PLAYERS][3],
	Float:TelePos[MAX_PLAYERS][6];
new PlayerText:RobBank[MAX_PLAYERS][41];
new RobSecunde[MAX_PLAYERS];
new RobCod[MAX_PLAYERS][10];
new RobCod2[MAX_PLAYERS][10];
new PlayerInfo[MAX_PLAYERS][pInfo];
new Gas[CAR_AMOUNT];
new Refueling[MAX_PLAYERS];
new ArmInfo[MAX_ARM][ArmeJos];
new BeforeSpectate[MAX_PLAYERS][beforeSpectateInfo];
new SpikeInfo[MAX_SPIKES][spikeE];
new TurfInfo[50][zInfo],
	Turfs[50];
new Float:LastPosition[MAX_PLAYERS][3];
new TeleportWarnings[MAX_PLAYERS];
new TeleportAllowed[MAX_PLAYERS];
new PlayMelodie[MAX_PLAYERS];
new SelectMode[MAX_PLAYERS] = {SELECT_MODE_ROB, ...};
new Unspec[MAX_PLAYERS][pSpec];
new RoadBlockInfo[MAX_ROADBLOCKS][rInfo];
new ClanInfo[MAX_CLANS][clanE];
new BlockPhone[MAX_PLAYERS][bpInfo];
new HouseInfo[500][hInfo],
	Text3D:HouseLabel[sizeof(HouseInfo)],
	HousePickup[500];
new BizzInfo[55][bInfo],
	Text3D:BizzLabel[sizeof(BizzInfo)];
new ConcursInfo[100][ConInf];
new CodInfo[100][codInfo];
new CarInfo[2000][cInfo],caridxx[MAX_VEHICLES];

new spoiler[20][0] = {
	{1000},
	{1001},
	{1002},
	{1003},
	{1014},
	{1015},
	{1016},
	{1023},
	{1058},
	{1060},
	{1049},
	{1050},
	{1138},
	{1139},
	{1146},
	{1147},
	{1158},
	{1162},
	{1163},
	{1164}
};

new nitro[3][0] = {
	{1008},
	{1009},
	{1010}
};

new fbumper[23][0] = {
	{1117},
	{1152},
	{1153},
	{1155},
	{1157},
	{1160},
	{1165},
	{1167},
	{1169},
	{1170},
	{1171},
	{1172},
	{1173},
	{1174},
	{1175},
	{1179},
	{1181},
	{1182},
	{1185},
	{1188},
	{1189},
	{1192},
	{1193}
};

new rbumper[22][0] = {
	{1140},
	{1141},
	{1148},
	{1149},
	{1150},
	{1151},
	{1154},
	{1156},
	{1159},
	{1161},
	{1166},
	{1168},
	{1176},
	{1177},
	{1178},
	{1180},
	{1183},
	{1184},
	{1186},
	{1187},
	{1190},
	{1191}
};

new exhaust[28][0] = {
	{1018},
	{1019},
	{1020},
	{1021},
	{1022},
	{1028},
	{1029},
	{1037},
	{1043},
	{1044},
	{1045},
	{1046},
	{1059},
	{1064},
	{1065},
	{1066},
	{1089},
	{1092},
	{1104},
	{1105},
	{1113},
	{1114},
	{1126},
	{1127},
	{1129},
	{1132},
	{1135},
	{1136}
};

new bventr[2][0] = {
	{1142},
	{1144}
};

new bventl[2][0] = {
	{1143},
	{1145}
};

new bscoop[4][0] = {
	{1004},
	{1005},
	{1011},
	{1012}
};

new rscoop[17][0] = {
	{1006},
	{1032},
	{1033},
	{1035},
	{1038},
	{1053},
	{1054},
	{1055},
	{1061},
	{1067},
	{1068},
	{1088},
	{1091},
	{1103},
	{1128},
	{1130},
	{1131}
};

new lskirt[21][0] = {
	{1007},
	{1026},
	{1031},
	{1036},
	{1039},
	{1042},
	{1047},
	{1048},
	{1056},
	{1057},
	{1069},
	{1070},
	{1090},
	{1093},
	{1106},
	{1108},
	{1118},
	{1119},
	{1133},
	{1122},
	{1134}
};

new rskirt[21][0] = {
	{1017},
	{1027},
	{1030},
	{1040},
	{1041},
	{1051},
	{1052},
	{1062},
	{1063},
	{1071},
	{1072},
	{1094},
	{1095},
	{1099},
	{1101},
	{1102},
	{1107},
	{1120},
	{1121},
	{1124},
	{1137}
};

new hydraulics[1][0] = {
	{1087}
};

new vbase[1][0] = {
	{1086}
};

new rbbars[4][0] = {
	{1109},
	{1110},
	{1123},
	{1125}
};

new fbbars[2][0] = {
	{1115},
	{1116}
};

new wheels[17][0] = {
	{1025},
	{1073},
	{1074},
	{1075},
	{1076},
	{1077},
	{1078},
	{1079},
	{1080},
	{1081},
	{1082},
	{1083},
	{1084},
	{1085},
	{1096},
	{1097},
	{1098}
};

new vlights[2][0] = {
	{1013},
	{1024}
};
new Stock[102][vInfo];
new DynamicFactions[15][Factions];
new GunNames[48][] =
{
	"Nothink",
	"Brass Knuckles",
	"Golf Club",
	"Nitestick",
	"Knife",
	"Baseball Bat",
	"Showel",
	"Pool Cue",
	"Katana",
	"Chainsaw",
	"Purple Dildo",
	"Small White Dildo",
	"Long White Dildo",
	"Vibrator",
	"Flowers",
	"Cane",
	"Grenade",
	"Tear Gas",
	"Molotov",
	"Vehicle Missile",
	"Hydra Flare",
	"Jetpack",
	"Glock",
	"Silenced Colt",
	"Desert Eagle",
	"Shotgun",
	"Sawn Off",
	"Combat Shotgun",
	"Micro UZI",
	"MP5",
	"AK47",
	"M4",
	"Tec9",
	"Rifle",
	"Sniper Rifle",
	"Rocket Launcher",
	"HS Rocket Launcher",
	"Flamethrower",
	"Minigun",
	"Satchel Charge",
	"Detonator",
	"Spraycan",
	"Fire Extinguisher",
	"Camera",
	"Nightvision",
	"Infrared Vision",
	"Parachute",
	"Fake Pistol"
};

new Peds[115][1] = {
{1},{2},{6},{7},{9},{10},{14},{15},{16},{18},{19},{20},{21},{22},{23},{24},{25},{26},{27},{28},
{29},{30},{31},{32},{33},{34},{35},{36},{37},{38},{39},{41},{43},{44},{45},{47},{48},{49},{51},
{52},{53},{54},{63},{64},{66},{67},{68},{69},{73},{75},{77},{78},{79},{80},{81},{82},{83},{84},
{87},{88},{89},{94},{95},{96},{97},{99},{100},{101},{128},{129},{130},{131},{132},{133},{134},
{135},{136},{137},{138},{139},{140},{142},{143},{144},{145},{146},{154},{162},{170},{180},{177},
{176},{181},{182},{183},{184},{193},{201},{202},{203},{204},{221},{230},{234},{237},{241},{242},
{247},{248},{249},{250},{252},{254},{299},{293}
};

new AntiFlood_Data[MAX_PLAYERS][LIST_ANTIFLOOD];

