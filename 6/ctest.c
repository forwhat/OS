asm(".code16gcc");

#include "cstring.c"

void test0();
void test1(int es, int dx);
void test2(int es, int dx);
int test3(int es, int dx);
void test4(int es, int dx, int bx);
void test5(int es, int dx, int ch, int cl);

void test_main()
{
	char *string;
	int row, col;
	test0();
	print("Input a string: ");
	string = getline();
	test1(0, (int)string);
	print("The uppercases: ");
	print(string);
	print("\n");
	test2(0, (int)string);
	print("The lowercases: ");
	print(string);
	print("\n");
	while (1) {
		print("Input a row number(0-24): ");
		string = getline();
		row = test3(0, (int)string);
		if (row >= 0 && row < 25) break;
		else {
			test4(0, (int)string, row);
			print(string);
			print(" is not between 0 and 24!\n");
		}
	}
	while (1) {
		print("Input a col number(0-79): ");
		string = getline();
		col = test3(0, (int)string);
		if (col >= 0 && col < 80) break;
		else {
			test4(0, (int)string, col);
			print(string);
			print(" is not between 0 and 79!\n");
		}
	}
	print("Input a string: ");
	string = getline();
	test5(0, (int)string, row, col);
	print("Press Enter to continue...");
	string = getline();
}

