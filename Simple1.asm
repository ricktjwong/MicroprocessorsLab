
	#include p18f87k22.inc
	
	code
	org 0x0
	goto	start
	
	org 0x100		    		; Main code starts here at address 0x100

start
	movlw 	0xfc		    ; Move literal (0) to WREG
	movwf	TRISD, ACCESS	    ; Move WREG literal to FREG, assign file register to TRISB. Port C all outputs
	movlw	0x03
	movwf	0x06		    ; set 3 into 0x06 for OE1
	movff	0x06, PORTD
	movlw 	0x0		    ; Move literal (0) to WREG
	movwf	TRISE, ACCESS	    ; Move WREG literal to FREG, assign file register to TRISB. Port C all outputs
 	clrf	TRISE
	movlw	0x05
	movwf	0x07
	movff	0x07, PORTE
	call	delay
	banksel PADCFG1 ; PADCFG1 is not in Access Bank!!
	bsf	PADCFG1, REPU, BANKED ; PortE pull-ups on
	movlb	0x00 ; set BSR back to Bank 0
	setf	TRISE ; Tri-state PortE
	movlw	0x00
	movwf	0x07
	movff	0x07, PORTD	    ; Lowers OE1, memory outputs
	goto	0x0

delay	nop			    ; Do nothing for 250ns
	nop
	nop
	nop
	movlw	0x02		    ; Only lower CP1
	movwf	0x06		    ; set 3 into 0x06 for OE1
	movff	0x06, PORTD
	return 
	
	end
