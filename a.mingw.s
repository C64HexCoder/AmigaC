
a.mingw.elf:     file format elf32-m68k


Disassembly of section .text:

00000000 <_start>:
extern void (*__init_array_start[])() __attribute__((weak));
extern void (*__init_array_end[])() __attribute__((weak));
extern void (*__fini_array_start[])() __attribute__((weak));
extern void (*__fini_array_end[])() __attribute__((weak));

__attribute__((used)) __attribute__((section(".text.unlikely"))) void _start() {
   0:	       movem.l d2-d3/a2,-(sp)
	// initialize globals, ctors etc.
	unsigned long count;
	unsigned long i;

	count = __preinit_array_end - __preinit_array_start;
   4:	       move.l #17444,d3
   a:	       subi.l #17444,d3
  10:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  12:	       move.l #17444,d0
  18:	       cmpi.l #17444,d0
  1e:	/----- beq.s 32 <_start+0x32>
  20:	|      lea 4424 <incbin_module_start>,a2
  26:	|      moveq #0,d2
		__preinit_array_start[i]();
  28:	|  /-> movea.l (a2)+,a0
  2a:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
  2c:	|  |   addq.l #1,d2
  2e:	|  |   cmp.l d3,d2
  30:	|  \-- bcs.s 28 <_start+0x28>

	count = __init_array_end - __init_array_start;
  32:	\----> move.l #17444,d3
  38:	       subi.l #17444,d3
  3e:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  40:	       move.l #17444,d0
  46:	       cmpi.l #17444,d0
  4c:	/----- beq.s 60 <_start+0x60>
  4e:	|      lea 4424 <incbin_module_start>,a2
  54:	|      moveq #0,d2
		__init_array_start[i]();
  56:	|  /-> movea.l (a2)+,a0
  58:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
  5a:	|  |   addq.l #1,d2
  5c:	|  |   cmp.l d3,d2
  5e:	|  \-- bcs.s 56 <_start+0x56>

	main();
  60:	\----> jsr 8c <main>

	// call dtors
	count = __fini_array_end - __fini_array_start;
  66:	       move.l #17444,d2
  6c:	       subi.l #17444,d2
  72:	       asr.l #2,d2
	for (i = count; i > 0; i--)
  74:	/----- beq.s 86 <_start+0x86>
  76:	|      lea 4424 <incbin_module_start>,a2
		__fini_array_start[i - 1]();
  7c:	|  /-> subq.l #1,d2
  7e:	|  |   movea.l -(a2),a0
  80:	|  |   jsr (a0)
	for (i = count; i > 0; i--)
  82:	|  |   tst.l d2
  84:	|  \-- bne.s 7c <_start+0x7c>
}
  86:	\----> movem.l (sp)+,d2-d3/a2
  8a:	       rts

0000008c <main>:
};




