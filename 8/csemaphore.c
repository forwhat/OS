#ifndef CSEMAPHORE
#define CSEMAPHORE

#include "cprocess.c"
#include "cstring.c"

#define NrSemaphore 10

typedef struct SemaphoreType SemaphoreType;
struct SemaphoreType {
	int count;
	PCB *next;
	int used;
};
SemaphoreType SemaphoreList[NrSemaphore];

short do_SemaGet(int value)
{
	short i = 0;
	while (i < NrSemaphore) {
		if (!SemaphoreList[i].used) {
			SemaphoreList[i].used = 1;
			SemaphoreList[i].count = value;
			SemaphoreList[i].next = 0;
			return i;
		}
		i++;
	}
	return -1;
}

void do_SemaFree(int s)
{
	SemaphoreList[s].used = 0;
}

void do_P(int s)
{
	SemaphoreList[s].count--;
	if (SemaphoreList[s].count < 0) {
		pcblist[crtid].status = BLOCKED;
		PCB* p = SemaphoreList[s].next;
		if (p == 0) SemaphoreList[s].next = &pcblist[crtid];
		else {
			while (p->semanext != 0) p = p->semanext;
			p->semanext = &pcblist[crtid];
		}
		pcblist[crtid].semanext = 0;
		Scheduler();
	}
}

void do_V(int s)
{
	SemaphoreList[s].count++;
	if (SemaphoreList[s].count <= 0) {
		PCB* p = SemaphoreList[s].next;
		if (p != 0) {
			SemaphoreList[s].next = p->semanext;
			p->status = READY;
			Scheduler();
		}
	}
}

#endif
