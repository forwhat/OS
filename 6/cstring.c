#ifndef CSTRING
#define CSTRING

#define MAX_LEN 100
void putchar(char c);
char getchar();
void putcharinplace(int pos, char c);

char buffer[MAX_LEN];

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

#endif