int main() {
  8c:	                         subq.l #8,sp
  8e:	                         movem.l d2/d7/a2-a3/a6,-(sp)
	SysBase = *((struct ExecBase**)4UL);
  92:	                         movea.l 4 <_start+0x4>,a6
  96:	                         move.l a6,658a <SysBase>
	custom = (struct Custom*)0xdff000;
  9c:	                         move.l #14675968,6586 <custom>

	UWORD *Bitmap = (UWORD *) AllocMem (320*256*3/8,MEMF_CHIP|MEMF_CLEAR);
  a6:	                         move.l #30720,d0
  ac:	                         move.l #65538,d1
  b2:	                         jsr -198(a6)
  b6:	                         move.l d0,d2
	//InitView (&view);
	
	struct IntuitionBase *IntuitionBase;
	
	// We will use the graphics library only to locate and restore the system copper list once we are through.
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR)"graphics.library",0);
  b8:	                         movea.l 658a <SysBase>,a6
  be:	                         lea 23f5 <incbin_player_end+0x1>,a1
  c4:	                         moveq #0,d0
  c6:	                         jsr -552(a6)
  ca:	                         move.l d0,6582 <GfxBase>
	if (!GfxBase)
  d0:	      /----------------- beq.w 4fc <main+0x470>
		Exit(0);

	
	// used for printing
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
  d4:	      |                  movea.l 658a <SysBase>,a6
  da:	      |                  lea 2406 <incbin_player_end+0x12>,a1
  e0:	      |                  moveq #0,d0
  e2:	      |                  jsr -552(a6)
  e6:	      |                  move.l d0,657e <DOSBase>
	if (!DOSBase)
  ec:	/-----|----------------- beq.w 4d8 <main+0x44c>
		Exit(0);

	IntuitionBase = (struct IntuitionBase *)OpenLibrary((CONST_STRPTR)"intuition.library",0);
  f0:	|  /--|----------------> movea.l 658a <SysBase>,a6
  f6:	|  |  |                  lea 2412 <incbin_player_end+0x1e>,a1
  fc:	|  |  |                  moveq #0,d0
  fe:	|  |  |                  jsr -552(a6)
	if (!IntuitionBase)
 102:	|  |  |                  tst.l d0
 104:	|  |  |  /-------------- beq.w 37a <main+0x2ee>
	Forbid();
 108:	|  |  |  |  /----------> movea.l 658a <SysBase>,a6
 10e:	|  |  |  |  |            jsr -132(a6)
	SystemADKCON=custom->adkconr;
 112:	|  |  |  |  |            movea.l 6586 <custom>,a0
 118:	|  |  |  |  |            move.w 16(a0),d0
 11c:	|  |  |  |  |            move.w d0,6570 <SystemADKCON>
	SystemInts=custom->intenar;
 122:	|  |  |  |  |            move.w 28(a0),d0
 126:	|  |  |  |  |            move.w d0,6574 <SystemInts>
	SystemDMA=custom->dmaconr;
 12c:	|  |  |  |  |            move.w 2(a0),d0
 130:	|  |  |  |  |            move.w d0,6572 <SystemDMA>
	ActiView=GfxBase->ActiView; //store current view
 136:	|  |  |  |  |            movea.l 6582 <GfxBase>,a6
 13c:	|  |  |  |  |            move.l 34(a6),656c <ActiView>
	LoadView(0);
 144:	|  |  |  |  |            suba.l a1,a1
 146:	|  |  |  |  |            jsr -222(a6)
	WaitTOF();
 14a:	|  |  |  |  |            movea.l 6582 <GfxBase>,a6
 150:	|  |  |  |  |            jsr -270(a6)
	WaitTOF();
 154:	|  |  |  |  |            movea.l 6582 <GfxBase>,a6
 15a:	|  |  |  |  |            jsr -270(a6)
	WaitVbl();
 15e:	|  |  |  |  |            lea 528 <WaitVbl>,a2
 164:	|  |  |  |  |            jsr (a2)
	WaitVbl();
 166:	|  |  |  |  |            jsr (a2)
	OwnBlitter();
 168:	|  |  |  |  |            movea.l 6582 <GfxBase>,a6
 16e:	|  |  |  |  |            jsr -456(a6)
	WaitBlit();	
 172:	|  |  |  |  |            movea.l 6582 <GfxBase>,a6
 178:	|  |  |  |  |            jsr -228(a6)
	Disable();
 17c:	|  |  |  |  |            movea.l 658a <SysBase>,a6
 182:	|  |  |  |  |            jsr -120(a6)
	custom->intena=0x7fff;//disable all interrupts
 186:	|  |  |  |  |            movea.l 6586 <custom>,a0
 18c:	|  |  |  |  |            move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
 192:	|  |  |  |  |            move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
 198:	|  |  |  |  |            move.w #32767,150(a0)
	WaitVbl();
 19e:	|  |  |  |  |            jsr (a2)
	WaitVbl();
 1a0:	|  |  |  |  |            jsr (a2)
	UWORD getvbr[] = { 0x4e7a, 0x0801, 0x4e73 }; // MOVEC.L VBR,D0 RTE
 1a2:	|  |  |  |  |            move.w #20090,22(sp)
 1a8:	|  |  |  |  |            move.w #2049,24(sp)
 1ae:	|  |  |  |  |            move.w #20083,26(sp)
	if (SysBase->AttnFlags & AFF_68010) 
 1b4:	|  |  |  |  |            movea.l 658a <SysBase>,a6
 1ba:	|  |  |  |  |            btst #0,297(a6)
 1c0:	|  |  |  |  |  /-------- beq.w 442 <main+0x3b6>
		vbr = (APTR)Supervisor((ULONG (*)())getvbr);
 1c4:	|  |  |  |  |  |  /----> moveq #22,d7
 1c6:	|  |  |  |  |  |  |      add.l sp,d7
 1c8:	|  |  |  |  |  |  |      exg d7,a5
 1ca:	|  |  |  |  |  |  |      jsr -30(a6)
 1ce:	|  |  |  |  |  |  |      exg d7,a5
	VBR=GetVBR();
 1d0:	|  |  |  |  |  |  |      move.l d0,6576 <VBR>
	return *(volatile APTR*)(((UBYTE*)VBR)+0x6c);
 1d6:	|  |  |  |  |  |  |      movea.l 6576 <VBR>,a0
 1dc:	|  |  |  |  |  |  |      move.l 108(a0),d0
	SystemIrq=GetInterruptHandler(); //store interrupt register
 1e0:	|  |  |  |  |  |  |      move.l d0,657a <SystemIrq>
	volatile BYTE *Mouse = (volatile BYTE *) 0xbfe001;

	TakeSystem();

	for (int i=0; i<3; i++) {
		copper_list[2+i*2][1] = (long)(Bitmap+i*5120)>>16;
 1e6:	|  |  |  |  |  |  |      move.l d2,d0
 1e8:	|  |  |  |  |  |  |      swap d0
 1ea:	|  |  |  |  |  |  |      ext.l d0
 1ec:	|  |  |  |  |  |  |      move.w d0,6508 <copper_list+0xa>
		copper_list[3+i*2][1] = (long)(Bitmap+i*5120);// & 0xffff;
 1f2:	|  |  |  |  |  |  |      move.w d2,650c <copper_list+0xe>
		copper_list[2+i*2][1] = (long)(Bitmap+i*5120)>>16;
 1f8:	|  |  |  |  |  |  |      move.l d2,d0
 1fa:	|  |  |  |  |  |  |      addi.l #10240,d0
 200:	|  |  |  |  |  |  |      move.l d0,d1
 202:	|  |  |  |  |  |  |      swap d1
 204:	|  |  |  |  |  |  |      ext.l d1
 206:	|  |  |  |  |  |  |      move.w d1,6510 <copper_list+0x12>
		copper_list[3+i*2][1] = (long)(Bitmap+i*5120);// & 0xffff;
 20c:	|  |  |  |  |  |  |      move.w d0,6514 <copper_list+0x16>
		copper_list[2+i*2][1] = (long)(Bitmap+i*5120)>>16;
 212:	|  |  |  |  |  |  |      addi.l #10240,d0
 218:	|  |  |  |  |  |  |      move.l d0,d1
 21a:	|  |  |  |  |  |  |      swap d1
 21c:	|  |  |  |  |  |  |      ext.l d1
 21e:	|  |  |  |  |  |  |      move.w d1,6518 <copper_list+0x1a>
		copper_list[3+i*2][1] = (long)(Bitmap+i*5120);// & 0xffff;
 224:	|  |  |  |  |  |  |      move.w d0,651c <copper_list+0x1e>
	}	

	custom->cop1lc = (ULONG)(copper_list);
 22a:	|  |  |  |  |  |  |      movea.l 6586 <custom>,a0
 230:	|  |  |  |  |  |  |      move.l #25854,128(a0)
	custom->dmacon |= DMAF_MASTER | DMAF_SETCLR | DMAF_RASTER |DMAF_COPPER | DMAF_BLITTER;
 238:	|  |  |  |  |  |  |      move.w 150(a0),d0
 23c:	|  |  |  |  |  |  |      ori.w #-31808,d0
 240:	|  |  |  |  |  |  |      move.w d0,150(a0)
	custom->copjmp1 = 0;
 244:	|  |  |  |  |  |  |      move.w #0,136(a0)

	
	for (int i = 0; i < 5120; i++)
		Bitmap[i]= MyLogo[i];
 24a:	|  |  |  |  |  |  |      pea 2800 <incbin_player_end+0x40c>
 24e:	|  |  |  |  |  |  |      pea 589e <MyLogo>
 254:	|  |  |  |  |  |  |      move.l d2,-(sp)
 256:	|  |  |  |  |  |  |      jsr 772 <memcpy>
 25c:	|  |  |  |  |  |  |      lea 12(sp),sp
