	AREA	LIBRARY, CODE, READWRITE
	EXPORT read_character
	EXPORT output_character
	EXPORT read_string
	EXPORT output_string
	EXPORT uart_init
	EXPORT pin_connect_block_setup_for_uart0
	EXPORT pin_connect_block_setup_for_LEDS
	EXPORT pin_connect_block_setup_for_Buttons
	EXPORT invalidInput
	EXPORT Illuminate_RGB_LED
	EXPORT display_digit_on_7_seg
	EXPORT interrupt_init 
	EXPORT IO0CLR
	EXPORT board
	EXPORT random_position
	EXPORT random_dir
	EXPORT move_up
	EXPORT move_down
	EXPORT move_left
	EXPORT move_right
		
	IMPORT current_dir
	IMPORT current_char
	IMPORT current_pose
	IMPORT point
	
		
	EXPORT initial_player
	EXPORT Period_SET
	EXPORT illuminateLiveLEDs
	EXPORT new_board
	EXPORT air_pump
	EXPORT air_pump_clear
	EXPORT update_time
	EXPORT lose_life
	EXPORT initial_enemy
		
	IMPORT player_pose					
	IMPORT enemy_num
	IMPORT player_lives
	IMPORT new_level_flag
	IMPORT game_over
	IMPORT level
	IMPORT slow_enemy_flag
	IMPORT start_state
	IMPORT pause_state
	IMPORT time_value
	IMPORT restart

	IMPORT enemy_position_generator
		
	EXPORT enemyB_live 
    EXPORT enemyX1_live 
    EXPORT enemyX2_live  		
    EXPORT enemy_type
	EXPORT enemy_dir 
	EXPORT enemyX1_pos
	EXPORT enemyX2_pos
	EXPORT enemyB_pos 	
    EXPORT enemyX1_dir 
	EXPORT enemyX2_dir 
	EXPORT enemyB_dir 
    EXPORT enemyX1_type 
	EXPORT enemyX2_type  
	EXPORT enemyB_type  	
	EXPORT enemy_Identity
	EXPORT enemyB_curPos
	EXPORT enemyX1_curPos
	EXPORT enemyX2_curPos
	EXPORT enemyMove_flag
	
	EXPORT T1TC
	EXPORT div_and_mod			

U0LSR EQU 0x14			; UART0 Line Status Register
UART0 EQU 0xE000C000
PINSEL0 EQU 0xE002C000       ; Pin Connect Block
PINSEL1 EQU 0xE002C004      
IO0DIR EQU 0xE0028008       ; GPIO Direction Register
IO1DIR EQU 0xE0028018  
IO0SET EQU 0xE0028004       ; GPIO Output Set Register
IO1SET EQU 0xE0028014
IO0CLR EQU 0xE002800C       ; GPIO Output Clear Register
IO1CLR EQU 0xE002801C
IO0PIN EQU 0xE0028000       ; GPIO Port Pin Value Register
IO1PIN EQU 0xE0028010
U0IER EQU 0xE000C004        ; UART0 Interrupt Enable Register
T0TCR EQU 0xE0004004        ; Timer0 Control Register
T0TC EQU 0xE0004008         ; Timer0 Counter Register
T0MCR EQU 0xE0004014        ; Timer0 Match Control Register
T0MR0 EQU 0xE0004018        ; Timer0 Match Register 0
T1TCR EQU 0xE0008004        ; Timer1 Control Register
T1TC EQU 0xE0008008         ; Timer1 Counter Register
T1MCR EQU 0xE0008014        ; Timer1 Match Control Register
T1MR0 EQU 0xE0008018        ; Timer1 Match Register 0
	
CENTER EQU 241


exceedRange = 13, "\nThe number you entered is out of range. Please enter again.", 0
invalidInput = 13, 10, "Invalid input. Try again!", 0
;board = 12, "          Time: 00:00", 13, 10, "         Point: 00000", 13, 10, "ZZZZZZZZZZZZZZZZZZZZZ", 13, 10, "Z                   Z", 13, 10, "Z                   Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z############### x #Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z######## B ########Z", 13, 10, "Z###################Z", 13, 10, "Z########### x #####Z", 13, 10, "ZZZZZZZZZZZZZZZZZZZZZ", 0
board = 12, "          Time: 00:00", 13, 10, "         Point: 00000", 13, 10, "ZZZZZZZZZZZZZZZZZZZZZ", 13, 10, "Z                   Z", 13, 10, "Z                   Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "Z###################Z", 13, 10, "ZZZZZZZZZZZZZZZZZZZZZ", 0
	ALIGN
end_instruction = 13, 10, "Game is over. Restart the game please hit enter. To quit just hit 'q'. ", 0
	ALIGN
enemyB_live = "  ", 0
	ALIGN
	  
enemyX1_live = "  ", 0
	ALIGN
	  
enemyX2_live = "  ", 0	
	ALIGN
	  
enemy_type = "  ", 0
    ALIGN
		
enemy_position	= "  ", 0
	ALIGN
		
enemy_dir = "  ", 0
	ALIGN 

enemyB_curPos = "  ", 0
	ALIGN
		
enemyX1_curPos = "  ", 0
	ALIGN

enemyX2_curPos = "  ", 0
	ALIGN
					
enemyX1_pos = "  ", 0
	ALIGN	
		
enemyX2_pos = "  ", 0
	ALIGN
		
enemyB_pos = "  ", 0
	ALIGN	

enemyX1_type = " ", 0
	ALIGN	
		 
enemyX2_type = " ", 0
	ALIGN	
		 
enemyB_type = " ", 0
	ALIGN	
		 
enemyX1_dir = "  ", 0
	ALIGN	
		
enemyX2_dir = "  ", 0
	ALIGN
		
enemyB_dir = "  ", 0
	ALIGN	

enemy_Identity = "  ", 0
	ALIGN
		
enemyMove_flag = "  ", 0
	ALIGN
		
