#include p18f87k22.inc

    global  multiply
    
acs0    udata_acs   ; named variables in access ram
temp_byte_0   res 1  
   
temp_byte_1a   res 1
temp_byte_2a   res 1   
temp_byte_3a   res 1   
temp_byte_4a   res 1  
   
temp_byte_1b   res 1   
temp_byte_2b   res 1
temp_byte_3b   res 1   
temp_byte_4b   res 1  
   
temp_byte_ans1   res 1   
temp_byte_ans2   res 1   
temp_byte_ans3   res 1   
temp_byte_ans4   res 1   
    
Multiplier    code
    
multiply
    movlw   0xD2
    movwf   temp_byte_0
    movlw   0x8A  
    mulwf   temp_byte_0
    movff   PRODL, 0x34	    ; byte 1
    movff   PRODH, 0x33	    ; byte 2
    
    movlw   0x8A
    movwf   temp_byte_0
    movlw   0x04
    mulwf   temp_byte_0
    movf    PRODL, W
    addwf   0x33	    ; add to byte 2
    movff   PRODH, 0x32	    ; byte 3
    
    movlw   0x41
    movwf   temp_byte_0
    movlw   0xD2
    mulwf   0x30
    movf    PRODL, W
    addwf   0x33	    ; add to byte 2
    movf    PRODH, W
    addwf   0x32	    ; add to byte 3
    
    movlw   0x41
    movwf   temp_byte_0
    movlw   0x04
    mulwf   temp_byte_0
    movf    PRODL, W
    addwf   0x32	    ; add to byte 3
    movff   PRODH, 0x31	    ; byte 4
    movff   0x31, 0x80

step2
    movlw   0x0A
    mulwf   0x34
    movff   PRODL, 0x44
    movff   PRODH, 0x43
    
    movlw   0x0A
    mulwf   0x33
    movf    PRODL, W
    addwf   0x43
    movff   PRODH, 0x42
    
    movlw   0x0A
    mulwf   0x32
    movf    PRODL, W
    addwf   0x42
    movff   PRODH, 0x41
    movff   0x41, 0x81
    
step3
    movlw   0x0A
    mulwf   0x44
    movff   PRODL, 0x34
    movff   PRODH, 0x33
    
    movlw   0x0A
    mulwf   0x43
    movf    PRODL, W
    addwf   0x33
    movff   PRODH, 0x32
    
    movlw   0x0A
    mulwf   0x42
    movf    PRODL, W
    addwf   0x32
    movff   PRODH, 0x31
    movff   0x31, 0x82
    
step4
    movlw   0x0A
    mulwf   0x34
    movff   PRODL, 0x44
    movff   PRODH, 0x43
    
    movlw   0x0A
    mulwf   0x33
    movf    PRODL, W
    addwf   0x43
    movff   PRODH, 0x42
    
    movlw   0x0A
    mulwf   0x32
    movf    PRODL, W
    addwf   0x42
    movff   PRODH, 0x41
    movff   0x41, 0x83
    
    return
    
end