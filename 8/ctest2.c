asm(".code16gcc");

#include "cstring.c"

short fork();
void exit(char ch);
int SemaGet(int s);
void SemaFree(int s);
void P(int s);
void V(int s);

char words[100][20];
int size, fruit_disk, crtfruit = 1;

void putfruit()
{
	fruit_disk = crtfruit++;
	if (crtfruit > 3) crtfruit = 1;
}

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

void test2_main()
{
	int s, s2, s3, pid;
	s = SemaGet(0);
	s2 = SemaGet(0);
	s3 = SemaGet(0);
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
		pid = fork();
		if (pid) {
			while (1) {
				putwords("What will we eat after dinner?");
				V(s);
				P(s2);
			}
			exit(0);
		}
		else {
			while(1) {
				putfruit();
				V(s);
				P(s3);
			}
			exit(0);
		}
	}
	else {
		while (1) {
			P(s);
			P(s);
			int i;
			for (i = 0; i < size; ++i) {
				print(words[i]);
				print(" ");
			}
			print("\n");
			if (fruit_disk == 1) print("Apples.\n");
			else if (fruit_disk == 2) print("Pears.\n");
			else if (fruit_disk == 3) print("Watermelon.\n");
			fruit_disk = 0;
			V(s2);
			V(s3);
		}
		exit(0);
	}
}
