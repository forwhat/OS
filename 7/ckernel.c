asm(".code16gcc");

#include "cstring.c"
#include "clib.c"
#include "csystemInt.c"
#include "cprocess.c"

void cmain()
{
	pcblist[0].status = READY;
	crtid = 0;
	print("MyOS v2.0!\nEnter help to show the commands.\n");
	while (1) {
		print("Enter your command: ");
		char *command = getline();
		if (strcmp(command, "exit") == 0) {
			print("Exit successfully!\n");
			break;
		}
		else if (strcmp(command, "help") == 0) {
			print("clear         --clear the screen\n");
			print("date          --show the date\n");
			print("exit          --halt the machine\n");
	    	print("time          --show the current time\n");
			print("load n(1-4)   --load the nth process\n");
			print("start         --start the processes\n");
			print("test          --test fork, wait and exit\n");
			print("help          --show the command\n");
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
		else if (strcmp(command, "load 1") == 0) {
			if (create(1) == -1) 
				print("Fail! Number of PCB has been full.\n");
			else
				print("Load successfully!\n");
		}
		else if (strcmp(command, "load 2") == 0) {
			if (create(2) == -1) 
				print("Fail! Number of PCB has been full.\n");
			else
				print("Load successfully!\n");
		}
		else if (strcmp(command, "load 3") == 0) {
			if (create(3) == -1) 
				print("Fail! Number of PCB has been full.\n");
			else
				print("Load successfully!\n");
		}
		else if (strcmp(command, "load 4") == 0) {
			if (create(4) == -1) 
				print("Fail! Number of PCB has been full.\n");
			else
				print("Load successfully!\n");
		}
		else if (strcmp(command, "test") == 0) {
			cls();
			Set_Timer();
			load_sector(30, 0x2000, 4);
			JUMP();
			Recover_Timer();
			cls();
		}
		else if (strcmp(command, "start") == 0) {
			cls();
			print("Press ESC to stop the processes.");
			Set_Timer();
			while (1) {
				char c = getchar();
				if (c == 0x1b) {
					int i = 1;
					while (i < NrPCB) kill(i++);
					break;
				}
			}
			Recover_Timer();
			cls();
		}
		else print("Command not found!\n");
	}
}
