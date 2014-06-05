#ifndef CLIB
#define CLIB
char time[9];
char date[11];
int hour, min, sec, century, year, month, day;

void getTime();
void getDate();
void cls();
void JUMP();
void loadSector(int head, int cylinder, int sector, int es, int num);
void Set_Timer();
void Recover_Timer();

int BCDdecode(int n)
{
	return n/16*10+n%16;
}

char* get_time()
{
	getTime();
	hour=BCDdecode(hour);
	min=BCDdecode(min);
	sec=BCDdecode(sec);
	time[0]=hour/10+'0';
	time[1]=hour%10+'0';
	time[2]=':';
	time[3]=min/10+'0';
	time[4]=min%10+'0';
	time[5]=':';
	time[6]=sec/10+'0';
	time[7]=sec%10+'0';
	return time;
}

char* get_date()
{
	getDate();
	century=BCDdecode(century);
	year=BCDdecode(year);
	month=BCDdecode(month);
	day=BCDdecode(day);
	date[0]=century/10+'0';
	date[1]=century%10+'0';
	date[2]=year/10+'0';
	date[3]=year%10+'0';
	date[4]='/';
	date[5]=month/10+'0';
	date[6]=month%10+'0';
	date[7]='/';
	date[8]=day/10+'0';
	date[9]=day%10+'0';
	return date;
}

void load_sector(int n, int es, int num)
{
	int head, cylinder, sector, rs = n - 1;
	sector = rs % 18 + 1;
	rs /= 18;
	head = rs % 2;
	cylinder = rs / 2;
	loadSector(head, cylinder, sector, es, num);
}

#endif
