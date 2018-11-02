#include p18f87k22.inc

    global  multiply, high_byte, low_byte, temp_byte_ans1, temp_byte_ans2, temp_byte_ans3, temp_byte_ans4  
    
acs0    udata_acs   ; named variables in access ram
high_byte	res 1
low_byte	res 1
temp_byte_0     res 1  
temp_byte_1     res 1	
   
temp_byte_1a    res 1
temp_byte_2a    res 1   
temp_byte_3a    res 1   
temp_byte_4a    res 1  
   
temp_byte_1b    res 1   
temp_byte_2b    res 1
temp_byte_3b    res 1   
temp_byte_4b    res 1  
   
temp_byte_ans1   res 1   
temp_byte_ans2   res 1   
temp_byte_ans3   res 1   
temp_byte_ans4   res 1   
    
Multiplier    code
    
multiply
;    movlw   0xD2
;    movwf   low_byte
;    
;    movlw   0x04
;    movwf   high_byte
;    
    movlw   0x8A  
    mulwf   low_byte
    movff   PRODL, temp_byte_4a	    ; byte 1
    movff   PRODH, temp_byte_3a	    ; byte 2
    
    movlw   0x8A
    mulwf   high_byte
    movf    PRODL, W
    addwfc  temp_byte_3a	    ; add to byte 2
    movff   PRODH, temp_byte_2a	    ; byte 3
    
    movlw   0x41
    movwf   temp_byte_0
    movf    low_byte, W
    mulwf   temp_byte_0
    movf    PRODL, W
    addwfc  temp_byte_3a	    ; add to byte 2
    movf    PRODH, W
    addwfc  temp_byte_2a	    ; add to byte 3
    
    movlw   0x41
    movwf   temp_byte_0
    movf    high_byte, W
    mulwf   temp_byte_0
    movf    PRODL, W
    addwfc  temp_byte_2a	    ; add to byte 3
    movff   PRODH, temp_byte_1a	    ; byte 4
    movff   temp_byte_1a, temp_byte_ans1

step2
    movlw   0x0A
    mulwf   temp_byte_4a
    movff   PRODL, temp_byte_4b
    movff   PRODH, temp_byte_3b
    
    movlw   0x0A
    mulwf   temp_byte_3a
    movf    PRODL, W
    addwfc  temp_byte_3b
    movff   PRODH, temp_byte_2b
    
    movlw   0x0A
    mulwf   temp_byte_2a
    movf    PRODL, W
    addwfc  temp_byte_2b
    movff   PRODH, temp_byte_1b
    movff   temp_byte_1b, temp_byte_ans2
    
step3
    movlw   0x0A
    mulwf   temp_byte_4b
    movff   PRODL, temp_byte_4a
    movff   PRODH, temp_byte_3a
    
    movlw   0x0A
    mulwf   temp_byte_3b
    movf    PRODL, W
    addwfc  temp_byte_3a
    movff   PRODH, temp_byte_2a
    
    movlw   0x0A
    mulwf   temp_byte_2b
    movf    PRODL, W
    addwfc  temp_byte_2a
    movff   PRODH, temp_byte_1a
    movff   temp_byte_1a, temp_byte_ans3
    
step4
    movlw   0x0A
    mulwf   temp_byte_4a
    movff   PRODL, temp_byte_4b
    movff   PRODH, temp_byte_3b
    
    movlw   0x0A
    mulwf   temp_byte_3a
    movf    PRODL, W
    addwfc  temp_byte_3b
    movff   PRODH, temp_byte_2b
    
    movlw   0x0A
    mulwf   temp_byte_2a
    movf    PRODL, W
    addwfc  temp_byte_2b
    movff   PRODH, temp_byte_1b
    movff   temp_byte_1b, temp_byte_ans4
    
    return
    
end