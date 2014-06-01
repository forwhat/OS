#ifndef CSYSINT
#define CSYSINT
#include "cstring.c"

void lowertoupper(int es, int dx)
{
	char* p = (char*)(es * 16 + dx);
	while (*p) {
		if (*p >= 'a' && *p <= 'z')
			*p = *p + 'A' - 'a';
		p++;
	}
}

void uppertolower(int es, int dx)
{
	char* p = (char*)(es * 16 + dx);
	while (*p) {
		if (*p >= 'A' && *p <= 'Z')
			*p = *p - 'A' + 'a';
		p++;
	}
}

int strtonum(int es, int dx)
{
	int n = 0;
	char* p = (char*)(es * 16 + dx);
	while (*p) {
		if (*p >= '0' && *p <= '9') {
			n = n * 10 + *p - '0';
			p++;
		}
		else return -1;
	}
	return n;
}

void numtostr(int es, int dx, int bx)
{
	char* p = (char *)(es * 16 + dx);
	char tmp[40] = "0";
	int i = 0;
	while (bx) {
		tmp[i++] = bx % 10 + '0';
		bx /= 10;
	}
	while (i > 0) {
		i--;
		*p = tmp[i];
		p++;
	}
	*p = 0;
}

void putinplace(int es, int dx, int cx)
{
	char* p = (char*)(es * 16 + dx);
	int t = ((cx >> 8) * 80 + (cx & 0xff)) * 2;
	while (*p) {
		putcharinplace(t, *p);
		p++;
		t += 2;
	}
}

#endif
