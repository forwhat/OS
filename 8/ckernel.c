asm(".code16gcc");

#include "cstring.c"
#include "clib.c"
#include "csystemInt.c"
#include "cprocess.c"
#include "csemaphore.c"

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
			print("test1         --test the mutex function\n");
			print("test2         --test the synchronous function\n");
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
		else if (strcmp(command, "test1") == 0) {
			cls();
			create(22, 4);
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
		else if (strcmp(command, "test2") == 0) {
			cls();
			create(26, 4);
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
		else if (strcmp(command, "test3") == 0) {
			cls();
			create(30, 4);
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