Period_SET
		DCD 0x008CA000  ; 0.5 sec      ; NOT USED
		DCD 0x008CA000  ; 0.5 sec      ; level 1 period
		DCD 0x00708000  ; 0.4 sec      ; level 2 period
		DCD 0x00546000  ; 0.3 sec	   ; level 3 period
		DCD 0x00384000  ; 0.2 sec      ; level 4 period
		DCD 0x001C2000  ; 0.1 sec      ; level 5 period
	ALIGN
		
LIVE_SET
		DCD 0x00000000  ; 0
		DCD 0x00080000  ; 1
		DCD 0x000C0000  ; 3
		DCD 0x000E0000  ; 7
		DCD 0x000F0000  ; F
	ALIGN
		
LED_SET	
		DCD 0x00000000  ; 0
 		DCD 0x00080000  ; 1
		DCD 0x00040000  ; 2
		DCD 0x000C0000  ; 3
		DCD 0x00020000  ; 4
		DCD 0x000A0000  ; 5
		DCD 0x00060000  ; 6
		DCD 0x000E0000  ; 7
		DCD 0x00010000  ; 8
		DCD 0x00090000  ; 9
		DCD 0x00050000  ; A
		DCD 0x000D0000  ; B
		DCD 0x00030000  ; C
		DCD 0x000B0000  ; D
		DCD 0x00070000  ; E
		DCD 0x000F0000  ; F
	ALIGN

digits_SET	
		DCD 0x00001F80  ; 0
 		DCD 0x00000300  ; 1 
		DCD 0x00002D80  ; 2
        DCD 0x00002780  ; 3
        DCD 0X00003300  ; 4		 
		DCD 0x00003680  ; 5
		DCD 0x00003E80  ; 6
		DCD 0x00000380  ; 7
		DCD 0x00003F80  ; 8
		DCD 0x00003780  ; 9
		DCD 0x00003B80  ; A
		DCD 0X00003E00  ; b
		DCD 0X00001C80  ; C
		DCD 0X00002F00  ; d
		DCD 0X00003C80  ; E
		DCD 0x00003880  ; F
		DCD 0x00002000	; g-segment
	ALIGN		

RGB_SET
		DCD 0x00000000  ; Turn off
		DCD 0x00020000  ; RED
		DCD 0x00040000  ; Blue
		DCD 0x00200000  ; Green
		DCD 0x00060000  ; PURPLE
		DCD 0x00220000  ; Yellow
		DCD 0x00260000  ; White
	ALIGN
	
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         Air_Pump
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
air_pump
	STMFD sp!, {r0-r4, lr}
	
	ldr r4, =board
	
	ldr r3, =current_pose
	ldr r0, [r3]
	
	ldr r3, =current_dir
	ldr r1, [r3]
	
	cmp r1, #0
	beq shot_up
	cmp r1, #1
	beq shot_down
	cmp r1, #2
	beq shot_right

shot_left
	mov r1, #45                 ; -, 45
	sub r0, r0, #1
	ldrb r2, [r4, r0]
	cmp r2, #90                 ; Z, 90
	beq done_air_pump
	cmp r2, #35                 ; #, 35
	beq done_air_pump
	cmp r2, #66                 ; B, 66
	beq kill_enemy
	cmp r2, #120                ; x, 120
	beq kill_enemy
	
	strb r1, [r4, r0]
	b shot_left

shot_up
	mov r1, #124                ; |, 124
	sub r0, r0, #23
	ldrb r2, [r4, r0]	
	cmp r2, #90                 ; Z, 90
	beq done_air_pump
	cmp r2, #35                 ; #, 35
	beq done_air_pump
	cmp r2, #66                 ; B, 66
	beq kill_enemy
	cmp r2, #120                ; x, 120
	beq kill_enemy
	
	strb r1, [r4, r0]
	b shot_up
	
shot_down
	mov r1, #124                ; |, 124
	add r0, r0, #23
	ldrb r2, [r4, r0]
	cmp r2, #90                 ; Z, 90
	beq done_air_pump
	cmp r2, #35                 ; #, 35
	beq done_air_pump
	cmp r2, #66                 ; B, 66
	beq kill_enemy
	cmp r2, #120                ; x, 120
	beq kill_enemy
	
	strb r1, [r4, r0]
	b shot_down

shot_right
	mov r1, #45                 ; -, 45
	add r0, r0, #1
	ldrb r2, [r4, r0]
	cmp r2, #90                 ; Z, 90
	beq done_air_pump
	cmp r2, #35                 ; #, 35
	beq done_air_pump			 
ss	cmp r2, #66                 ; B, 66
	beq kill_enemy
	cmp r2, #120                ; x, 120
	beq kill_enemy
	
	strb r1, [r4, r0]
	b shot_right

kill_enemy
	bl add_point
	
	mov r2, #0                   ; 0 died

	ldr r4, =enemyB_live
	ldr r1, [r4]
	cmp r1, #0
	beq kill_enemyX1

    ldr r5, =enemyB_curPos
	ldr r1, [r5]
	cmp r0, r1
	bne	kill_enemyX1
	
	ldr r4, =enemyB_live
	str r2, [r4]
	b done_air_pump
	
kill_enemyX1
	ldr r4, =enemyX1_live
	ldr r1, [r4]
	cmp r1, #0
	beq kill_enemyX2
		
    ldr r5, =enemyX1_curPos
	ldr r1, [r5]
	cmp r0, r1
	bne kill_enemyX2

	ldr r4, =enemyX1_live
	str r2, [r4]
	b done_air_pump
		
kill_enemyX2
	ldr r5, =enemyX2_curPos
	ldr r1, [r5]
	cmp r1, #0
	beq done_air_pump

	ldr r4, =enemyX2_live
	str r2, [r4]

done_air_pump
    ldr r4, =board
	bl output_string

	LDMFD sp!, {r0-r4, lr}
	BX lr
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         Air_Pump
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
air_pump_clear
	STMFD sp!, {r0-r4, lr}
	
	ldr r4, =board
	
	ldr r3, =current_pose
	ldr r0, [r3]
	
	ldr r3, =current_dir
	ldr r1, [r3]
	
	mov r2, #32                 ; Space, 32
	
	cmp r1, #0
	beq clear_up
	cmp r1, #1
	beq clear_down
	cmp r1, #2
	beq clear_right