__attribute__((always_inline)) inline short MouseLeft(){return !((*(volatile UBYTE*)0xbfe001)&64);}	
 260:	|  |  |  |  |  |  |  /-> move.b bfe001 <_end+0xbf7a71>,d1
		custom->bltsizh = 4;
		//custom->bltsize = (48 << 6) | 11; 
	}*/


	while (!MouseLeft());
 266:	|  |  |  |  |  |  |  |   btst #6,d1
 26a:	|  |  |  |  |  |  |  +-- bne.s 260 <main+0x1d4>

	FreeMem(Bitmap,320*256*3/8);
 26c:	|  |  |  |  |  |  |  |   movea.l 658a <SysBase>,a6
 272:	|  |  |  |  |  |  |  |   movea.l d2,a1
 274:	|  |  |  |  |  |  |  |   move.l #30720,d0
 27a:	|  |  |  |  |  |  |  |   jsr -210(a6)
		register volatile const void* _a3 ASM("a3") = player;
 27e:	|  |  |  |  |  |  |  |   lea a8e <incbin_player_start>,a3
		register volatile const void* _a6 ASM("a6") = (void*)0xdff000;
 284:	|  |  |  |  |  |  |  |   movea.l #14675968,a6
		__asm volatile (
 28a:	|  |  |  |  |  |  |  |   movem.l d0-d1/a0-a1,-(sp)
 28e:	|  |  |  |  |  |  |  |   jsr 8(a3)
 292:	|  |  |  |  |  |  |  |   movem.l (sp)+,d0-d1/a0-a1
	WaitVbl();
 296:	|  |  |  |  |  |  |  |   jsr (a2)
	WaitBlit();
 298:	|  |  |  |  |  |  |  |   movea.l 6582 <GfxBase>,a6
 29e:	|  |  |  |  |  |  |  |   jsr -228(a6)
	custom->intena=0x7fff;//disable all interrupts
 2a2:	|  |  |  |  |  |  |  |   movea.l 6586 <custom>,a0
 2a8:	|  |  |  |  |  |  |  |   move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
 2ae:	|  |  |  |  |  |  |  |   move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
 2b4:	|  |  |  |  |  |  |  |   move.w #32767,150(a0)
	*(volatile APTR*)(((UBYTE*)VBR)+0x6c) = interrupt;
 2ba:	|  |  |  |  |  |  |  |   movea.l 6576 <VBR>,a1
 2c0:	|  |  |  |  |  |  |  |   move.l 657a <SystemIrq>,108(a1)
	custom->cop1lc=(ULONG)GfxBase->copinit;
 2c8:	|  |  |  |  |  |  |  |   movea.l 6582 <GfxBase>,a6
 2ce:	|  |  |  |  |  |  |  |   move.l 38(a6),128(a0)
	custom->cop2lc=(ULONG)GfxBase->LOFlist;
 2d4:	|  |  |  |  |  |  |  |   move.l 50(a6),132(a0)
	custom->copjmp1=0x7fff; //start coppper
 2da:	|  |  |  |  |  |  |  |   move.w #32767,136(a0)
	custom->intena=SystemInts|0x8000;
 2e0:	|  |  |  |  |  |  |  |   move.w 6574 <SystemInts>,d0
 2e6:	|  |  |  |  |  |  |  |   ori.w #-32768,d0
 2ea:	|  |  |  |  |  |  |  |   move.w d0,154(a0)
	custom->dmacon=SystemDMA|0x8000;
 2ee:	|  |  |  |  |  |  |  |   move.w 6572 <SystemDMA>,d0
 2f4:	|  |  |  |  |  |  |  |   ori.w #-32768,d0
 2f8:	|  |  |  |  |  |  |  |   move.w d0,150(a0)
	custom->adkcon=SystemADKCON|0x8000;
 2fc:	|  |  |  |  |  |  |  |   move.w 6570 <SystemADKCON>,d0
 302:	|  |  |  |  |  |  |  |   ori.w #-32768,d0
 306:	|  |  |  |  |  |  |  |   move.w d0,158(a0)
	WaitBlit();	
 30a:	|  |  |  |  |  |  |  |   jsr -228(a6)
	DisownBlitter();
 30e:	|  |  |  |  |  |  |  |   movea.l 6582 <GfxBase>,a6
 314:	|  |  |  |  |  |  |  |   jsr -462(a6)
	Enable();
 318:	|  |  |  |  |  |  |  |   movea.l 658a <SysBase>,a6
 31e:	|  |  |  |  |  |  |  |   jsr -126(a6)
	LoadView(ActiView);
 322:	|  |  |  |  |  |  |  |   movea.l 6582 <GfxBase>,a6
 328:	|  |  |  |  |  |  |  |   movea.l 656c <ActiView>,a1
 32e:	|  |  |  |  |  |  |  |   jsr -222(a6)
	WaitTOF();
 332:	|  |  |  |  |  |  |  |   movea.l 6582 <GfxBase>,a6
 338:	|  |  |  |  |  |  |  |   jsr -270(a6)
	WaitTOF();
 33c:	|  |  |  |  |  |  |  |   movea.l 6582 <GfxBase>,a6
 342:	|  |  |  |  |  |  |  |   jsr -270(a6)
	Permit();
 346:	|  |  |  |  |  |  |  |   movea.l 658a <SysBase>,a6
 34c:	|  |  |  |  |  |  |  |   jsr -138(a6)
	p61End();
#endif

	// END
	FreeSystem(); 
	CloseLibrary((struct Library*)DOSBase);
 350:	|  |  |  |  |  |  |  |   movea.l 658a <SysBase>,a6
 356:	|  |  |  |  |  |  |  |   movea.l 657e <DOSBase>,a1
 35c:	|  |  |  |  |  |  |  |   jsr -414(a6)
	CloseLibrary((struct Library*)GfxBase);
 360:	|  |  |  |  |  |  |  |   movea.l 658a <SysBase>,a6
 366:	|  |  |  |  |  |  |  |   movea.l 6582 <GfxBase>,a1
 36c:	|  |  |  |  |  |  |  |   jsr -414(a6)
}
 370:	|  |  |  |  |  |  |  |   moveq #0,d0
 372:	|  |  |  |  |  |  |  |   movem.l (sp)+,d2/d7/a2-a3/a6
 376:	|  |  |  |  |  |  |  |   addq.l #8,sp
 378:	|  |  |  |  |  |  |  |   rts
		Exit(0);
 37a:	|  |  |  >--|--|--|--|-> movea.l 657e <DOSBase>,a6
 380:	|  |  |  |  |  |  |  |   moveq #0,d1
 382:	|  |  |  |  |  |  |  |   jsr -144(a6)
	Forbid();
 386:	|  |  |  |  |  |  |  |   movea.l 658a <SysBase>,a6
 38c:	|  |  |  |  |  |  |  |   jsr -132(a6)
	SystemADKCON=custom->adkconr;
 390:	|  |  |  |  |  |  |  |   movea.l 6586 <custom>,a0
 396:	|  |  |  |  |  |  |  |   move.w 16(a0),d0
 39a:	|  |  |  |  |  |  |  |   move.w d0,6570 <SystemADKCON>
	SystemInts=custom->intenar;
 3a0:	|  |  |  |  |  |  |  |   move.w 28(a0),d0
 3a4:	|  |  |  |  |  |  |  |   move.w d0,6574 <SystemInts>
	SystemDMA=custom->dmaconr;
 3aa:	|  |  |  |  |  |  |  |   move.w 2(a0),d0
 3ae:	|  |  |  |  |  |  |  |   move.w d0,6572 <SystemDMA>
	ActiView=GfxBase->ActiView; //store current view
 3b4:	|  |  |  |  |  |  |  |   movea.l 6582 <GfxBase>,a6
 3ba:	|  |  |  |  |  |  |  |   move.l 34(a6),656c <ActiView>
	LoadView(0);
 3c2:	|  |  |  |  |  |  |  |   suba.l a1,a1
 3c4:	|  |  |  |  |  |  |  |   jsr -222(a6)
	WaitTOF();
 3c8:	|  |  |  |  |  |  |  |   movea.l 6582 <GfxBase>,a6
 3ce:	|  |  |  |  |  |  |  |   jsr -270(a6)
	WaitTOF();
 3d2:	|  |  |  |  |  |  |  |   movea.l 6582 <GfxBase>,a6
 3d8:	|  |  |  |  |  |  |  |   jsr -270(a6)
	WaitVbl();
 3dc:	|  |  |  |  |  |  |  |   lea 528 <WaitVbl>,a2
 3e2:	|  |  |  |  |  |  |  |   jsr (a2)
	WaitVbl();
 3e4:	|  |  |  |  |  |  |  |   jsr (a2)
	OwnBlitter();
 3e6:	|  |  |  |  |  |  |  |   movea.l 6582 <GfxBase>,a6
 3ec:	|  |  |  |  |  |  |  |   jsr -456(a6)
	WaitBlit();	
 3f0:	|  |  |  |  |  |  |  |   movea.l 6582 <GfxBase>,a6
 3f6:	|  |  |  |  |  |  |  |   jsr -228(a6)
	Disable();
 3fa:	|  |  |  |  |  |  |  |   movea.l 658a <SysBase>,a6
 400:	|  |  |  |  |  |  |  |   jsr -120(a6)
	custom->intena=0x7fff;//disable all interrupts
 404:	|  |  |  |  |  |  |  |   movea.l 6586 <custom>,a0
 40a:	|  |  |  |  |  |  |  |   move.w #32767,154(a0)
	custom->intreq=0x7fff;//Clear any interrupts that were pending
 410:	|  |  |  |  |  |  |  |   move.w #32767,156(a0)
	custom->dmacon=0x7fff;//Clear all DMA channels
 416:	|  |  |  |  |  |  |  |   move.w #32767,150(a0)
	WaitVbl();
 41c:	|  |  |  |  |  |  |  |   jsr (a2)
	WaitVbl();
 41e:	|  |  |  |  |  |  |  |   jsr (a2)
	UWORD getvbr[] = { 0x4e7a, 0x0801, 0x4e73 }; // MOVEC.L VBR,D0 RTE
 420:	|  |  |  |  |  |  |  |   move.w #20090,22(sp)
 426:	|  |  |  |  |  |  |  |   move.w #2049,24(sp)
 42c:	|  |  |  |  |  |  |  |   move.w #20083,26(sp)
	if (SysBase->AttnFlags & AFF_68010) 
 432:	|  |  |  |  |  |  |  |   movea.l 658a <SysBase>,a6
 438:	|  |  |  |  |  |  |  |   btst #0,297(a6)
 43e:	|  |  |  |  |  |  \--|-- bne.w 1c4 <main+0x138>
	APTR vbr = 0;
 442:	|  |  |  |  |  \-----|-> moveq #0,d0
	VBR=GetVBR();
 444:	|  |  |  |  |        |   move.l d0,6576 <VBR>
	return *(volatile APTR*)(((UBYTE*)VBR)+0x6c);
 44a:	|  |  |  |  |        |   movea.l 6576 <VBR>,a0
 450:	|  |  |  |  |        |   move.l 108(a0),d0
	SystemIrq=GetInterruptHandler(); //store interrupt register
 454:	|  |  |  |  |        |   move.l d0,657a <SystemIrq>
		copper_list[2+i*2][1] = (long)(Bitmap+i*5120)>>16;
 45a:	|  |  |  |  |        |   move.l d2,d0
 45c:	|  |  |  |  |        |   swap d0
 45e:	|  |  |  |  |        |   ext.l d0
 460:	|  |  |  |  |        |   move.w d0,6508 <copper_list+0xa>
		copper_list[3+i*2][1] = (long)(Bitmap+i*5120);// & 0xffff;
 466:	|  |  |  |  |        |   move.w d2,650c <copper_list+0xe>
		copper_list[2+i*2][1] = (long)(Bitmap+i*5120)>>16;
 46c:	|  |  |  |  |        |   move.l d2,d0
 46e:	|  |  |  |  |        |   addi.l #10240,d0
 474:	|  |  |  |  |        |   move.l d0,d1
 476:	|  |  |  |  |        |   swap d1
 478:	|  |  |  |  |        |   ext.l d1
 47a:	|  |  |  |  |        |   move.w d1,6510 <copper_list+0x12>
		copper_list[3+i*2][1] = (long)(Bitmap+i*5120);// & 0xffff;
 480:	|  |  |  |  |        |   move.w d0,6514 <copper_list+0x16>
		copper_list[2+i*2][1] = (long)(Bitmap+i*5120)>>16;
 486:	|  |  |  |  |        |   addi.l #10240,d0
 48c:	|  |  |  |  |        |   move.l d0,d1
 48e:	|  |  |  |  |        |   swap d1
 490:	|  |  |  |  |        |   ext.l d1
 492:	|  |  |  |  |        |   move.w d1,6518 <copper_list+0x1a>
		copper_list[3+i*2][1] = (long)(Bitmap+i*5120);// & 0xffff;
 498:	|  |  |  |  |        |   move.w d0,651c <copper_list+0x1e>
	custom->cop1lc = (ULONG)(copper_list);
 49e:	|  |  |  |  |        |   movea.l 6586 <custom>,a0
 4a4:	|  |  |  |  |        |   move.l #25854,128(a0)
	custom->dmacon |= DMAF_MASTER | DMAF_SETCLR | DMAF_RASTER |DMAF_COPPER | DMAF_BLITTER;
 4ac:	|  |  |  |  |        |   move.w 150(a0),d0
 4b0:	|  |  |  |  |        |   ori.w #-31808,d0
 4b4:	|  |  |  |  |        |   move.w d0,150(a0)
	custom->copjmp1 = 0;
 4b8:	|  |  |  |  |        |   move.w #0,136(a0)
		Bitmap[i]= MyLogo[i];
 4be:	|  |  |  |  |        |   pea 2800 <incbin_player_end+0x40c>
 4c2:	|  |  |  |  |        |   pea 589e <MyLogo>
 4c8:	|  |  |  |  |        |   move.l d2,-(sp)
 4ca:	|  |  |  |  |        |   jsr 772 <memcpy>
 4d0:	|  |  |  |  |        |   lea 12(sp),sp
 4d4:	|  |  |  |  |        \-- bra.w 260 <main+0x1d4>
		Exit(0);
 4d8:	>--|--|--|--|----------> suba.l a6,a6
 4da:	|  |  |  |  |            moveq #0,d1
 4dc:	|  |  |  |  |            jsr -144(a6)
	IntuitionBase = (struct IntuitionBase *)OpenLibrary((CONST_STRPTR)"intuition.library",0);
 4e0:	|  |  |  |  |            movea.l 658a <SysBase>,a6
 4e6:	|  |  |  |  |            lea 2412 <incbin_player_end+0x1e>,a1
 4ec:	|  |  |  |  |            moveq #0,d0
 4ee:	|  |  |  |  |            jsr -552(a6)
	if (!IntuitionBase)
 4f2:	|  |  |  |  |            tst.l d0
 4f4:	|  |  |  |  \----------- bne.w 108 <main+0x7c>
 4f8:	|  |  |  \-------------- bra.w 37a <main+0x2ee>
		Exit(0);
 4fc:	|  |  \----------------> movea.l 657e <DOSBase>,a6
 502:	|  |                     moveq #0,d1
 504:	|  |                     jsr -144(a6)
	DOSBase = (struct DosLibrary*)OpenLibrary((CONST_STRPTR)"dos.library", 0);
 508:	|  |                     movea.l 658a <SysBase>,a6
 50e:	|  |                     lea 2406 <incbin_player_end+0x12>,a1
 514:	|  |                     moveq #0,d0
 516:	|  |                     jsr -552(a6)
 51a:	|  |                     move.l d0,657e <DOSBase>
	if (!DOSBase)
 520:	|  \-------------------- bne.w f0 <main+0x64>
 524:	\----------------------- bra.s 4d8 <main+0x44c>
 526:	                         nop

00000528 <WaitVbl>:
void WaitVbl() {
 528:	             subq.l #8,sp
}

static void debug_cmd(unsigned int arg1, unsigned int arg2, unsigned int arg3, unsigned int arg4) {
	long(*UaeLib)(unsigned int arg0, unsigned int arg1, unsigned int arg2, unsigned int arg3, unsigned int arg4);
	UaeLib = (long(*)(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int))0xf0ff60;
	if(*((UWORD *)UaeLib) == 0x4eb9 || *((UWORD *)UaeLib) == 0xa00e) {
 52a:	             move.w f0ff60 <_end+0xf099d0>,d0
 530:	             cmpi.w #20153,d0
 534:	      /----- beq.s 5ae <WaitVbl+0x86>
 536:	      |      cmpi.w #-24562,d0
 53a:	      +----- beq.s 5ae <WaitVbl+0x86>
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
 53c:	/-----|----> move.l dff004 <_end+0xdf8a74>,d0
 542:	|     |      move.l d0,(sp)
		vpos&=0x1ff00;
 544:	|     |      move.l (sp),d0
 546:	|     |      andi.l #130816,d0
 54c:	|     |      move.l d0,(sp)
		if (vpos!=(311<<8))
 54e:	|     |      move.l (sp),d0
 550:	|     |      cmpi.l #79616,d0
 556:	+-----|----- beq.s 53c <WaitVbl+0x14>
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
 558:	|  /--|----> move.l dff004 <_end+0xdf8a74>,d0
 55e:	|  |  |      move.l d0,4(sp)
		vpos&=0x1ff00;
 562:	|  |  |      move.l 4(sp),d0
 566:	|  |  |      andi.l #130816,d0
 56c:	|  |  |      move.l d0,4(sp)
		if (vpos==(311<<8))
 570:	|  |  |      move.l 4(sp),d0
 574:	|  |  |      cmpi.l #79616,d0
 57a:	|  +--|----- bne.s 558 <WaitVbl+0x30>
 57c:	|  |  |      move.w f0ff60 <_end+0xf099d0>,d0
 582:	|  |  |      cmpi.w #20153,d0
 586:	|  |  |  /-- beq.s 592 <WaitVbl+0x6a>
 588:	|  |  |  |   cmpi.w #-24562,d0
 58c:	|  |  |  +-- beq.s 592 <WaitVbl+0x6a>
}
 58e:	|  |  |  |   addq.l #8,sp
 590:	|  |  |  |   rts
		UaeLib(88, arg1, arg2, arg3, arg4);
 592:	|  |  |  \-> clr.l -(sp)
 594:	|  |  |      clr.l -(sp)
 596:	|  |  |      clr.l -(sp)
 598:	|  |  |      pea 5 <_start+0x5>
 59c:	|  |  |      pea 58 <_start+0x58>
 5a0:	|  |  |      jsr f0ff60 <_end+0xf099d0>
	}
}
 5a6:	|  |  |      lea 20(sp),sp
 5aa:	|  |  |      addq.l #8,sp
 5ac:	|  |  |      rts
		UaeLib(88, arg1, arg2, arg3, arg4);
 5ae:	|  |  \----> clr.l -(sp)
 5b0:	|  |         clr.l -(sp)
 5b2:	|  |         pea 1 <_start+0x1>
 5b6:	|  |         pea 5 <_start+0x5>
 5ba:	|  |         pea 58 <_start+0x58>
 5be:	|  |         jsr f0ff60 <_end+0xf099d0>
}
 5c4:	|  |         lea 20(sp),sp
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
 5c8:	|  |         move.l dff004 <_end+0xdf8a74>,d0
 5ce:	|  |         move.l d0,(sp)
		vpos&=0x1ff00;
 5d0:	|  |         move.l (sp),d0
 5d2:	|  |         andi.l #130816,d0
 5d8:	|  |         move.l d0,(sp)
		if (vpos!=(311<<8))
 5da:	|  |         move.l (sp),d0
 5dc:	|  |         cmpi.l #79616,d0
 5e2:	\--|-------- beq.w 53c <WaitVbl+0x14>
 5e6:	   \-------- bra.w 558 <WaitVbl+0x30>

