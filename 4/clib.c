#define MAX_LEN 1000
char buffer[MAX_LEN];
char time[9];
char date[11];
int hour, min, sec, century, year, month, day;

void putchar(char c);
char getchar();
void getTime();
void getDate();
void cls();
void loadSector(int head, int cylinder, int sector);
void call_int33();
void call_int34();
void call_int35();
void call_int36();

char* getline()
{
	int i=0;
	char c;
	while (i < MAX_LEN) {
		c = getchar();
		if (c == 13) {
			putchar(13);
			putchar(10);
			break;
		}
		else if (c == 8) {
			if (i > 0) {
				putchar(8);
				putchar(32);
				putchar(8);
				--i;
			}
		}
		else {
			putchar(c);
			buffer[i++] = c;
		}
	}
	buffer[i] = 0;
	return buffer;
}

void print(char *s)
{
	while (*s != 0) {
		if (*s == '\n') {
			putchar(13);
			putchar(10);
		}
		else putchar(*s);
		s++;
	}
}

int strcmp(char* a, char* b)
{
	while (*a != 0 && *b != 0) {
		if (*a != *b) return *a - *b;
		a++;
		b++;
	}
	return *a - *b;
}

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

void load_sector(int n)
{
	int head, cylinder, sector;
	sector = (n-1)%18+1;
	n = (n-1)/18;
	head = n/80;
	cylinder = n%80;
	loadSector(head, cylinder, sector);
}
