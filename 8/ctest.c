asm(".code16gcc");

#include "cstring.c"

short fork();
void exit(char ch);
int SemaGet(int s);
void SemaFree(int s);
void P(int s);
void V(int s);

char words[100][20];
int size, times1 = 0x7fffffff, times2 = 0x7fffffff;

void putwords(char* s)
{
	int i = 0, j = 0, k = 0;
	while (s[i] != 0) {
		if (s[i] == ' ') {
			words[k++][j] = 0;
			i++;
			j = 0;
		}
		else  words[k][j++] = s[i++];
	}
	words[k][j] = 0;
	size = k + 1;
}

void test_main()
{
	int s, pid;
	s = SemaGet(1);
	if (s == -1) {
		print("Error in getting semaphore!");
		getline();
		exit(-1);
	}
	pid = fork();
	if (pid == -1) {
		print("Error in fork!");
		getline();
		exit(-1);
	}
	else if (pid == 0) {
		while (1) {
			P(s);
			putwords("one word after another word");
			V(s);
		}
		exit(0);
	}
	else {
		while (1) {
			P(s);
			int i;
			for (i = 0; i < size; ++i) {
				print(words[i]);
				print(" ");
			}
			print("\n");
			V(s);
		}
		exit(0);
	}
}
