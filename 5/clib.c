#ifndef CLIB
#define CLIB
char time[9];
char date[11];
int hour, min, sec, century, year, month, day;

void getTime();
void getDate();
void cls();
void loadSector(int head, int cylinder, int sector, int num);
void call_int33();
void call_int34();
void call_int35();
void call_int36();

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

void load_sector(int n, int num)
{
	int head, cylinder, sector;
	sector = (n - 1) % 18 + 1;
	n = (n - 1) / 18;
	head = n & 1;
	cylinder = n * 2;
	loadSector(head, cylinder, sector, num);
}

#endif
