/*Based on following file*/
/* Modified for 1517 by Jonathan Mullen - Aug 2019 */
/*
 * GENERATED FILE - DO NOT EDIT
 * (c) Code Red Technologies Ltd, 2008-13
 * (c) NXP Semiconductors 2013-2014
 * Generated linker script file for LPC1549
 * Created from generic_c.ld (LPCXpresso v7.2 (0 [Build 153] [2014-05-19] ))
 * By LPCXpresso v7.2.0 [Build 153] [2014-05-19]  on Tue Jun 10 00:20:53 JST 2014
 */

GROUP(libgcc.a libc.a libstdc++.a libm.a libcr_newlib_nohost.a crti.o crtn.o crtbegin.o crtend.o)

MEMORY
{
  /* Define each memory region */
  MFlash64 (rx) : ORIGIN = 0x0, LENGTH = 0x10000 /* 64K bytes */
  Ram0_4 (rwx) : ORIGIN = 0x2000000+0x100, LENGTH = 0x1000-0x100 /* 4K bytes */
  Ram1_4 (rwx) : ORIGIN = 0x2001000, LENGTH = 0x1000 /* 4K bytes */
  Ram2_4 (rwx) : ORIGIN = 0x2002000, LENGTH = 0x1000 /* 4K bytes */

}
  /* Define a symbol for the top of each memory region */
  __top_MFlash64 = 0x0 + 0x10000;
  __top_Ram0_4 = 0x2000000 + 0x1000;
  __top_Ram1_4 = 0x2001000 + 0x1000;
  __top_Ram2_4 = 0x2002000 + 0x1000;

ENTRY(ResetISR)

SECTIONS
{

    /* MAIN TEXT SECTION */    
    .text : ALIGN(4)
    {
        FILL(0xff)
        KEEP(*(.isr_vector))
        
        /* Global Section Table */
        . = ALIGN(4) ;
        __section_table_start = .;
        __data_section_table = .;
        LONG(LOADADDR(.data));
        LONG(    ADDR(.data));
        LONG(  SIZEOF(.data));
        LONG(LOADADDR(.data_RAM2));
        LONG(    ADDR(.data_RAM2));
        LONG(  SIZEOF(.data_RAM2));
        LONG(LOADADDR(.data_RAM3));
        LONG(    ADDR(.data_RAM3));
        LONG(  SIZEOF(.data_RAM3));
        __data_section_table_end = .;
        __bss_section_table = .;
        LONG(    ADDR(.bss));
        LONG(  SIZEOF(.bss));
        LONG(    ADDR(.bss_RAM2));
        LONG(  SIZEOF(.bss_RAM2));
        LONG(    ADDR(.bss_RAM3));
        LONG(  SIZEOF(.bss_RAM3));
        __bss_section_table_end = .;
        __section_table_end = . ;
        /* End of Global Section Table */
        

        *(.after_vectors*)
        
        *(.text*)
        *(.rodata .rodata.*)
        . = ALIGN(4);
        
        /* C++ constructors etc */
        . = ALIGN(4);
        KEEP(*(.init))
        
        . = ALIGN(4);
        __preinit_array_start = .;
        KEEP (*(.preinit_array))
        __preinit_array_end = .;
        
        . = ALIGN(4);
        __init_array_start = .;
        KEEP (*(SORT(.init_array.*)))
        KEEP (*(.init_array))
        __init_array_end = .;
        
        KEEP(*(.fini));
        
        . = ALIGN(0x4);
        KEEP (*crtbegin.o(.ctors))
        KEEP (*(EXCLUDE_FILE (*crtend.o) .ctors))
        KEEP (*(SORT(.ctors.*)))
        KEEP (*crtend.o(.ctors))
        
        . = ALIGN(0x4);
        KEEP (*crtbegin.o(.dtors))
        KEEP (*(EXCLUDE_FILE (*crtend.o) .dtors))
        KEEP (*(SORT(.dtors.*)))
        KEEP (*crtend.o(.dtors))
    } > MFlash64

    /*
     * for exception handling/unwind - some Newlib functions (in common
     * with C++ and STDC++) use this. 
     */
    .ARM.extab : ALIGN(4)
    {
    	*(.ARM.extab* .gnu.linkonce.armextab.*)
    } > MFlash64
    __exidx_start = .;
    
    .ARM.exidx : ALIGN(4)
    {
    	*(.ARM.exidx* .gnu.linkonce.armexidx.*)
    } > MFlash64
    __exidx_end = .;
    
    _etext = .;
            
    /* DATA section for Ram1_4 */
    .data_RAM2 : ALIGN(4)
    {
       FILL(0xff)
       *(.ramfunc.$RAM2)
       *(.ramfunc.$Ram1_4)
    	*(.data.$RAM2*)
    	*(.data.$Ram1_4*)
       . = ALIGN(4) ;
    } > Ram1_4 AT>MFlash64
    
    /* DATA section for Ram2_4 */
    .data_RAM3 : ALIGN(4)
    {
       FILL(0xff)
       *(.ramfunc.$RAM3)
       *(.ramfunc.$Ram2_4)
    	*(.data.$RAM3*)
    	*(.data.$Ram2_4*)
       . = ALIGN(4) ;
    } > Ram2_4 AT>MFlash64
    
    /* MAIN DATA SECTION */ 
    .uninit_RESERVED : ALIGN(4)
    {
        KEEP(*(.bss.$RESERVED*))
        . = ALIGN(4) ;
        _end_uninit_RESERVED = .;
    } > Ram0_4
	
	/* Main DATA section (Ram0_4) */
	.data : ALIGN(4)
	{
	   FILL(0xff)
	   _data = . ;
	   *(vtable)
	   *(.ramfunc*)
	   *(.data*)
	   . = ALIGN(4) ;
	   _edata = . ;
	} > Ram0_4 AT>MFlash64

    /* BSS section for Ram1_4 */
    .bss_RAM2 : ALIGN(4)
    {
    	*(.bss.$RAM2*)
    	*(.bss.$Ram1_4*)
       . = ALIGN(4) ;
    } > Ram1_4
    /* BSS section for Ram2_4 */
    .bss_RAM3 : ALIGN(4)
    {
    	*(.bss.$RAM3*)
    	*(.bss.$Ram2_4*)
       . = ALIGN(4) ;
    } > Ram2_4

    /* MAIN BSS SECTION */
    .bss : ALIGN(4)
    {
        _bss = .;
        *(.bss*)
        *(COMMON)
        . = ALIGN(4) ;
        _ebss = .;
        PROVIDE(end = .);
        __end__ = .;
    } > Ram0_4
        
    /* NOINIT section for Ram1_4 */
    .noinit_RAM2 (NOLOAD) : ALIGN(4)
    {
    	*(.noinit.$RAM2*)
    	*(.noinit.$Ram1_4*)
       . = ALIGN(4) ;
    } > Ram1_4 
    /* NOINIT section for Ram2_4 */
    .noinit_RAM3 (NOLOAD) : ALIGN(4)
    {
    	*(.noinit.$RAM3*)
    	*(.noinit.$Ram2_4*)
       . = ALIGN(4) ;
    } > Ram2_4 
    
    /* DEFAULT NOINIT SECTION */
    .noinit (NOLOAD): ALIGN(4)
    {
        _noinit = .;
        *(.noinit*) 
         . = ALIGN(4) ;
        _end_noinit = .;
    } > Ram0_4
    
    PROVIDE(_pvHeapStart = .);
    PROVIDE(_vStackTop = __top_Ram0_4 - 0);
}