clear_left
	sub r0, r0, #1
	ldrb r1, [r4, r0]
	cmp r1, #90                 ; Z, 90
	beq done_air_pump_clear
	cmp r1, #35                 ; #, 35
	beq done_air_pump_clear
	cmp r1, #66                 ; B, 66
	beq clear_enemy
	cmp r1, #120                ; x, 120
	beq clear_enemy
	
	strb r2, [r4, r0]
	b clear_left

clear_up
	sub r0, r0, #23
	ldrb r1, [r4, r0]
	cmp r1, #90                 ; Z, 90
	beq done_air_pump_clear
	cmp r1, #35                 ; #, 35
	beq done_air_pump_clear
	cmp r1, #66                 ; B, 66
	beq clear_enemy
	cmp r1, #120                ; x, 120
	beq clear_enemy
	
	strb r2, [r4, r0]
	b clear_up
	
clear_down
	add r0, r0, #23
	ldrb r1, [r4, r0]
	cmp r1, #90                 ; Z, 90
	beq done_air_pump_clear
	cmp r1, #35                 ; #, 35
	beq done_air_pump_clear
	cmp r1, #66                 ; B, 66
	beq clear_enemy
	cmp r1, #120                ; x, 120
	beq clear_enemy
	
	strb r2, [r4, r0]
	b clear_down
	
clear_right
	add r0, r0, #1
	ldrb r1, [r4, r0]
	cmp r1, #90                 ; Z, 90
	beq done_air_pump_clear
	cmp r1, #35                 ; #, 35
	beq done_air_pump_clear
	cmp r1, #66                 ; B, 66
	beq clear_enemy
	cmp r1, #120                ; x, 120
	beq clear_enemy
	
	strb r2, [r4, r0]
	b clear_right

clear_enemy
	strb r2, [r4, r0]           ; Move Space to Enemy Position 
	
	ldr r3, =enemy_num
	ldr r0, [r3]
	sub r0, r0, #1
	str r0, [r3]
	cmp r0, #0
	bne done_air_pump_clear
	
	bl new_level
	
done_air_pump_clear	
	LDMFD sp!, {r0-r4, lr}
	BX lr
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         new_board
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
new_board
	STMFD sp!, {r0-r4, lr}

	ldr r4, =board            	; board address
	mov r0, #71             	; Address Indice, First SPACE address is 71
	mov r1, #1                  ; Row counter
	mov r2, #1                 	; Column counter
	mov r3, #32	                ; Dirt Char SPACE

add_col_space              
	strb r3, [r4, r0]
	add r0, r0, #1              ; Increase address Indice by 1
	add r2, r2, #1              ; Increase Column counter by 1
	cmp r2, #20
	bne add_col_space
	
	add r0, r0, #4              ; Move to new row 
	mov r2, #1                  ; Reset Column counter to 1
	add r1, r1, #1              ; Increare Row counter by 1
	cmp r1, #3
	blt add_col_space

	mov r0, #117             	; Address Indice, First # address is 117
	mov r1, #1                  ; Row counter
	mov r2, #1                 	; Column counter
	mov r3, #35	                ; Dirt Char #

add_col
	strb r3, [r4, r0]
	add r0, r0, #1              ; Increase address Indice by 1
	add r2, r2, #1              ; Increase Column counter by 1
	cmp r2, #20
	bne add_col
	
	add r0, r0, #4              ; Move to new row 
	mov r2, #1                  ; Reset Column counter to 1
	add r1, r1, #1              ; Increare Row counter by 1
	cmp r1, #14
	blt add_col
	
	LDMFD sp!, {r0-r4, lr}
	BX lr
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         new_level
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
new_level
	STMFD sp!, {r0-r4, lr}
	
	ldr r4, =new_level_flag
	mov r0, #1
	str r0, [r4]
	bl add_point
	
	ldr r4, =level
	ldr r0, [r4]
	add r0, r0, #1
	str r0, [r4]
	
	bl display_digit_on_7_seg
	
	ldr r4, =slow_enemy_flag
	mov r0, #0
	str r0, [r4]
	
	bl new_board
	bl initial_player
	bl initial_enemy
	
	ldr r4, =board
	bl output_string
	
	LDMFD sp!, {r0-r4, lr}
	BX lr
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;             end_game		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
end_game
	STMFD sp!, {r0-r4, lr}
	
	; Set game_over to 1
	mov r0, #1
	ldr r4, =game_over
	str r0, [r4]

	; Set start_state to 0
	mov r0, #0
	ldr r4, =start_state
	str r0, [r4]
	
	; Update point
	bl add_point
	
	ldr r4, =board
	bl output_string
	
	bl new_board

	; Remove point
	ldr r4, =board
	mov r1, #48
	mov r0, #40             ; point indice is 40
