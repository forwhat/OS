asm(".code16gcc");

#include "cstring.c"

int fork();
int wait0();
void exit(char ch);
void numtostr(int es, int dx, int bx);

char tmp[20];
int LetterNr = 0;

void test_main()
{
	char str[80] = "whyaremyeyesusuallyfulloftears";
	int pid, ch;
	pid = fork();
	if (pid == -1) {
		print("Error in fork!");
		exit(-1);
	}
	else if (pid == 0) {
		char* p = str;
		while (*p != 0) {
			LetterNr++;
			p++;
		}
		exit(0);
	}
	else {
		ch = wait0();
		char* p = tmp;
		numtostr(0, (int)p, LetterNr);
		print("The length of the string is ");
		print(p);
		print("\nPress Enter to continue...");
		getline();
	}
}
