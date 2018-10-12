	#include p18f87k22.inc
	
	code
	org 0x0
	goto	start
	
	org 0x100		    ; Main code starts here at address 0x100

start
	movlw 	0x0
	movwf	TRISB, ACCESS	    ; Port C all outputs
	bra 	test
loop	movff 	0x06, PORTB
	call	setupglobal
	call	setupglobal
	incf 	0x06, W, ACCESS
test	movwf	0x06, ACCESS	    ; Test for end of loop condition
	movlw 	0x63
	cpfsgt 	0x06, ACCESS
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
dloop	nop
	nop
	nop
	decfsz	0x20, F, ACCESS
	bra	dloop
	return 
	
	end