remove_point
	strb r1, [r4, r0]
	add r0, r0, #1
	cmp r0, #44
	ble	remove_point

	; Remove time
	mov r0, #18
	strb r1, [r4, r0]
	mov r0, #20
	strb r1, [r4, r0]
	mov r0, #21 
	strb r1, [r4, r0]

	ldr r4, =end_instruction
	bl output_string
	
	; Display RGB_LED to PURPLE
	mov r0, #52
	bl Illuminate_RGB_LED
	
	LDMFD sp!, {r0-r4, lr}
	BX lr
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;           Update_Time
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
update_time
	STMFD sp!, {r0-r4, lr}
	ldr r4, =board
	
	ldr r3, =time_value
	ldr r0, [r3]
	add r0, r0, #1
	str r0, [r3]
	
	cmp r0, #120
	bne update_mins
	mov r1, #50         ; 2: 50
	strb r1, [r4, #18]
	
	mov r1, #48         ; 0: 48
	strb r1, [r4, #20]
	strb r1, [r4, #21]

	ldr r4, =board
	bl output_string

	bl end_game          ; Time is 2 mins, then gamve over
	b finish_time_update

update_mins
	cmp r0, #60          
	blt update_second
	mov r1, #49         ; 1: 49
	strb r1, [r4, #18]
	
	sub r0, r0, #60
	cmp r0, #0
	beq done_time_update
	
update_second
	mov r1, #10
	bl div_and_mod
	add r0, r0, #48     ; Update tenth_second
	strb r0, [r4, #20]
	add r1, r1, #48     ; Update single_second
	strb r1, [r4, #21]
	
done_time_update
	ldr r4, =board
	bl output_string

finish_time_update
	LDMFD sp!, {r0-r4, lr}
	BX lr


;***********************************
;           Lose Life
;***********************************
lose_life
	STMFD sp!, {r0-r4, lr}
	
	ldr r4, =player_lives
	ldr r0, [r4]
	sub r0, r0, #1
	str r0, [r4]
	mov r1, r0                  ; Temporary store value of player lives
	bl illuminateLiveLEDs
	
	cmp r1, #0                  ; If player lives is 0, then game over.
	bne refresh_board
	
	bl end_game
	b done_lose_life

refresh_board
	
	ldr r4, =board
	mov r5, #32                 ; Space
	ldr r3, =current_pose
	ldr r0, [r3]
	strb r5, [r4, r0]          ; Clear player on the board 
	
	; Re-initial player on the board
	bl initial_player
	
	mov r0, #1
	ldr r4, =enemyMove_flag    ; Set enemyMove flag to 1, 1 is not able to move
	str r0, [r4]
	
	ldr r4, =board
	mov r5, #32                 ; Space
	; resume alive enemy on the original position
	ldr r3, =enemyB_live
    ldr r0, [r3] 
    cmp r0, #0                ; to check whether the enemy B is alive
    beq is_enemyX1_alive
	
	ldr r3, =enemyB_curPos    ; get current enemyB address
	ldr r1, [r3]
	strb r5, [r4, r1]         ; place space to enemyB killed
   
	ldr r3, =enemyB_type
    ldr r0, [r3]	
    ldr r3, =enemyB_pos       ; get enemyB address
	ldr r1, [r3]
	ldr r3, =enemyB_curPos
	str r1, [r3]
	strb r0, [r4, r1]         ; place B to original place initiliazed	
	
is_enemyX1_alive	
    ldr r3, =enemyX1_live
    ldr r0, [r3]
    cmp r0, #0                ; to check whether the enemy x1 is alive
	beq is_enemyX2_alive   

	ldr r3, =enemyX1_curPos   ; get current enemyX1 address
	ldr r1, [r3]
	strb r5, [r4, r1]         ;place space to enemyX1 killed

	ldr r3, =enemyX1_type
    ldr r0, [r3]	
    ldr r3, =enemyX1_pos      ; get enemyx1 address
	ldr r1, [r3]
	ldr r3, =enemyX1_curPos
	str r1, [r3]
	strb r0, [r4, r1]         ; place x1 to original place initiliazed 	
 
is_enemyX2_alive		
	ldr r3, =enemyX2_live
    ldr r0, [r3]
    cmp r0, #0                ; to check whether the enemy x2 is alive
	beq done_lose_life
	
	ldr r3, =enemyX2_curPos   ; get current enemyX2 address
	ldr r1, [r3]
	strb r5, [r4, r1]         ; place space to enemX2 killed
	
	ldr r3, =enemyX2_type
    ldr r0, [r3]	
    ldr r3, =enemyX2_pos      ; get enemyX2 address
	ldr r1, [r3]
	ldr r3, =enemyX2_curPos
	str r1, [r3]
	strb r0, [r4, r1]         ; place x2 to original place initiliazed
	
done_lose_life
	LDMFD sp!, {r0-r4, lr}
	BX lr

;***********************************
;           Add Point
;          Input = r2
;        Dirt (#) = 10 points
;    Normal Enemy (x) = 50 points
;     Hard Enemy (B) = 100 points
;      Next level = 150 points
;    Lives reminder = 150 points
;***********************************
add_point
	STMFD sp!, {r0, r1, r3, r4, r5, lr}
	ldr r3, =point
	ldr r1, [r3]
	
	ldr r4, =new_level_flag
	ldr r0, [r4]         
	cmp r0, #1                ; 0 is stay as same level, 1 is start new level
	beq add_150
	
	ldr r4, =game_over
	ldr r0, [r4]         
	cmp r0, #1                ; 0 is still playing, 1 is end of game
	beq add_lives
	
	cmp r2, #120              ; x, 122
	beq add_50
	cmp r2, #66               ; B, 66
	beq add_100
	cmp r2, #35               ; #, 35
	bne done_add_point
	
	add r1, r1, #10
	str r1, [r3]
	b done_add_point

add_150
	add r1, r1, #150
	str r1, [r3]
	b done_add_point

add_lives
	ldr r4, =player_lives
	ldr r2, [r4]
	mov r4, #150
	mul r5, r2, r4            ; Number of player life * 150   
	add r1, r1, r5
	str r1, [r3]
	b done_add_point

add_50
	add r1, r1, #50
	str r1, [r3]
	b done_add_point
	
add_100
	add r1, r1, #100
	str r1, [r3]
	
done_add_point
	; Display point on the board
	; last position of point on the board is 44
	ldr r4, =board
	mov r0, #0
	cmp r1, #1000
	blt hundredth_bit
	mov r0, r1                ; r0 is dividend
	mov r1, #1000             ; r1 is divisor
	
	bl div_and_mod
	add r0, r0, #48
	strb r0, [r4, #41]
	
hundredth_bit
	cmp r1, #100
	blt hundredth_bit_0
	
	mov r0, r1
	mov r1, #100
	bl div_and_mod
	add r0, r0, #48
	strb r0, [r4, #42]
	b tenth_bit
	
hundredth_bit_0
	mov r0, #48
	strb r0, [r4, #42]

tenth_bit
	mov r0, r1
	mov r1, #10
	bl div_and_mod
	add r0, r0, #48
	strb r0, [r4, #43]
		
	LDMFD sp!, {r0, r1, r3, r4, r5, lr}
	BX lr

	
;***********************************
;        Initial_enemy
;***********************************
initial_enemy
	STMFD sp!, {r4, lr}
	
		; Reset enemy_num to 3
	ldr r4, =enemy_num
	mov r0, #3
	str r0, [r4]
	
	mov r0, #0
	ldr r4, =enemyMove_flag
	str r0, [r4]
	
	mov r0, #1
	ldr r4, =enemyB_live       ; 1 indicates the enemy is alive
    str r0, [r4]

	ldr r4, =enemyX1_live      ; 1 indicates the enemy is alive
    str r0, [r4]

	ldr r4, =enemyX2_live      ; 1 indicates the enemy is alive
    str r0, [r4]

	mov r0, #66				   ; B
	ldr r4, =enemyB_type
	str r0, [r4]
	
	mov r0, #120		       ; x
	ldr r4, =enemyX1_type
	str r0, [r4]

	mov r0, #120               ; x
	ldr r4, =enemyX2_type
	str r0, [r4]

	;enemy initialization
	mov r0, #0
	bl enemy_position_generator
	mov r0, #1
	bl enemy_position_generator
	mov r0, #2
	bl enemy_position_generator
	
	mov r1, #2
	ldr r4, =enemyB_dir
	str r1, [r4]
	
	bl random_dir
	ldr r4, =enemyX1_dir
	str r1, [r4]
	
	bl random_dir
	ldr r4, =enemyX2_dir
	str r1, [r4]
	
	LDMFD sp!, {r4, lr}
	BX lr

;***********************************
;        Initial_player
;***********************************
initial_player
	STMFD sp!, {r4, lr}
	
	; Initialize playre_direction
	ldr r4, =current_dir
	mov r0, #0
	str r0, [r4]
	
	; Initialize player pose
	ldr r4, =current_pose
	mov r0, #CENTER
	str r0, [r4]

	; Initialize player char to "^", 
	ldr r4, =current_char
	mov r0, #94               ; ^, 94
	str r0, [r4]
	
	; Put chat to center of board
	ldr r4, =board
	strb r0, [r4, #CENTER]
	mov r0, #32               ; Space, 32
	strb r0, [r4, #CENTER - 1]
	strb r0, [r4, #CENTER + 1]
	
	LDMFD sp!, {r4, lr}
	BX lr


;***********************************
;            Move Up
;       r0: current char
;       r1: current pose
;       r2: char on the board
;       r3: current pose address
;       r4: board address
;***********************************
move_up
	STMFD sp!, {r0-r4, lr}
	
	ldr r3, =current_dir
	mov r0, #0
	str r0, [r3]
	
	ldr r3, =current_char
	mov r0, #94               ; ^, 94
	str r0, [r3]
	
	ldr r3, =current_pose
	ldr r1, [r3]
	sub r1, r1, #23            ; Get next position

	ldr r4, =board	

	cmp r1, #93				  ; If reach second empty line, then stay up. It is not able to move to first empty line
	blt stay_up

	ldr r4, =board
	ldrb r2, [r4, r1]         ; Load next position char
	
	str r1, [r3]              ; Update current position to next position
	mov r0, #32               ; Space, 32
	add r1, r1, #23           ; Get current position
	strb r0, [r4, r1]         ; Clear current position char
	
	cmp r2, #66               ; B, 66
	beq lose_life_up
	cmp r2, #120              ; x, 122
	beq lose_life_up
	cmp r2, #35               ; #, 35
	bne update_up
	bl add_point              ; Update points
	
update_up
	mov r0, #94               ; ^, 94
	sub r1, r1, #23            ; Get next position
	strb r0, [r4, r1]         ; Store current char to next position
	b done_move_up

lose_life_up
	bl lose_life
	b done_move_up

stay_up
	add r1, r1, #23           ; Add back pose to origin pose
	mov r0, #94               ; ^, 94	
	strb r0, [r4, r1]          ; Update char on board
	
done_move_up	
	LDMFD sp!, {r0-r4, lr}
	BX lr
	
	
;***********************************
;         Move Down
;       r0: current char
;       r1: current pose
;       r2: char on the board
;       r3: current pose address
;       r4: board address
;***********************************
move_down
	STMFD sp!, {r0-r4, lr}
	
	ldr r3, =current_dir
	mov r0, #1
	str r0, [r3]
	
	ldr r3, =current_char
	mov r0, #118               ; v, 118
	str r0, [r3]
	
	ldr r3, =current_pose
	ldr r1, [r3]
	add r1, r1, #23            ; Get next position

	ldr r4, =board
	ldrb r2, [r4, r1]         ; Load next position char
	cmp r2, #90               ; Z, 90
	beq stay_down
	
	str r1, [r3]              ; Update current position to next position
	mov r0, #32               ; Space, 32
	sub r1, r1, #23           ; Get current position
	strb r0, [r4, r1]         ; Clear current position char
	
	cmp r2, #66               ; B, 66
	beq lose_life_down
	cmp r2, #120              ; x, 122
	beq lose_life_down
	cmp r2, #35               ; #, 35
	bne update_down
	bl add_point              ; Update points
	
update_down
	mov r0, #118               ; v, 118	
	add r1, r1, #23            ; Get next position
	strb r0, [r4, r1]         ; Store current char to next position
	b done_move_down

lose_life_down
	bl lose_life
	b done_move_down
	
stay_down
	sub r1, r1, #23           ; Subtract back pose to origin pose
	mov r0, #118               ; v, 118	
	strb r0, [r4, r1]          ; Update char on board
	
done_move_down	
	LDMFD sp!, {r0-r4, lr}
	BX lr
	
	
;***********************************
;         Move Right
;       r0: current char
;       r1: current pose
;       r2: char on the board
;       r3: current pose address
;       r4: board address
;***********************************
move_right
	STMFD sp!, {r0-r4, lr}
	
	ldr r3, =current_dir
	mov r0, #2
	str r0, [r3]
	
	ldr r3, =current_char
	mov r0, #62               ; >, 62
	str r0, [r3]
	
	ldr r3, =current_pose
	ldr r1, [r3]
	add r1, r1, #1            ; Get next position
	
	ldr r4, =board
	ldrb r2, [r4, r1]         ; Load next position char
	cmp r2, #90               ; Z, 90
	beq stay_right
	
	str r1, [r3]              ; Update current position to next position
	mov r0, #32               ; Space, 32
	sub r1, r1, #1            ; Get current position
	strb r0, [r4, r1]         ; Clear current position char
	
	cmp r2, #66               ; B, 66
	beq lose_life_right
	cmp r2, #120              ; x, 122
	beq lose_life_right
	cmp r2, #35               ; #, 35
	bne update_right
	bl add_point              ; Update points

update_right 
	mov r0, #62               ; >, 62
	add r1, r1, #1            ; Get next position
	strb r0, [r4, r1]         ; Store current char to next position
	b done_move_right

lose_life_right
	bl lose_life
	b done_move_right

stay_right
	sub r1, r1, #1            ; Subtract back pose to origin pose 
	mov r0, #62               ; >, 62
	strb r0, [r4, r1]          ; Update char on board
	
done_move_right	
	LDMFD sp!, {r0-r4, lr}
	BX lr
	

;***********************************
;         Move Left
;       r0: current char
;       r1: current pose
;       r2: char on the board
;       r3: current pose address
;       r4: board address
;***********************************
move_left
	STMFD sp!, {r0-r4, lr}
	
	ldr r3, =current_dir
	mov r0, #3
	str r0, [r3]
	
	ldr r3, =current_char
	mov r0, #60               ; <, 60
	str r0, [r3]
	
	ldr r3, =current_pose
	ldr r1, [r3]
	sub r1, r1, #1            ; Get next position
	
	ldr r4, =board
	ldrb r2, [r4, r1]         ; Load next position char
	cmp r2, #90               ; Z, 90
	beq stay_left
	
	str r1, [r3]              ; Update current position to next position
	mov r0, #32               ; Space, 32
	add r1, r1, #1
	strb r0, [r4, r1]         ; Store current char to next position
	
	cmp r2, #66               ; B, 66
	beq lose_life_left
	cmp r2, #120              ; x, 122
	beq lose_life_left
	cmp r2, #35               ; #, 35
	bne update_left
	bl add_point              ; Update points

update_left
	mov r0, #60               ; <, 60
	sub r1, r1, #1            ; Get current position
	strb r0, [r4, r1]         ; Clear current position char
	b done_move_left

lose_life_left
	bl lose_life
	b done_move_left
	
stay_left
	mov r0, #60               ; <, 60
	add r1, r1, #1            ; Subtract back pose to origin pose 
	strb r0, [r4, r1]          ; Update char on board
	
done_move_left	
	LDMFD sp!, {r0-r4, lr}
	BX lr
	

;***********************************
;         Random Position
;        Output: r0 = position
;***********************************
random_position
	STMFD sp!, {r0, r4, lr}

	; Obtain Random Number from Timer Counter
	ldr r4, =T0TC
	ldr r0, [r4]
	bic r0, r0, #0x000FF000      ; Only leave bit 0 to 11
	bic r0, r0, #0x0FF00000      
	bic r0, r0, #0xF0000000      
	mov r1, #19
	bl div_and_mod
	mov r3, r1                   ; index of column
	ldr r4, =T0TC
	ldr r0, [r4]
	bic r0, r0, #0x00FF0000      ; Only leave bit 0 to 15
	bic r0, r0, #0xFF000000
	mov r1, #13
	bl div_and_mod               ; r1 is remainder
	mov r2, #23
	mul r0, r1, r2               ; remiander multiply 15 for row
	add r0, r0, r3            	 ; Add index col with row position
	add r0, r0, #117             ; Add to first space position
	
	mov r1, r0
	
	LDMFD sp!, {r0, r4, lr}
	BX lr
	
	
;***********************************
;         Random dir
;       Output: r1 = direction
;***********************************
random_dir
	STMFD sp!, {r0, r1, r3, r4, lr}
	
	; Obtain Random Number from Timer Counter
	ldr r4, =T1TC
	ldr r0, [r4]
	mov r1, r0, lsr #4
	bic r1, r1, #0xFFFFFFF0
	bic r0, r0, #0xFFFFFF00
	add r0, r0, r1
	mov r1, #3
	bl div_and_mod
	
	mov r2, r1
	LDMFD sp!, {r0, r1, r3, r4, lr}
	BX lr



;***********************************
;       illuminateLiveLEDs
;      Input = pattern (r0)
;***********************************
illuminateLiveLEDs
	STMFD sp!, {r1, r4, lr}
	
	ldr r4, =IO1SET				   ; Clear previous pattern
	ldr r1, [r4]
	orr r1, r1, #0x000F0000        ; LEDs lights off when signal are pulled high
	str r1, [r4]

	ldr r4, =IO1CLR				   ; Set Current pattern
	ldr r1, =LIVE_SET
	mov r0, r0, lsl #2             
	ldr r0, [r1, r0]  
	str r0, [r4]

	LDMFD sp!, {r1, r4, lr}
	BX lr


;**********************************************
;       Seven Segements set up
;        Input = number (r0)
;**********************************************
display_digit_on_7_seg
	; Displays a hexadecimal digit on the seven-segment display
	; The digit is passed into the subroutine in r0

	STMFD SP!, {r1, r4, lr}			; Store register lr on stack
	
	LDR r4, =IO0DIR		
	LDR r1, [r4]			; Load current state of IO0DIR
	ORR r1, r1, #0x00003F80
	STR r1, [r4]			; Update IO0DIR

	LDR r4, =IO0CLR		
	LDR r1, [r4]			; Load current state of IO0CLR
	ORR r1, r1, #0x00003F80	; Set IO0CLR, Clear All seven segment
	STR r1, [r4]	   		; Update IO0CLR
	
	LDR r4, =IO0SET		
	LDR r1, =digits_SET		; Lookup Table base address
	MOV r0, r0, LSL #2
	LDR r0, [r1, r0]        ; Offset = 4*r0
	STR r0, [r4]			; Update IO0SET

	LDMFD SP!, {r1, r4, lr}	; Restore register lr from stack	
	BX LR
	


;**********************************************
;              RGB-LED set up	
;            Input = number (r0)
;**********************************************
Illuminate_RGB_LED
	; Illuminates the RGB LED
	; The color to be displayed is passed into the subroutine in r0

	STMFD SP!, {r1, r4, lr}			; Store register lr on stack

	LDR r4, =IO0DIR		    
	LDR r1, [r4]			; Load current state of IO0DIR	
	ORR r1, r1, #0x00260000	; Port0: Pins 17, 18, and 21
	STR r1, [r4]			; Update IO0DIR

	LDR r4, =IO0SET		  
	LDR r1, [r4]			; Load current state of IO0SET
	ORR r1, r1, #0x00260000	; 1 is turn off, 0 is turn on
	STR r1, [r4]			; Update IO0SET
	
	LDR r4, =IO0CLR
	LDR r1, =RGB_SET
	sub r0, r0, #48         ; #48 is 0
	mov r0, r0, LSL #2      ; 4 byte address for each display simbol
	ldr r0, [r1, r0]                    
	str r0, [r4]

	LDMFD SP!, {r1, r4, lr}			; Restore register lr from stack	
	BX LR	



;*********************************
;        Read_charater
; Input = Address(r4), output = Char(r0)
;*********************************
read_character
	STMFD sp!, {r4, lr}
read_char
	LDR r4, =UART0
	LDRB r1, [r4, #U0LSR]	; Get U0LSR address: 0xE000C014
	BIC r1, r1, #0xFE	    ; Get THRE bit
	CMP r1, #0x00
	BEQ read_char
	LDRB r0, [r4]

	LDMFD sp!, {r4, lr}
	BX lr			
	
	
	
;********************************
;        Output_charater
;Input = Address(r4), output = Char(r0)
;********************************
output_character
	STMFD sp!, {r1, r4, lr}
output_char
	LDR r4, =UART0
	LDRB r1, [r4, #U0LSR]   ; Get U0LSR address: 0xE000C014
	BIC r1, r1, #0xDF	    ; Get RDR bit
	CMP r1, #0		   
	BEQ output_char
	STRB r0, [r4]

	LDMFD sp!, {r1, r4, lr}
	BX lr



;*********************************
;       Output_String
; Input = Address(r4), 
;*********************************
output_string
	STMFD sp!, {lr}
	LDRB r0, [r4]
output
	bl output_character
	ADD r4, r4, #1         ; Get next byte address
	LDRB r0, [r4]
	CMP r0, #0	           ; Exit the loop when r0 = 0
	BNE output
	
	LDMFD sp!, {lr}
	BX lr


;******************************************
;          Read_String
;     Input = Address(r4),
;******************************************
read_string
	STMFD sp!, {lr}
read
	bl read_character
	strb r0, [r4]               ; Store char to address
	cmp r0, #13                 ; Enter Key ?
	beq doneRead
	bl output_character
	add r4, r4, #1              ; Get next address
	b read
	
doneRead
	LDMFD sp!, {lr}
	BX lr
	


;********************************
;        Uart_init
;********************************
uart_init
	STMFD sp!, {r0, r4, lr}
	
	mov r0, #131
	ldr r4, =0xE000C00C
	str r0, [r4]
	mov r0, #5                          ; Brad Rate :  224000
	ldr r4, =0xE000C000
	str r0, [r4]
	mov r0, #0
	ldr r4, =0xE000C004
	str r0, [r4]
	mov r0, #3
	ldr r4, =0xE000C00C
	str r0, [r4]
	
	LDMFD sp!, {r0, r4, lr}
	BX lr
	

;****************************************
;       div_and_mod
;  Input = r0(dividend), r1(divisor)
;  Output = r0(quotient), r1(remainder)
;****************************************

div_and_mod
	STMFD r13!, {r2-r12, r14}
			
	; Your code for the signed division/mod routine goes here.  
	; The dividend is passed in r0 and the divisor in r1.
	; The quotient is returned in r0 and the remainder in r1. 
	
	MOV r9, #0
	
	CMP r0, #0           ;
	BGT check_divisor
	NEG r0, r0           ; Negate divisor
	ADD r9, r9, #1
	
check_divisor
	CMP r1, #0
	BGT start
	NEG r1, r1           ; Negate dividend
	ADD r9, r9, #1

start
	MOV	r2, #15          ; Initial Counter to 15
	MOV r3, #0           ; Initial Quotient to 0
	
	MOV r1, r1, LSL #15  ; Shift Left by 15 Place
	MOV r4, r0           ; Initialize Remainder to Dividend
	
dec_count
	SUB r4, r4, r1       ; Remainder = Remainder - Divisor
	CMP r4, #0
	BLT add_remainder
	
	MOV r3, r3, LSL #1 
	ADD r3, r3, #1       ; Left Shift Quotient LSB = 1
	B right_shift
	
add_remainder
	ADD r4, r4, r1       ; Remainder = Remainder + Divisor
	MOV r3, r3, LSL #1   ; Left Shift Quotient LSB = 0
	
right_shift
	MOV r1, r1, LSR #1   ; Right Shift Divisor = 0
	CMP r2, #0
	BLE done
	
	SUB r2, r2, #1       ; Decrement Counter
	B dec_count

done
	CMP r9, #1           ; Check Flag
	BNE result
	NEG r3, r3

result
	MOV r0, r3           ; Move Quotient to r0
	MOV r1, r4           ; Move Reminder to r1
	
	LDMFD r13!, {r2-r12, r14}
	BX lr      ; Return to the C program	
	

pin_connect_block_setup_for_uart0
	STMFD sp!, {r0, r1, lr}
	LDR r0, =0xE002C000  ; PINSEL0
	LDR r1, [r0]
	ORR r1, r1, #5
	BIC r1, r1, #0xA
	STR r1, [r0]
	LDMFD sp!, {r0, r1, lr}
	BX lr


;**********************************************
;  LED Pin connect and Direction set up
;**********************************************
pin_connect_block_setup_for_LEDS
	STMFD sp!, {r0, r1, r4, lr}
	
	LDR r4, =PINSEL1	       ; Set up Pin Connection Block, Each pin contain 2 bytes
	LDR r0, [r4]
	LDR r1, =0x000000FF
	BIC r0, r0, r1
	STR r0, [r4]

	LDR r4, =IO1DIR            ; Set up GPID Direction
	LDR r0, [r4]
	LDR r1, =0x000F0000
	ORR r0, r0, r1			   ; 1 Set as output
	STR r0, [r4]

	LDMFD sp!, {r0, r1, r4, lr}
	BX lr


;******************************************
;  Buttons Pin connect and Direction set up
;******************************************
pin_connect_block_setup_for_Buttons
	STMFD sp!, {r0, r1, r4, lr}
	
	LDR r4, =PINSEL1	       ; Set up Pin Connection Block, Each pin contain 2 bytes
	LDR r0, [r4]
	LDR r1, =0x0000FF00
	BIC r0, r0, r1
	STR r0, [r4]

	LDR r4, =IO1DIR            ; Set up GPIO Direction
	LDR r0, [r4]
	LDR r1, =0x00F00000
	BIC r0, r0, r1			   ; 0 Set as input
	STR r0, [r4]							   

	LDMFD sp!, {r0, r1, r4, lr}
	BX lr

interrupt_init       
	STMFD SP!, {r0-r1, lr}   ; Save registers 
	
	; Push button setup	as External Interrupt 1
	; Page 75
	LDR r0, =PINSEL0
	LDR r1, [r0]
	ORR r1, r1, #0x20000000
	BIC r1, r1, #0x10000000
	STR r1, [r0]  ; PINSEL0 bits 29:28 = 10

	; Classify sources as IRQ or FIQ
	; Interrupt Select Register , contributing to FIQ or IRQ
	; 0xFFFFF00C
	LDR r0, =0xFFFFF000
	LDR r1, [r0, #0xC]
	ORR r1, r1, #0x8000      ; External Interrupt 1, EINT1 = bit 15
	ORR r1, r1, #0x0040      ; UART0 Interrupt, UART0 = bit 6  
	ORR	r1, r1, #0x0010      ; Timer0 Interrupt, TIMER0 = bit 4
	ORR r1, r1, #0x0020      ; Timer1 Interrupt, TIMER1 = bit 5
	STR r1, [r0, #0xC]

	; Enable Interrupts
	; Interrupt Enable Register, enabled to contributing to FIQ or IRQ
	; 0xFFFFF010
	; Page 52
	LDR r0, =0xFFFFF000
	LDR r1, [r0, #0x10] 
	ORR r1, r1, #0x8000      ; External Interrupt 1; EINT1 = bit 15
	ORR r1, r1, #0x0040      ; UART0 Interrupt, UART0 = bit 6 
	ORR	r1, r1, #0x0010      ; Timer0 Interrupt, TIMER0 = bit 4
	ORR r1, r1, #0x0020      ; Timer1 Interrupt, TIMER1 = bit 5
	STR r1, [r0, #0x10]

	; External Interrupt 1 setup for edge sensitive
	; External Interrupt Mode Register
	; Page 22
	LDR r0, =0xE01FC148
	LDR r1, [r0]
	ORR r1, r1, #2           ; EINT1 = Edge Sensitive
	STR r1, [r0]
	
	; Enable UART0 Interrupt when data is received
	; Page 87
	LDR r0, =U0IER
	LDR r1, [r0]
	ORR r1, r1, #1           ; Receive Data Available Interrupt (RDA), bit = 0, Enable RDA = 1
	STR r1, [r0]
	
	; Enable FIQ's, Disable IRQ's
	MRS r0, CPSR
	BIC r0, r0, #0x40
	ORR r0, r0, #0x80
	MSR CPSR_c, r0
	
	; Enable Timer0 control register
	LDR r0, =T0TCR
	LDR r1, [r0]
	ORR r1, r1, #1           ; Bit = 0, Enable = 1
	STR r1, [r0]
	
	; Enable Timer1 control register
	LDR r0, =T1TCR
	LDR r1, [r0]
	ORR r1, r1, #1           ; Bit = 0, Enable = 1
	STR r1, [r0]
	
	; Enable Timer 0 Match Control Register
	LDR r0, =T0MCR
	LDR r1, [r0]
	BIC r1, r1, #0xFFFFFFFF
	ORR r1, r1, #3           ; Set Interrupt Match Register 0: Bit = 0, Enable = 1, Reset MR0: Bit = 1, Enable = 1
	STR r1, [r0]
	
	; Enable Timer 1 Match Control Register
	LDR r0, =T1MCR
	LDR r1, [r0]
	BIC r1, r1, #0xFFFFFFFF
	ORR r1, r1, #3           ; Set Interrupt Match Register 0: Bit = 0, Enable = 1, Reset MR0: Bit = 1, Enable = 1
	STR r1, [r0]
	
	; Initialize Timer 0 Counter to half second
	LDR r0, =T0MR0              ; match register 0
	mov r1, #0
	orr r1, r1, #0x008C0000     ; half second instruction
	orr r1, r1, #0x0000A000
	str r1, [r0]
	
	; Initialize Timer 1 Counter to half second
	LDR r0, =T1MR0              ; match register 0
	mov r1, #0
	orr r1, r1, #0x01100000     ; one second instruction
	orr r1, r1, #0x00094000
	str r1, [r0]
	
	LDMFD SP!, {r0-r1, lr} ; Restore registers
	BX lr             	   ; Return


	END