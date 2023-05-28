#include <xtensa/coreasm.h>
#include <xtensa/corebits.h>
#include <xtensa/config/system.h>
#include <xtensa/hal.h>
#include <xtensa/config/specreg.h>


.data
_l5_intr_stack:
.space      60

    .section .iram1,"ax" 
	.literal_position
	.literal .LC0, la_hi_interrupt_state
	.align	4
	.global	xt_highint5
	.type	xt_highint5, @function

xt_highint5:
//
    movi    a0,     _l5_intr_stack
    s32i    a8,     a0,     0    
    s32i    a9,     a0,     4 
    s32i    a10,    a0,     8
//	s32i    a11,    a0,     12   

//  start of replacement block
	
	l32r	a8, .LC0
	l32i.n	a9, a8, 44
	l32i.n	a10, a8, 48
	memw
	s32i.n	a10, a9, 0

	l32i.n	a9, a8, 4
	l32i.n	a10, a8, 8
	memw
	s32i.n	a10, a9, 0

	l32i.n	a9, a8, 28
	l32i.n	a8, a8, 40
	memw
	s32i.n	a8, a9, 0

//	end of replacement block

    movi    a0,     _l5_intr_stack
    l32i    a8,     a0,     0
    l32i    a9,     a0,     4
    l32i    a10,    a0,     8
//	l32i    a11,    a0,     12
//
	rsr.excsave5 a0
    rfi     5

.global la_include_hi_interrupt
la_include_hi_interrupt:

