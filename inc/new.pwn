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
new P_Data[MAX_PLAYERS][pInfo];

enum dInfo { 
    ID,
    Type,
    Weapon,
    Ammo,
    Text3D: Label
}
new DropInfo[MAX_PICKUPS][dInfo];
new activeHeal = 1;

new handle;

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
#define COLOR_GREENOX                                               0xB98300FF
#define COLOR_ADMCMD                                                0xFFC000FF
#define COLOR_HELLOB                                                0xCC8E33C8
#define COLOR_PNOB                                                  0xCEF0ACFF
#define COLOR_IN2                                                   0xe7aaa5a5

