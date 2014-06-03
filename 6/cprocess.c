#ifndef CPROCESS
#define CPROCESS

#define NrPCB 5
#define sectors_offset 22
#define USectors 2
int crtid;
unsigned short ax_save, bx_save, cx_save, dx_save, cs_save, ds_save, es_save, gs_save, ss_save, sp_save, bp_save, si_save, di_save, ip_save, flag_save, ret_save;

void CCLI();
void CSTI();
void load_sector(int n, int es, int num);

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

typedef struct PCB {
	RegisterImage reg;
	int status;
}PCB;

PCB pcblist[NrPCB];

int create(int program)
{
	CCLI();
	int id = 1;
	while (id < NrPCB) {
		if (!pcblist[id].status) {
			pcblist[id].status = 1;
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
	load_sector(sectors_offset + USectors * (program - 1), pcblist[id].reg.CS, USectors);
	CSTI();
	return id;
}

void kill(int id)
{
	pcblist[id].status = 0;
}

void Scheduler()
{
	int nid = crtid + 1;
	if (nid == NrPCB) nid = 0;
	while (nid != crtid) {
		if (!pcblist[nid].status) nid++;
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

#endif