000005ea <strlen>:
	while(*s++)
 5ea:	   /-> movea.l 4(sp),a0
 5ee:	   |   tst.b (a0)+
 5f0:	/--|-- beq.s 5fe <strlen+0x14>
 5f2:	|  |   move.l a0,-(sp)
 5f4:	|  \-- jsr 5ea <strlen>(pc)
 5f8:	|      addq.l #4,sp
 5fa:	|      addq.l #1,d0
}
 5fc:	|      rts
	unsigned long t=0;
 5fe:	\----> moveq #0,d0
}
 600:	       rts

00000602 <memset>:
void* memset(void *dest, int val, unsigned long len) {
 602:	                      movem.l d2-d7/a2,-(sp)
 606:	                      move.l 32(sp),d0
 60a:	                      move.l 36(sp),d4
 60e:	                      movea.l 40(sp),a0
	while(len-- > 0)
 612:	                      lea -1(a0),a1
 616:	                      cmpa.w #0,a0
 61a:	               /----- beq.w 6d0 <memset+0xce>
		*ptr++ = val;
 61e:	               |      move.b d4,d7
 620:	               |      move.l d0,d2
 622:	               |      neg.l d2
 624:	               |      moveq #3,d1
 626:	               |      and.l d2,d1
 628:	               |      moveq #5,d3
 62a:	               |      cmp.l a1,d3
 62c:	/--------------|----- bcc.w 76c <memset+0x16a>
 630:	|              |      tst.l d1
 632:	|        /-----|----- beq.w 70a <memset+0x108>
 636:	|        |     |      movea.l d0,a1
 638:	|        |     |      move.b d4,(a1)
	while(len-- > 0)
 63a:	|        |     |      btst #1,d2
 63e:	|        |     |  /-- beq.w 6d6 <memset+0xd4>
		*ptr++ = val;
 642:	|        |     |  |   move.b d4,1(a1)
	while(len-- > 0)
 646:	|        |     |  |   move.l d0,d2
 648:	|        |     |  |   subq.l #1,d2
 64a:	|        |     |  |   moveq #3,d3
 64c:	|        |     |  |   and.l d3,d2
 64e:	|  /-----|-----|--|-- bne.w 738 <memset+0x136>
		*ptr++ = val;
 652:	|  |     |     |  |   lea 3(a1),a2
 656:	|  |     |     |  |   move.b d4,2(a1)
	while(len-- > 0)
 65a:	|  |     |     |  |   lea -4(a0),a1
 65e:	|  |     |     |  |   move.l a0,d3
 660:	|  |     |     |  |   sub.l d1,d3
 662:	|  |     |     |  |   moveq #0,d5
 664:	|  |     |     |  |   move.b d4,d5
 666:	|  |     |     |  |   move.l d5,d6
 668:	|  |     |     |  |   swap d6
 66a:	|  |     |     |  |   clr.w d6
 66c:	|  |     |     |  |   move.l d4,d2
 66e:	|  |     |     |  |   lsl.w #8,d2
 670:	|  |     |     |  |   swap d2
 672:	|  |     |     |  |   clr.w d2
 674:	|  |     |     |  |   lsl.l #8,d5
 676:	|  |     |     |  |   or.l d6,d2
 678:	|  |     |     |  |   or.l d5,d2
 67a:	|  |     |     |  |   move.b d7,d2
 67c:	|  |     |     |  |   movea.l d0,a0
 67e:	|  |     |     |  |   adda.l d1,a0
 680:	|  |     |     |  |   moveq #-4,d1
 682:	|  |     |     |  |   and.l d3,d1
 684:	|  |     |     |  |   add.l a0,d1
		*ptr++ = val;
 686:	|  |  /--|-----|--|-> move.l d2,(a0)+
	while(len-- > 0)
 688:	|  |  |  |     |  |   cmp.l a0,d1
 68a:	|  |  +--|-----|--|-- bne.s 686 <memset+0x84>
 68c:	|  |  |  |     |  |   moveq #3,d1
 68e:	|  |  |  |     |  |   and.l d3,d1
 690:	|  |  |  |     +--|-- beq.s 6d0 <memset+0xce>
 692:	|  |  |  |     |  |   moveq #-4,d1
 694:	|  |  |  |     |  |   and.l d1,d3
 696:	|  |  |  |     |  |   lea (0,a2,d3.l),a0
 69a:	|  |  |  |     |  |   suba.l d3,a1
		*ptr++ = val;
 69c:	|  |  |  |  /--|--|-> move.b d4,(a0)
	while(len-- > 0)
 69e:	|  |  |  |  |  |  |   cmpa.w #0,a1
 6a2:	|  |  |  |  |  +--|-- beq.s 6d0 <memset+0xce>
		*ptr++ = val;
 6a4:	|  |  |  |  |  |  |   move.b d4,1(a0)
	while(len-- > 0)
 6a8:	|  |  |  |  |  |  |   moveq #1,d3
 6aa:	|  |  |  |  |  |  |   cmp.l a1,d3
 6ac:	|  |  |  |  |  +--|-- beq.s 6d0 <memset+0xce>
		*ptr++ = val;
 6ae:	|  |  |  |  |  |  |   move.b d4,2(a0)
	while(len-- > 0)
 6b2:	|  |  |  |  |  |  |   moveq #2,d1
 6b4:	|  |  |  |  |  |  |   cmp.l a1,d1
 6b6:	|  |  |  |  |  +--|-- beq.s 6d0 <memset+0xce>
		*ptr++ = val;
 6b8:	|  |  |  |  |  |  |   move.b d4,3(a0)
	while(len-- > 0)
 6bc:	|  |  |  |  |  |  |   moveq #3,d3
 6be:	|  |  |  |  |  |  |   cmp.l a1,d3
 6c0:	|  |  |  |  |  +--|-- beq.s 6d0 <memset+0xce>
		*ptr++ = val;
 6c2:	|  |  |  |  |  |  |   move.b d4,4(a0)
	while(len-- > 0)
 6c6:	|  |  |  |  |  |  |   moveq #4,d1
 6c8:	|  |  |  |  |  |  |   cmp.l a1,d1
 6ca:	|  |  |  |  |  +--|-- beq.s 6d0 <memset+0xce>
		*ptr++ = val;
 6cc:	|  |  |  |  |  |  |   move.b d4,5(a0)
}
 6d0:	|  |  |  |  |  \--|-> movem.l (sp)+,d2-d7/a2
 6d4:	|  |  |  |  |     |   rts
		*ptr++ = val;
 6d6:	|  |  |  |  |     \-> lea 1(a1),a2
	while(len-- > 0)
 6da:	|  |  |  |  |         lea -2(a0),a1
 6de:	|  |  |  |  |         move.l a0,d3
 6e0:	|  |  |  |  |         sub.l d1,d3
 6e2:	|  |  |  |  |         moveq #0,d5
 6e4:	|  |  |  |  |         move.b d4,d5
 6e6:	|  |  |  |  |         move.l d5,d6
 6e8:	|  |  |  |  |         swap d6
 6ea:	|  |  |  |  |         clr.w d6
 6ec:	|  |  |  |  |         move.l d4,d2
 6ee:	|  |  |  |  |         lsl.w #8,d2
 6f0:	|  |  |  |  |         swap d2
 6f2:	|  |  |  |  |         clr.w d2
 6f4:	|  |  |  |  |         lsl.l #8,d5
 6f6:	|  |  |  |  |         or.l d6,d2
 6f8:	|  |  |  |  |         or.l d5,d2
 6fa:	|  |  |  |  |         move.b d7,d2
 6fc:	|  |  |  |  |         movea.l d0,a0
 6fe:	|  |  |  |  |         adda.l d1,a0
 700:	|  |  |  |  |         moveq #-4,d1
 702:	|  |  |  |  |         and.l d3,d1
 704:	|  |  |  |  |         add.l a0,d1
 706:	|  |  +--|--|-------- bra.w 686 <memset+0x84>
	unsigned char *ptr = (unsigned char *)dest;
 70a:	|  |  |  \--|-------> movea.l d0,a2
 70c:	|  |  |     |         move.l a0,d3
 70e:	|  |  |     |         sub.l d1,d3
 710:	|  |  |     |         moveq #0,d5
 712:	|  |  |     |         move.b d4,d5
 714:	|  |  |     |         move.l d5,d6
 716:	|  |  |     |         swap d6
 718:	|  |  |     |         clr.w d6
 71a:	|  |  |     |         move.l d4,d2
 71c:	|  |  |     |         lsl.w #8,d2
 71e:	|  |  |     |         swap d2
 720:	|  |  |     |         clr.w d2
 722:	|  |  |     |         lsl.l #8,d5
 724:	|  |  |     |         or.l d6,d2
 726:	|  |  |     |         or.l d5,d2
 728:	|  |  |     |         move.b d7,d2
 72a:	|  |  |     |         movea.l d0,a0
 72c:	|  |  |     |         adda.l d1,a0
 72e:	|  |  |     |         moveq #-4,d1
 730:	|  |  |     |         and.l d3,d1
 732:	|  |  |     |         add.l a0,d1
 734:	|  |  +-----|-------- bra.w 686 <memset+0x84>
		*ptr++ = val;
 738:	|  \--|-----|-------> lea 2(a1),a2
	while(len-- > 0)
 73c:	|     |     |         lea -3(a0),a1
 740:	|     |     |         move.l a0,d3
 742:	|     |     |         sub.l d1,d3
 744:	|     |     |         moveq #0,d5
 746:	|     |     |         move.b d4,d5
 748:	|     |     |         move.l d5,d6
 74a:	|     |     |         swap d6
 74c:	|     |     |         clr.w d6
 74e:	|     |     |         move.l d4,d2
 750:	|     |     |         lsl.w #8,d2
 752:	|     |     |         swap d2
 754:	|     |     |         clr.w d2
 756:	|     |     |         lsl.l #8,d5
 758:	|     |     |         or.l d6,d2
 75a:	|     |     |         or.l d5,d2
 75c:	|     |     |         move.b d7,d2
 75e:	|     |     |         movea.l d0,a0
 760:	|     |     |         adda.l d1,a0
 762:	|     |     |         moveq #-4,d1
 764:	|     |     |         and.l d3,d1
 766:	|     |     |         add.l a0,d1
 768:	|     \-----|-------- bra.w 686 <memset+0x84>
	unsigned char *ptr = (unsigned char *)dest;
 76c:	\-----------|-------> movea.l d0,a0
 76e:	            \-------- bra.w 69c <memset+0x9a>

