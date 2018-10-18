
	#include p18f87k22.inc
	
	code
	org 0x0
	goto	start
	
	org 0x100		    		; Main code starts here at address 0x100

start
	banksel PADCFG1			; PADCFG1 is not in Access Bank
	bsf	PADCFG1, REPU, BANKED	; PortE pull-ups on	
	movwf	TRISD, ACCESS		; Move WREG literal to FREG, assign file register to TRISD
	movwf	TRISC, ACCESS
	bsf	PORTD, 0	    ; OE    
	bsf	PORTD, 1	    ; Clock bit

	movlw 	0x0		    ; Move literal (0) to WREG
	movwf	TRISE, ACCESS	    ; Move WREG literal to FREG, assign file register to TRISB. Port E all outputs
	movlw	0x05
	movwf	PORTE
	bcf	PORTD, 1	    ; CP1 goes low
	call	delay
	bsf	PORTD, 1	    ; CP1 goes high 
	setf	TRISE		    ; Tri-state PortE: PORTE is being pulled up - means voltage is higher than 0 but smaller than 5V (1 bit)
	bcf	PORTD, 0	    ; Lowers OE1, memory outputs
	movff	PORTE, PORTC 
	goto	0x0	
	
delay	nop			    ; Do nothing for 250ns
	nop
	nop
	nop
	return 
	
	end
