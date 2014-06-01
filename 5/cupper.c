asm(".code16gcc");

char getchar();
void putchar(char c);

void upper_main()
{
	char *s = "Input some lowercases(press Esc to quit): ";
	while (*s) putchar(*s++);
	char c, buffer[1000];
	int i = 0;
	while (1) {
		c = getchar();
		if (c == 0x1b) break;
		if (c == 0xd) {
			putchar(0xd);
			putchar(0xa);
			buffer[i] = 0;
			i = 0;
			while (buffer[i]) putchar(buffer[i++]);
			putchar(0xd);
			putchar(0xa);
			i = 0;
		}
		else {
			if (c >= 'a' && c <= 'z') buffer[i++] = c + 'A' - 'a';
		    else buffer[i++] = c;
			putchar(c);
		}
	}
}
