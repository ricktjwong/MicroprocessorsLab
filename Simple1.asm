	#include p18f87k22.inc
	
	code
	org 0x0
	goto	start
	
	org 0x100		    ; Main code starts here at address 0x100

start
	movlw 	0x0		    ; Move literal (0) to WREG
	movwf	TRISB, ACCESS	    ; Move WREG literal to FREG, assign file register to TRISB. Port C all outputs
	bra 	test		    ; Branch to test
loop	movff 	0x06, PORTB	    ; Move from FREG address 0x06 to PORTB 
	incf 	0x06, W, ACCESS	
setup	movlw	high(0xDEAD)
	movwf	0x10
	movlw	low(0xDEAD)
	movwf	0x11
	;call	delay
test	movwf	0x06, ACCESS	    ; Test for end of loop condition. Move from WREF to FREG, at address 0x06
	movlw 	0x63		    ; Move literal (0x63) to WREG
	cpfsgt 	0x06, ACCESS	    ; Compare FREG at address 0x06 with WREG. If greater, skip next line. Else, branch to loop
	bra 	loop		    ; Not yet finished goto start of loop again
	goto 	0x0		    ; Re-run program from start
	
delay	movlw	0x00
dloop	decf	0x11, f
	subwfb	0x10, f
	bc	dloop
	return
	end