00000772 <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
 772:	             movem.l d2-d5,-(sp)
 776:	             move.l 20(sp),d0
 77a:	             move.l 24(sp),d1
 77e:	             move.l 28(sp),d2
	while(len--)
 782:	             move.l d2,d4
 784:	             subq.l #1,d4
 786:	             tst.l d2
 788:	/----------- beq.s 7e2 <memcpy+0x70>
 78a:	|            moveq #6,d3
 78c:	|            cmp.l d4,d3
 78e:	|  /-------- bcc.s 7e8 <memcpy+0x76>
 790:	|  |         move.l d0,d3
 792:	|  |         or.l d1,d3
 794:	|  |         moveq #3,d5
 796:	|  |         and.l d5,d3
 798:	|  |         movea.l d1,a0
 79a:	|  |         addq.l #1,a0
 79c:	|  |  /----- bne.s 7ec <memcpy+0x7a>
 79e:	|  |  |      movea.l d0,a1
 7a0:	|  |  |      suba.l a0,a1
 7a2:	|  |  |      moveq #2,d3
 7a4:	|  |  |      cmp.l a1,d3
 7a6:	|  |  +----- bcc.s 7ec <memcpy+0x7a>
 7a8:	|  |  |      movea.l d1,a0
 7aa:	|  |  |      movea.l d0,a1
 7ac:	|  |  |      moveq #-4,d3
 7ae:	|  |  |      and.l d2,d3
 7b0:	|  |  |      add.l d1,d3
		*d++ = *s++;
 7b2:	|  |  |  /-> move.l (a0)+,(a1)+
	while(len--)
 7b4:	|  |  |  |   cmp.l a0,d3
 7b6:	|  |  |  \-- bne.s 7b2 <memcpy+0x40>
 7b8:	|  |  |      moveq #-4,d3
 7ba:	|  |  |      and.l d2,d3
 7bc:	|  |  |      movea.l d0,a0
 7be:	|  |  |      adda.l d3,a0
 7c0:	|  |  |      add.l d3,d1
 7c2:	|  |  |      sub.l d3,d4
 7c4:	|  |  |      moveq #3,d5
 7c6:	|  |  |      and.l d5,d2
 7c8:	+--|--|----- beq.s 7e2 <memcpy+0x70>
		*d++ = *s++;
 7ca:	|  |  |      movea.l d1,a1
 7cc:	|  |  |      move.b (a1),(a0)
	while(len--)
 7ce:	|  |  |      tst.l d4
 7d0:	+--|--|----- beq.s 7e2 <memcpy+0x70>
		*d++ = *s++;
 7d2:	|  |  |      move.b 1(a1),1(a0)
	while(len--)
 7d8:	|  |  |      subq.l #1,d4
 7da:	+--|--|----- beq.s 7e2 <memcpy+0x70>
		*d++ = *s++;
 7dc:	|  |  |      move.b 2(a1),2(a0)
}
 7e2:	>--|--|----> movem.l (sp)+,d2-d5
 7e6:	|  |  |      rts
 7e8:	|  \--|----> movea.l d1,a0
 7ea:	|     |      addq.l #1,a0
 7ec:	|     \----> movea.l d0,a1
 7ee:	|            add.l d2,d1
		*d++ = *s++;
 7f0:	|        /-> move.b -1(a0),(a1)+
	while(len--)
 7f4:	|        |   cmpa.l d1,a0
 7f6:	\--------|-- beq.s 7e2 <memcpy+0x70>
 7f8:	         |   addq.l #1,a0
 7fa:	         \-- bra.s 7f0 <memcpy+0x7e>

