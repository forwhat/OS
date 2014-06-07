#ifndef CPROCESS
#define CPROCESS

#define NrPCB 5
#define FREE 0
#define READY 1
#define BLOCKED 2
#define sectors_offset 22
#define USectors 2
int crtid;
unsigned short ax_save, bx_save, cx_save, dx_save, cs_save, ds_save, es_save, gs_save, ss_save, sp_save, bp_save, si_save, di_save, ip_save, flag_save, ret_save;

void CCLI();
void CSTI();
void load_sector(int n, int es, int num);
void memcopy(int ss, int size);

typedef struct RegisterImage {
	int SS;
	int GS;
	int ES;
	int DS;
	int DI;
	int SI;
	int BP;
	int SP;
	int BX;
	int DX;
	int CX;
	int AX;
	int IP;
	int CS;
	int Flags;
}RegisterImage;

typedef struct PCB PCB;
struct PCB {
	RegisterImage reg;
	int status;
	int fid;
	PCB* semanext;
};

PCB pcblist[NrPCB];

int create(int program_sector, int n)
{
	CCLI();
	int id = 1;
	while (id < NrPCB) {
		if (pcblist[id].status == FREE) {
			pcblist[id].status = READY;
			pcblist[id].fid = 0;
			pcblist[id].semanext = 0;
			pcblist[id].reg.CS = 0x1000 + id * 0x1000;
			pcblist[id].reg.IP = 0;
			pcblist[id].reg.SP = 0xffff;
			pcblist[id].reg.SS = pcblist[id].reg.CS;
			pcblist[id].reg.Flags = 0x200;
			break;
		}
		id++;
	}
	if (id == NrPCB) {
		CSTI();
		return -1;
	}
	load_sector(program_sector, pcblist[id].reg.CS, n);
	CSTI();
	return id;
}

void kill(int id)
{
	pcblist[id].status = FREE;
}

void Scheduler()
{
	int nid = crtid + 1;
	if (nid == NrPCB) nid = 0;
	while (nid != crtid) {
		if (pcblist[nid].status != READY) nid++;
		else break;
		if (nid == NrPCB) nid = 0;
	}
	if (crtid == nid) return;

	PCB* p = &pcblist[crtid];
	p->reg.SS = ss_save;
	p->reg.GS = gs_save;
	p->reg.ES = es_save;
	p->reg.DS = ds_save;
	p->reg.DI = di_save;
	p->reg.SI = si_save;
	p->reg.BP = bp_save;
	p->reg.SP = sp_save;
	p->reg.BX = bx_save;
	p->reg.DX = dx_save;
	p->reg.CX = cx_save;
	p->reg.AX = ax_save;
	p->reg.IP = ip_save;
	p->reg.CS = cs_save;
	p->reg.Flags = flag_save;

	crtid = nid;

	p = &pcblist[crtid];
	ss_save = p->reg.SS;
	gs_save = p->reg.GS;
	es_save = p->reg.ES;
	ds_save = p->reg.DS;
	di_save = p->reg.DI;
	si_save = p->reg.SI;
	bp_save = p->reg.BP;
	sp_save = p->reg.SP;
	ax_save = p->reg.AX;
	bx_save = p->reg.BX;
	cx_save = p->reg.CX;
	dx_save = p->reg.DX;
	ip_save = p->reg.IP;
	cs_save = p->reg.CS;
	flag_save = p->reg.Flags;
}

void do_fork()
{
	int id = 1;
	while (id < NrPCB) {
		if (pcblist[id].status == FREE) {
			pcblist[id].reg.AX = 0;
			pcblist[id].reg.BX = bx_save;
			pcblist[id].reg.CX = cx_save;
			pcblist[id].reg.DX = dx_save;
			pcblist[id].reg.CS = cs_save;
			pcblist[id].reg.DS = ds_save;
			pcblist[id].reg.ES = es_save;
			pcblist[id].reg.GS = gs_save;
			pcblist[id].reg.SS = 0x1000 + 0x1000 * id;
			pcblist[id].reg.SP = sp_save;
			pcblist[id].reg.BP = bp_save;
			pcblist[id].reg.DI = di_save;
			pcblist[id].reg.SI = si_save;
			pcblist[id].reg.IP = ip_save;
			pcblist[id].reg.Flags = flag_save;
			memcopy(pcblist[id].reg.SS, 0xffff - sp_save);
			pcblist[id].fid = crtid;
			pcblist[id].status = READY;
			pcblist[id].semanext = 0;
			break;
		}
		id++;
	}
	if (id == NrPCB) ax_save = -1;
	else ax_save = id;
}

void do_wait()
{
	pcblist[crtid].status = BLOCKED;
	Scheduler();
}

void do_exit(char ch)
{
	pcblist[crtid].status = FREE;
	pcblist[pcblist[crtid].fid].status = READY;
	pcblist[pcblist[crtid].fid].reg.AX = ch;
	Scheduler();
}

#endif
