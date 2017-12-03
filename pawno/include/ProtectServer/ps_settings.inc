//////////////////////////////////////////////
// ** Copyright (c) Dimmi **			    //
// ** All right reserved! **			    //
// ** Please not remove this credits. **    //
//////////////////////////////////////////////

// NOTE!!!
// PLEASE DON'T CHANGE THIS SETTINGS
// IF YOU WANT SUPPORT PLEASE CONTACT ME
// ON FORUM WHERE YOU DOWNLOAD THIS FILTERSCRIPT.
// WITH RESPECT, Dimmi (Cartman#).

#define VERSION 1.1

#if defined DIMMI

#define COLOR_LIGHTRED 0xFF6347AA
#define IP_LIMIT 2 					// = Max connections from one single IP
#define SAME_IP_CONNECT 4			// = The number of connects from the same IP before banning the flooder
#define Time_Limit 3500 			// = The time span between connects, adjust it to your own specifications
#define RATE_INC (500) 				// The sensitivity per message, no need to modify.
#define RATE_MAX (2500) 			// When the flood rate reaches this value the action below will be taken
#define THRESOLD_ACTION 1 			// 1 = Ban; 2 = Kick; 3 = Warnings
new Warning[MAX_PLAYERS];

#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

#define MAX_SPEED_INCREASE  	40 // maximum of 40 increasable per check (if more then the user is airbreaking)
#define MIN_FORBIDDEN_SPEED     20 // minimum speed the player must be driving in a forbidden vehicle for anticheat to trigger

new szServerFile[32] 			= "server\\info.ini"; // server info file
#define COLOR_DARKRED			0xAA3333AA
#define COLOR_PINK				0xFF66FFAA
#define COLOR_GREY				0xAFAFAFAA

#define WEAPON_HACK     		0
#define MONEY_HACK      		1
#define TELEPORT_HACK			2
#define SPEED_HACK				3
#define HEALTH_HACK         	4
#define ARMOUR_HACK         	5
#define VEHICLEHEALTH_HACK  	6
#define FAKEKILL_HACK       	7
#define AIRBREAK_HACK       	8
#define CARSPAWN_HACK       	9

new ServerCash[MAX_PLAYERS] = 0; // sever sided cash (read from ini)
new ClientCash[MAX_PLAYERS] = 0; // client cash
new Difference[MAX_PLAYERS] = 0;
new PlayerSelecting[MAX_PLAYERS] = 0; // is the player selecting a skin?

new tmrAntiCheat_01, tmrAntiCheat_02;

new Float:fOldPos[MAX_PLAYERS][3]; // holds the latest position of the players
new Float:fCurrentPos[MAX_PLAYERS][3]; // holds the current position of the players
new PlayerUsedVehicle[MAX_PLAYERS]; // setting it through the loop, gives us some delay when the player jumps off at high speed

#endif