000007fc <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
 7fc:	             movem.l d2-d4/a2,-(sp)
 800:	             move.l 20(sp),d0
 804:	             move.l 24(sp),d1
 808:	             move.l 28(sp),d2
		while (len--)
 80c:	             movea.l d2,a1
 80e:	             subq.l #1,a1
	if (d < s) {
 810:	             cmp.l d0,d1
 812:	      /----- bls.s 87a <memmove+0x7e>
		while (len--)
 814:	      |      tst.l d2
 816:	/-----|----- beq.s 874 <memmove+0x78>
 818:	|     |      moveq #6,d3
 81a:	|     |      movea.l d1,a0
 81c:	|     |      addq.l #1,a0
 81e:	|     |      cmp.l a1,d3
 820:	|  /--|----- bcc.s 89e <memmove+0xa2>
 822:	|  |  |      move.l d0,d3
 824:	|  |  |      sub.l a0,d3
 826:	|  |  |      moveq #2,d4
 828:	|  |  |      cmp.l d3,d4
 82a:	|  +--|----- bcc.s 89e <memmove+0xa2>
 82c:	|  |  |      move.l d0,d3
 82e:	|  |  |      or.l d1,d3
 830:	|  |  |      moveq #3,d4
 832:	|  |  |      and.l d4,d3
 834:	|  +--|----- bne.s 89e <memmove+0xa2>
 836:	|  |  |      movea.l d1,a0
 838:	|  |  |      movea.l d0,a2
 83a:	|  |  |      moveq #-4,d3
 83c:	|  |  |      and.l d2,d3
 83e:	|  |  |      add.l d1,d3
			*d++ = *s++;
 840:	|  |  |  /-> move.l (a0)+,(a2)+
		while (len--)
 842:	|  |  |  |   cmp.l a0,d3
 844:	|  |  |  \-- bne.s 840 <memmove+0x44>
 846:	|  |  |      moveq #-4,d3
 848:	|  |  |      and.l d2,d3
 84a:	|  |  |      movea.l d0,a2
 84c:	|  |  |      adda.l d3,a2
 84e:	|  |  |      movea.l d1,a0
 850:	|  |  |      adda.l d3,a0
 852:	|  |  |      suba.l d3,a1
 854:	|  |  |      moveq #3,d1
 856:	|  |  |      and.l d1,d2
 858:	+--|--|----- beq.s 874 <memmove+0x78>
			*d++ = *s++;
 85a:	|  |  |      move.b (a0),(a2)
		while (len--)
 85c:	|  |  |      cmpa.w #0,a1
 860:	+--|--|----- beq.s 874 <memmove+0x78>
			*d++ = *s++;
 862:	|  |  |      move.b 1(a0),1(a2)
		while (len--)
 868:	|  |  |      moveq #1,d3
 86a:	|  |  |      cmp.l a1,d3
 86c:	+--|--|----- beq.s 874 <memmove+0x78>
			*d++ = *s++;
 86e:	|  |  |      move.b 2(a0),2(a2)
}
 874:	>--|--|----> movem.l (sp)+,d2-d4/a2
 878:	|  |  |      rts
		const char *lasts = s + (len - 1);
 87a:	|  |  \----> lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
 87e:	|  |         adda.l d0,a1
		while (len--)
 880:	|  |         tst.l d2
 882:	+--|-------- beq.s 874 <memmove+0x78>
 884:	|  |         move.l a0,d1
 886:	|  |         sub.l d2,d1
			*lastd-- = *lasts--;
 888:	|  |     /-> move.b (a0),(a1)
		while (len--)
 88a:	|  |     |   subq.l #1,a0
 88c:	|  |     |   subq.l #1,a1
 88e:	|  |     |   cmp.l a0,d1
 890:	+--|-----|-- beq.s 874 <memmove+0x78>
			*lastd-- = *lasts--;
 892:	|  |     |   move.b (a0),(a1)
		while (len--)
 894:	|  |     |   subq.l #1,a0
 896:	|  |     |   subq.l #1,a1
 898:	|  |     |   cmp.l a0,d1
 89a:	|  |     \-- bne.s 888 <memmove+0x8c>
 89c:	+--|-------- bra.s 874 <memmove+0x78>
 89e:	|  \-------> movea.l d0,a1
 8a0:	|            add.l d2,d1
			*d++ = *s++;
 8a2:	|        /-> move.b -1(a0),(a1)+
		while (len--)
 8a6:	|        |   cmpa.l d1,a0
 8a8:	\--------|-- beq.s 874 <memmove+0x78>
 8aa:	         |   addq.l #1,a0
 8ac:	         \-- bra.s 8a2 <memmove+0xa6>
 8ae:	             nop

000008b0 <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
 8b0:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
 8b4:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
 8b8:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
 8bc:	mulu.w 8(sp),d1
	addw	d1, d0
 8c0:	add.w d1,d0
	swap	d0
 8c2:	swap d0
	clrw	d0
 8c4:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
 8c6:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
 8ca:	mulu.w 10(sp),d1
	addl	d1, d0
 8ce:	add.l d1,d0
	rts
 8d0:	rts

000008d2 <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
 8d2:	       move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
 8d4:	       move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
 8d8:	       move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
 8dc:	       cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
 8e2:	   /-- bcc.s 8fa <__udivsi3+0x28>
	movel	d0, d2
 8e4:	   |   move.l d0,d2
	clrw	d2
 8e6:	   |   clr.w d2
	swap	d2
 8e8:	   |   swap d2
	divu	d1, d2          /* high quotient in lower word */
 8ea:	   |   divu.w d1,d2
	movew	d2, d0		/* save high quotient */
 8ec:	   |   move.w d2,d0
	swap	d0
 8ee:	   |   swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
 8f0:	   |   move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
 8f4:	   |   divu.w d1,d2
	movew	d2, d0
 8f6:	   |   move.w d2,d0
	jra	6f
 8f8:	/--|-- bra.s 92a <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
 8fa:	|  \-> move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
 8fc:	|  /-> lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
 8fe:	|  |   lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
 900:	|  |   cmpi.l #65536,d1
	jcc	4b
 906:	|  \-- bcc.s 8fc <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
 908:	|      divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
 90a:	|      andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
 910:	|      move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
 912:	|      mulu.w d0,d1
	swap	d2
 914:	|      swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
 916:	|      mulu.w d0,d2
	swap	d2		/* align high part with low part */
 918:	|      swap d2
	tstw	d2		/* high part 17 bits? */
 91a:	|      tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
 91c:	|  /-- bne.s 928 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
 91e:	|  |   add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
 920:	|  +-- bcs.s 928 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
 922:	|  |   cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
 926:	+--|-- bls.s 92a <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
 928:	|  \-> subq.l #1,d0

