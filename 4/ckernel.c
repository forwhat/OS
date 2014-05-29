asm(".code16gcc");

#include "clib.c"

void cmain()
{
	print("MyOS v2.0!\nEnter help to show the commands\n");
	while (1) {
		print("Enter your command: ");
		char *command = getline();
		if (strcmp(command, "exit") == 0) {
			print("Exit successfully!\n");
			break;
		}
		else if (strcmp(command, "help") == 0) {
			print("clear    --clear the screen\n");
			print("date     --show the date\n");
			print("exit     --halt the machine\n");
			print("load     --load the program on image\n");
	    	print("time     --show the current time\n");
			print("int33-36    --int 33h to 36h\n");
			print("help     --show the command\n");
		}
		else if (strcmp(command, "clear") == 0) {
			cls();
		}
		else if (strcmp(command, "date") == 0) {
			print(get_date());
			print("\n");
		}
		else if (strcmp(command, "time") == 0) {
			print(get_time());
			print("\n");
		}
		else if (strcmp(command, "load") == 0) {
			cls();
			load_sector(12);
			cls();
		}
		else if (strcmp(command, "int33") == 0) {
			cls();
			call_int33();
		}
		else if (strcmp(command, "int34") == 0) {
			cls();
			call_int34();
		}
		else if (strcmp(command, "int35") == 0) {
			cls();
			call_int35();
		}
		else if (strcmp(command, "int36") == 0) {
			cls();
			call_int36();
		}
		else print("Command not found!\n");
	}
}
