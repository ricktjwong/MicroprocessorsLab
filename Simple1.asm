    #include p18f87k22.inc

    code
    org 0x0
    goto    start

    org 0x100		    		; Main code starts here at address 0x100

start	
    banksel	PADCFG1			; PADCFG1 is not in Access Bank
    bsf		PADCFG1, REPU, BANKED	; PortE pull-ups on	
    clrf	LATE			; Clear latch
    movlw	0x0F			; 00001111 - 0 sets outputs, 1 as inputs
    movwf	TRISE, ACCESS
    

	
    end