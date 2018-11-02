	#include p18f87k22.inc
	
	code
	org 0x0
	goto	start
	
	org 0x100		    		; Main code starts here at address 0x100

start
	clrf	LATC
	clrf	LATD
	movlw 	0x0				; Move literal (0) to WREG
	movwf	TRISD, ACCESS			; Move WREG literal to FREG, assign file register to TRISB. Port C all outputs
	movlw 	0x0				; Move literal (0) to WREG
	movwf	TRISC, ACCESS			; Move WREG literal to FREG, assign file register to TRISB. Port C all outputs
	
	bra 	test				; Branch to test
	
loop	movff 	0x06, PORTD			; Move from FREG address 0x06 to PORTB 	
	
	bcf	PORTC, 0
	call	setupglobal
	bsf	PORTC, 0
	call	setupglobal
	bcf	PORTC, 0
	
	incf 	0x06, W, ACCESS
test	movwf	0x06, ACCESS	; Test for end of loop condition. Move from WREF to FREG, at address 0x06
	movlw 	0xFF				; Move literal (0x63) to WREG
	cpfsgt 	0x06, ACCESS		; Compare FREG at address 0x06 with WREG. If greater, skip next line. Else, branch to loop
	bra 	loop		    	; Not yet finished goto start of loop again
	
	goto	0x0
	
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