
	#include p18f87k22.inc
	
	code
	org 0x0
	goto	start
	
	org 0x100		    		; Main code starts here at address 0x100

start
	movlw 	0x0		    ; Move literal (0) to WREG
	movwf	TRISE, ACCESS	    ; Move WREG literal to FREG, assign file register to TRISB. Port C all outputs
	movwf	TRISD, ACCESS	    ; Move WREG literal to FREG, assign file register to TRISB. Port C all outputs
	bra 	test		    ; Branch to test
loop	movff 	0x06, PORTE	    ; Move from FREG address 0x06 to PORTD 
	incf 	0x06, W, ACCESS	
	call	setupglobal
	call	setupglobal
	call	setupglobal
	call	setupglobal
	call	setupglobal
	movff 	0x07, PORTD	    ; Move from FREG address 0x06 to PORTD 
	incf 	0x07, W, ACCESS	
test	movwf	0x06, ACCESS	    ; Test for end of loop condition. Move from WREF to FREG, at address 0x06
	movwf	0x07, ACCESS	    ; Test for end of loop condition. Move from WREF to FREG, at address 0x06
	movlw 	0x63		    ; Move literal (0x63) to WREG
	cpfsgt 	0x06, ACCESS	    ; Compare FREG at address 0x06 with WREG. If greater, skip next line. Else, branch to loop
	bra 	loop		    ; Not yet finished goto start of loop again
	goto 	0x0		    ; Re-run program from start
	
setupglobal	movlw	0xFF	    ; setting global counter
		movwf	0x21, ACCESS
globaldelay	call	delay
		decfsz	0x21, F, ACCESS
		bra	globaldelay
		return
	
delay	movlw	0xFF
	movwf	0x20, ACCESS
dloop	decfsz	0x20, F, ACCESS
	bra	dloop
	return 
	
	end