6:	movel	sp@+, d2
 92a:	\----> move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
 92c:	       rts

0000092e <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
 92e:	    move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
 930:	    moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
 932:	    move.l 12(sp),d1
	jpl	1f
 936:	/-- bpl.s 93c <__divsi3+0xe>
	negl	d1
 938:	|   neg.l d1
	negb	d2		/* change sign because divisor <0  */
 93a:	|   neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
 93c:	\-> move.l 8(sp),d0
	jpl	2f
 940:	/-- bpl.s 946 <__divsi3+0x18>
	negl	d0
 942:	|   neg.l d0
	negb	d2
 944:	|   neg.b d2

2:	movel	d1, sp@-
 946:	\-> move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
 948:	    move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
 94a:	    bsr.s 8d2 <__udivsi3>
	addql	#8, sp
 94c:	    addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
 94e:	    tst.b d2
	jpl	3f
 950:	/-- bpl.s 954 <__divsi3+0x26>
	negl	d0
 952:	|   neg.l d0

3:	movel	sp@+, d2
 954:	\-> move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
 956:	    rts

00000958 <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
 958:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
 95c:	move.l 4(sp),d0
	movel	d1, sp@-
 960:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
 962:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
 964:	bsr.s 92e <__divsi3>
	addql	#8, sp
 966:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
 968:	move.l 8(sp),d1
	movel	d1, sp@-
 96c:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
 96e:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
 970:	bsr.w 8b0 <__mulsi3>
	addql	#8, sp
 974:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
 976:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
 97a:	sub.l d0,d1
	movel	d1, d0
 97c:	move.l d1,d0
	rts
 97e:	rts

00000980 <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
 980:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
 984:	move.l 4(sp),d0
	movel	d1, sp@-
 988:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
 98a:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
 98c:	bsr.w 8d2 <__udivsi3>
	addql	#8, sp
 990:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
 992:	move.l 8(sp),d1
	movel	d1, sp@-
 996:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
 998:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
 99a:	bsr.w 8b0 <__mulsi3>
	addql	#8, sp
 99e:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
 9a0:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
 9a4:	sub.l d0,d1
	movel	d1, d0
 9a6:	move.l d1,d0
	rts
 9a8:	rts

000009aa <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
 9aa:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
 9ac:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
 9b0:	jsr -516(a6)
    move.l (sp)+, a6
 9b4:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
 9b6:	rts

000009b8 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
 9b8:	move.b d0,(a3)+
	rts
 9ba:	rts

000009bc <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
 9bc:	                         movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
 9be:	                         adda.l a0,a2
	move.l	a2,a3
 9c0:	                         movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
 9c2:	                         move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
 9c4:	                         moveq #56,d4
	moveq	#8,d5
 9c6:	                         moveq #8,d5
	bra.s	.Lliteral
 9c8:	   /-------------------- bra.s a32 <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
 9ca:	/--|-------------------> move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
 9cc:	|  |                     move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
 9ce:	+--|-------------------- dbf d1,9ca <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
 9d2:	|  |                     lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
 9d4:	|  |     /-------------- bcc.s 9d8 <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
 9d6:	|  |  /--|-------------> move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
 9d8:	|  |  |  >-------------> tst.w d0
 9da:	|  |  |  |           /-- bne.s 9e4 <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
 9dc:	|  |  |  |           |   cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
 9de:	|  |  |  |           |   bls.s a56 <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
 9e0:	|  |  |  |           |   move.w (a0)+,d0
 9e2:	|  |  |  |           |   swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
 9e4:	|  |  |  |           \-> rol.l #6,d0
	move.w	d0,d1
 9e6:	|  |  |  |               move.w d0,d1
	and.w	d4,d1
 9e8:	|  |  |  |               and.w d4,d1
	eor.w	d1,d0
 9ea:	|  |  |  |               eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
 9ec:	|  |  |  |               movem.w (a50 <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
 9f2:	|  |  |  |               rol.l d2,d0
	and.w	d0,d3					|scaling
 9f4:	|  |  |  |               and.w d0,d3
	eor.w	d3,d0
 9f6:	|  |  |  |               eor.w d3,d0
	suba.w	d3,a4
 9f8:	|  |  |  |               suba.w d3,a4
	adda.l	a1,a4
 9fa:	|  |  |  |               adda.l a1,a4

	|Decode the match length
	DOY_REFILL
 9fc:	|  |  |  |               tst.w d0
 9fe:	|  |  |  |           /-- bne.s a04 <_doynaxdepack_asm+0x48>
 a00:	|  |  |  |           |   move.w (a0)+,d0
 a02:	|  |  |  |           |   swap d0
	and.w	d5,d1					|Check the initial length bit from the
 a04:	|  |  |  |           \-> and.w d5,d1
	beq.s	.Lmcopy					|type triple
 a06:	|  |  |  |  /----------- beq.s a1e <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
 a08:	|  |  |  |  |            moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
 a0a:	|  |  |  |  |            tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
 a0c:	|  |  |  |  |  /-------- bpl.s a1a <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
 a0e:	|  |  |  |  |  |         lsl.l #2,d0
	bpl.s	.Lmendlen1
 a10:	|  |  |  |  |  |  /----- bpl.s a18 <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
 a12:	|  |  |  |  |  |  |  /-> addx.b d1,d1
	lsl.l	#2,d0
 a14:	|  |  |  |  |  |  |  |   lsl.l #2,d0
	bmi.s	.Lmgetlen
 a16:	|  |  |  |  |  |  |  \-- bmi.s a12 <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
 a18:	|  |  |  |  |  |  \----> addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
 a1a:	|  |  |  |  |  \-------> lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
 a1c:	|  |  |  |  |        /-- bcc.s a20 <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
 a1e:	|  |  |  |  >--------|-> move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
 a20:	|  |  |  |  |        \-> move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
 a22:	|  |  |  |  \----------- dbf d1,a1e <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
 a26:	|  |  |  |               add.l d0,d0
	bcc.s	.Lmatch
 a28:	|  |  |  \-------------- bcc.s 9d8 <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
 a2a:	|  |  |                  tst.w d0
 a2c:	|  +--|----------------- bne.s a32 <_doynaxdepack_asm+0x76>
 a2e:	|  |  |                  move.w (a0)+,d0
 a30:	|  |  |                  swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
 a32:	|  \--|----------------> moveq #0,d1
	add.l	d0,d0
 a34:	|     |                  add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
 a36:	|     \----------------- bcc.s 9d6 <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
 a38:	|                 /----- bpl.s a40 <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
 a3a:	|                 |  /-> addx.b d1,d1
	lsl.l	#2,d0
 a3c:	|                 |  |   lsl.l #2,d0
	bmi.s	.Llgetlen
 a3e:	|                 |  \-- bmi.s a3a <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
 a40:	|                 \----> addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
 a42:	\--------------------/-X dbv.s d1,9ca <_doynaxdepack_asm+0xe>

	add.l	d0,d0
 a46:	                     |   add.l d0,d0
	eor.w	d1,d0		
 a48:	                     |   eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
 a4a:	                     |   ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
 a4c:	                     |   move.w (a0)+,d1
	bra.s	.Llcopy_near
 a4e:	                     \-- bra.s a42 <_doynaxdepack_asm+0x86>

00000a50 <doy_table>:
 a50:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
 a60:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
 a70:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
 a80:	.............o
