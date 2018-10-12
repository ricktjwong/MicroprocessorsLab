	#include p18f87k22.inc
	
	code
	org 0x0
	goto	start
	
	org 0x100		    		; Main code starts here at address 0x100

start
	movlw 	0x00				; Move literal (0) to WREG
	movwf	TRISE, ACCESS			; Move WREG literal to FREG, assign file register to TRISE. Port E all outputs
	movlw	0xA0
	movwf	0x09
	movff	0x09, PORTE
	end
