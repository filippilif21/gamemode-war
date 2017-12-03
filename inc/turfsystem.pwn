#include <a_samp>
#include <a_mysql>
#include <zcmd>
#include <foreach>

#include "../inc/all_includes.pwn"
#include "../inc/new.pwn"
#include "../inc/connection.pwn"
#include "../inc/reglog.pwn"
#include "../inc/dialogs.pwn"
#include "../inc/stock.pwn"


function LoadTurfs()
{
	new result[100],index = 0;
    mysql_query(handle,"SELECT * FROM `turfs` ORDER BY `turfs`.`ID` ASC");
    mysql_store_result();
    while(mysql_retrieve_row())
    {
		index++;
		new i = index;
		mysql_get_field("ID", result);				tTurfs[i][zID] = strval(result);
   	    mysql_get_field("MinX", result);			tTurfs[i][zMinX] = floatstr(result);
    	mysql_get_field("MinY", result);			tTurfs[i][zMinY] = floatstr(result);
        mysql_get_field("MaxX", result);			tTurfs[i][zMaxX] = floatstr(result);
        mysql_get_field("MaxY", result);			tTurfs[i][zMaxY] = floatstr(result);
	}
	mysql_free_result();
	printf("[MySQL Turfs]: %d", index);
	return 1;
}