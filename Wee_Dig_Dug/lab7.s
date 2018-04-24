	AREA interrupts, CODE, READWRITE
	EXPORT lab7
	EXPORT FIQ_Handler
	IMPORT read_character
	IMPORT output_character
	IMPORT output_string
	IMPORT invalidInput
	IMPORT display_digit_on_7_seg
	IMPORT IO0CLR
	IMPORT board
	IMPORT random_position
	IMPORT random_dir
	IMPORT move_up
	IMPORT move_down
	IMPORT move_left
	IMPORT move_right
	
	EXPORT current_dir
	EXPORT current_char
	EXPORT current_pose
	EXPORT point
		
	IMPORT initial_player
	IMPORT Illuminate_RGB_LED
	IMPORT Period_SET
	IMPORT illuminateLiveLEDs
	IMPORT new_board
	IMPORT air_pump
	IMPORT air_pump_clear
	IMPORT update_time
	IMPORT lose_life
	IMPORT initial_enemy
		
    EXPORT player_pose				
	EXPORT enemy_num
	EXPORT player_lives
	EXPORT new_level_flag
	EXPORT game_over
	EXPORT level
	EXPORT slow_enemy_flag
	EXPORT start_state
	EXPORT pause_state
	EXPORT time_value
	EXPORT restart

	EXPORT enemy_position_generator
		
	IMPORT enemy_type	
   	IMPORT enemy_dir
    IMPORT enemyX1_pos
	IMPORT enemyX2_pos
	IMPORT enemyB_pos	
    IMPORT enemyX1_dir 
	IMPORT enemyX2_dir 
	IMPORT enemyB_dir 
    IMPORT enemyX1_type 
	IMPORT enemyX2_type  
	IMPORT enemyB_type  
	IMPORT enemy_Identity	
	IMPORT enemyB_live 
    IMPORT enemyX1_live 
    IMPORT enemyX2_live 
   	IMPORT enemyB_curPos
	IMPORT enemyX1_curPos
	IMPORT enemyX2_curPos
	IMPORT enemyMove_flag

	IMPORT T1TC
	IMPORT div_and_mod


instruction1 = 12, "Welcome to lab #7! In this lab, we will be showing simplified Wee Dig Dug", 0
instruction2 = 13, 10, "Key for control the moving character:", 13, 10, "    1. 'w','s','d' and 'a': change direction for up,down,right and left", 13, 10, "    2. 'q': Exit the game", 13, 10, "    3. Memory Push Button: To pause/restart the game", 13, 10, "GPIO Interface usage: ", 13, 10, "    1. Four LED: Indicate number of lives", 13, 10, "    2. RGB LED: Indicate game status", 13, 10, "    3. Seven-Segment Display: Indicate number level status", 13, 10, "Scoring Section: ", 13, 10, "    1. Navigates through dirt '#' will be awarded 10 points", 13, 10, "    2. Defeating 'X' normal enemy is worth 50 points", 13, 10, "    3. Defeating 'B' normal enemy is worth 100 points", 13, 10, "    4. Getting to next level is worth 150 points", 13, 10, "    5. After 2 minutes game over, 150 points will be awards for each life", 13, 10, "Please press Enter key to start the game.", 0
exit_desc = 12, "Exit the program successfully!", 0
    ALIGN

; 0 is game pending to start, 1 is start the game
start_state = "  ", 0
	ALIGN

; 0 is game pending to pause, 1 is pause the game
pause_state = "  ", 0
	ALIGN
		
; ^: 94, v: 118, <: 60, >: 62		
current_char = "  ", 0
	ALIGN

; 0 is up, 1 is down, 2 is right, 3 is left
current_dir = "  ", 0
	ALIGN

current_pose = "        ", 0
	ALIGN

point = "   ", 0
	ALIGN

enemy_num = "  ", 0
	ALIGN
		
game_over = "  ", 0
	ALIGN

new_level_flag = "  ", 0
	ALIGN

level = "  ", 0
	ALIGN
	
slow_enemy_flag = "  ", 0
	ALIGN

player_lives = "  ", 0
	ALIGN

time_value = "  ", 0
	ALIGN

player_movement = "  ", 0
	ALIGN

player_pose = "   ", 0
    ALIGN

T0MR0 EQU 0xE0004018       ; Timer 0, Match Register 0
T0TC EQU 0xE0004008        ; Timer0 Counter Register
	ALIGN


; Center position on grid
CENTER EQU 241
	ALIGN

lab7	 	
	STMFD sp!, {lr}


	ldr r4, =instruction1
	bl output_string
	
	ldr r4, =instruction2
	bl output_string	
	
	; Display Seven Segment to 0
	mov r0, #0
	bl display_digit_on_7_seg
	
	; Display RGB_LED to Whites
	mov r0, #54
	bl Illuminate_RGB_LED
	
	mov r0, #0
	bl illuminateLiveLEDs

restart
	; Initialize Seven-Segment Display to 0
	mov r0, #0
	ldr r4, =start_state
	str r0, [r4]
	
	; Initialize Button Trigger to be OFF
	mov r0, #0
	ldr r4, =pause_state
	str r0, [r4]
	
	; Set game_over to 0
	mov r0, #0
	ldr r4, =game_over
	str r0, [r4]
	
	; Initialize points to 0
	mov r0, #0
	ldr r4, =point
	str r0, [r4]
	
	; Initialize Time value to 0
	mov r0, #0
	ldr r4, =time_value
	str r0, [r4]
	
loop
	ldr r4, =game_over
	ldr r0, [r4]
	cmp r0, #0
	beq loop
	b restart
	
Exit_Program
	
	LDR r4, =IO0CLR		
	LDR r0, [r4]			  ; Load current state of IO0CLR
	ORR r0, r0, #0x00003F80	  ; Set IO0CLR, Clear All seven segment
	STR r0, [r4]	   		  ; Update IO0CLR

	ldr r4, =exit_desc
	bl output_string
	
	
	LDMFD sp!,{lr}
	BX lr




;***********************************
;     Enemy type initialization
;***********************************
enemy_position_generator
    STMFD sp!, {r4, lr}
	
	bl random_position			   ; Position Store in r0
	
	cmp r0, #0                     ; 0 is Enemy_B
	bne generator_Enemy_X1
	bl enemy_position_check
	ldr r4, =enemyB_pos
	str r1, [r4]
	ldr r4, =enemyB_curPos
	str r1, [r4]
	ldr r4, =enemyB_type
	ldr r0, [r4]
	bl insert_empty

	b done_enemy_pos

generator_Enemy_X1
	cmp r0, #1			           ; 1 is Enemy_X1
	bne generator_Enemy_X2
	bl enemy_position_check
	ldr r4, =enemyX1_pos
	str r1, [r4]
	ldr r4, =enemyX1_curPos
	str r1, [r4]
	ldr r4, =enemyX1_type
	ldr r0, [r4]
	bl insert_empty

	b done_enemy_pos	
	
generator_Enemy_X2
	bl enemy_position_check
	ldr r4, =enemyX2_pos
	str r1, [r4]
	ldr r4, =enemyX2_curPos
	str r1, [r4]
	ldr r4, =enemyX2_type
	ldr r0, [r4]
	bl insert_empty
	

done_enemy_pos	    	
    LDMFD sp!, {r4, lr}
	BX lr

;***********************************
; Check Current position is valid
;     Input: r1 = random_pos
;     Output: r1 = enemy_pose
;***********************************
enemy_position_check
    STMFD sp!, {r0, lr}

start_place     	
	; Put char to board
	ldr r4, =board
	ldrb r0, [r4, r1]
	cmp r0, #66		         ; B
	beq random_again
	cmp r0, #120			 ; x
	beq random_again
	cmp r0, #94				 ; ^
	beq random_again
	cmp r0, #32              ; Space
	beq random_again

	b check_left

random_again
	bl random_position
	b start_place
	  
check_left
	sub r2, r1, #1			 ; Get left position
	ldr r4, =board
	ldrb r0, [r4, r2]
	cmp r0, #32              ; Space
	beq random_again

check_right
	add r2, r1, #1           ; Get right position
	ldr r4, =board
	ldrb r0, [r4, r2]
	cmp r0, #32              ; Space
	beq random_again

check_up
	sub r2, r1, #23          ; Get up position
	ldr r4, =board
	ldrb r0, [r4, r2]
	cmp r0, #32              ; Space
	beq random_again
	cmp r0, #94				 ; ^
	beq random_again
	cmp r0, #120             ; x
	beq random_again
	cmp r0, #66              ; B
	beq random_again

check_down
	add r2, r1, #23
	ldr r4, =board
	ldrb r0, [r4, r2]
	cmp r0, #32              ; Space
	beq random_again
	cmp r0, #94				 ; ^
	beq random_again
	cmp r0, #120             ; x
	beq random_again
	cmp r0, #66              ; B
	beq random_again

	LDMFD sp!, {r0, lr}
	BX lr  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;           Input:
;       r0 = enemy_type 
;       r1 = enemy_pose
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
insert_empty 
    STMFD sp!, {lr}

	ldr r4, =board
	strb r0, [r4, r1]
	
	sub r2, r1, #1
	ldrb r0, [r4, r2] 
	cmp r0, #90          ; Z
	beq store_right
	mov r0, #32 	     ; Space
	strb r0, [r4, r2]

store_right
	add r2, r1, #1
	ldrb r0, [r4, r2] 
	cmp r0, #90          ; Z
	beq store_done
	mov r0, #32 	     ; Space
	strb r0, [r4, r2]

store_done
	LDMFD sp!, {lr}
	BX lr  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;           Input:
;       r0 = enemy_type 
;       r1 = enemy_pose
;       r2 = enemy_dire
;           Ouput:
;       r0 = enemy_type 
;       r1 = enemy_direction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_direction 
    STMFD sp!, {r0, r3, lr}
	
	ldr r4, =board

choose_again
	mov r5, #0            ; Counter
	mov r6, #0            ; Movement Check
	
	cmp r2, #0
	beq check_up_pos
	cmp r2, #1
	beq check_down_pos
	cmp r2, #2
	beq check_left_pos
	cmp r2, #3
	beq check_right_pos
	
check_up_pos
	bl checkUp
	cmp r5, #1             ; Empty Space
	beq return_dir
	mov r5, #0            ; Counter
	mov r6, #0            ; Movement Check         
	bl checkDown
	bl checkLeft
	bl checkRight
	cmp r5, #1
	beq return_dir
	cmp r5, #2
	beq random_pick_two
	
	bl random_dir
	cmp r2, #0
	bne return_dir
	mov r2, #3
	b return_dir

check_down_pos
	bl checkDown
	cmp r5, #1             ; Empty Space
	beq return_dir         
	mov r5, #0            ; Counter
	mov r6, #0            ; Movement Check
	bl checkUp
	bl checkLeft
	bl checkRight
	cmp r5, #1
	beq return_dir
	cmp r5, #2
	beq random_pick_two

	bl random_dir
	cmp r2, #1
	bne return_dir
	mov r2, #3
	b return_dir
	
check_left_pos
	bl checkLeft
	cmp r5, #1             ; Empty Space
	beq return_dir         
	mov r5, #0            ; Counter
	mov r6, #0            ; Movement Check
	bl checkUp
	bl checkDown
	bl checkRight
	cmp r5, #1
	beq return_dir
	cmp r5, #2
	beq random_pick_two

	bl random_dir
	cmp r2, #2
	bne return_dir
	mov r2, #3
	b return_dir
	
check_right_pos
	bl checkRight
	cmp r5, #1             ; Empty Space
	beq return_dir         
	mov r5, #0            ; Counter
	mov r6, #0            ; Movement Check
	bl checkUp
	bl checkDown
	bl checkLeft
	cmp r5, #1
	beq return_dir
	cmp r5, #2
	beq random_pick_two

	bl random_dir
	b return_dir

random_pick_two
	bl check_two_dir
	b return_dir

return_dir
	mov r1, r2

	LDMFD sp!, {r0, r3, lr}
	BX lr 

checkUp
	STMFD SP!, {lr} 
	sub r3, r1, #23
	cmp r3, #93				  ; If reach second empty line, then stay up. It is not able to move to first empty line
	blt checkUp_done
	ldrb r0, [r4, r3]
	cmp r0, #35           ; #
	beq checkUp_done
	cmp r0, #90           ; Z
	beq checkUp_done
	
	add r5, r5, #1
	orr r6, r6, #1
	mov r2, #0
	
checkUp_done
	LDMFD sp!, {lr}
	BX lr 
	
	
checkDown
	STMFD SP!, {lr} 
	add r3, r1, #23
	ldrb r0, [r4, r3]
	cmp r0, #35           ; #
	beq checkDown_done
	cmp r0, #90           ; Z
	beq checkDown_done
	
	add r5, r5, #1
	orr r6, r6, #2
	mov r2, #1

checkDown_done
	LDMFD sp!, {lr}
	BX lr 
	
	
checkLeft
	STMFD SP!, {lr} 
	sub r3, r1, #1
	ldrb r0, [r4, r3]
	cmp r0, #35           ; #
	beq checkLeft_done
	cmp r0, #90           ; Z
	beq checkLeft_done
	
	add r5, r5, #1
	orr r6, r6, #3
	mov r2, #2

checkLeft_done
	LDMFD sp!, {lr}
	BX lr 
	
	
checkRight
	STMFD SP!, {lr} 
	add r3, r1, #1
	ldrb r0, [r4, r3]
	cmp r0, #35           ; #
	beq checkRight_done
	cmp r0, #90           ; Z
	beq checkRight_done
	
	add r5, r5, #1
	orr r6, r6, #4
	mov r2, #3
	
checkRight_done
	LDMFD sp!, {lr}
	BX lr  



random_dir_two
	STMFD sp!, {r0, r1, r3, r4, lr}
	
	; Obtain Random Number from Timer Counter
	ldr r4, =T1TC
	ldr r0, [r4]
	mov r1, r0, lsr #4
	bic r1, r1, #0xFFFFFFF0
	bic r0, r0, #0xFFFFFF00
	add r0, r0, r1
	mov r1, #2
	bl div_and_mod
	
	mov r2, r1
	LDMFD sp!, {r0, r1, r3, r4, lr}
	BX lr


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
check_two_dir
	STMFD SP!, {lr} 

	cmp r6, #0x3
;	bl checkUp
;	bl checkDown
	bl random_dir_two
	b done_check_two

	cmp r6, #0x5
;	bl checkUp
;	bl checkLeft
	bl random_dir_two
	cmp r2, #0
	beq done_check_two
	mov r2, #2
	b done_check_two
	
	cmp r6, #0x9
;	bl checkUp
;	bl checkRight
	bl random_dir_two
	cmp r2, #0
	beq done_check_two
	mov r2, #3
	b done_check_two
	
	cmp r6, #0x6
;	bl checkDown
;	bl checkLeft
	bl random_dir_two
	cmp r2, #0
	beq mov_left
	mov r2, #1
	b done_check_two
	
	cmp r6, #0xA
;	bl checkDown
;	bl checkRight
	bl random_dir_two
	cmp r2, #0
	beq mov_right
	mov r2, #1
	b done_check_two
	
	cmp r6, #0xC
;	bl checkLeft
;	bl checkRight
	bl random_dir_two
	cmp r2, #0
	beq mov_right
	mov r2, #2
	b done_check_two
	
mov_left
	mov r2, #2
	b done_check_two

mov_right
	mov r2, #3
	b done_check_two

done_check_two	
	LDMFD sp!, {lr}
	BX lr	
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;           Input:
;       r1 = enemy_dir
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_dirChoice 
    STMFD sp!, {lr}
	
	cmp r1, #0             
	beq moveUp_enemy
	cmp r1, #1              
	beq moveDown_enemy
	cmp r1, #2               
	beq moveLeft_enemy
	cmp r1, #3              
	beq moveRight_enemy

moveUp_enemy
	bl enemy_moveUp
	b done_choose

moveDown_enemy
	bl enemy_moveDown
	b done_choose
				   
moveLeft_enemy
	bl enemy_moveLeft
	b done_choose

moveRight_enemy
	bl enemy_moveRight
	b done_choose

done_choose
	LDMFD sp!, {lr}
	BX lr  
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;           Input:
;       r0 = enemy_type 
;       r3 = enemy_pose_address
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_moveUp
    STMFD sp!, {lr}
	
	ldr r1, [r3]              ; Load current position from enemy_pose
	sub r1, r1, #23           ; Get next position
	ldr r4, =board
	ldrb r2, [r4, r1]         ; Load next position char
	cmp r2, #60               ;<
	beq lose_life_enemy_up
	cmp r2, #62               ;>
	beq lose_life_enemy_up
	cmp r2, #118              ;v
	beq lose_life_enemy_up
	cmp r2, #94               ;^
	beq lose_life_enemy_up
	
enemy_update_up 
	strb r0, [r4, r1]         ; Store enemy type to next position
	str r1, [r3]              ; Update current position to next position
	mov r0, #32               ; Space, 32
	add r1, r1, #23           ; Get current position
	strb r0, [r4, r1]         ; Clear current position char
	b enemy_done_move_up

lose_life_enemy_up	
	bl lose_life
		
enemy_done_move_up		
	LDMFD sp!, {lr}
	BX lr  
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;           Input:
;       r0 = enemy_type 
;       r3 = enemy_pose_address
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_moveDown
    STMFD sp!, {lr}
	
	ldr r1, [r3]              ; Load current position from enemy_pose
	add r1, r1, #23           ; Get next position
	ldr r4, =board
	ldrb r2, [r4, r1]         ; Load next position char
	cmp r2, #60               ;<
	beq lose_life_enemy_down
	cmp r2, #62               ;>
	beq lose_life_enemy_down
	cmp r2, #118              ;v
	beq lose_life_enemy_down
	cmp r2, #94               ;^
	beq lose_life_enemy_down
	
enemy_update_down 
	strb r0, [r4, r1]         ; Store enemy type to next position
	str r1, [r3]              ; Update current position to next position
	mov r0, #32               ; Space, 32
	sub r1, r1, #23           ; Get current position
	strb r0, [r4, r1]         ; Clear current position char
	b enemy_done_move_down

lose_life_enemy_down	
	bl lose_life
		
enemy_done_move_down		
	LDMFD sp!, {lr}
	BX lr  
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;           Input:
;       r0 = enemy_type 
;       r3 = enemy_pose_address
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_moveLeft
    STMFD sp!, {lr}
	
	ldr r1, [r3]              ; Load current position from enemy_pose
	sub r1, r1, #1            ; Get next position
	ldr r4, =board
	ldrb r2, [r4, r1]         ; Load next position char
	cmp r2, #60               ;<
	beq lose_life_enemy_left	
	cmp r2, #62               ;>
	beq lose_life_enemy_left	
	cmp r2, #118              ;v
	beq lose_life_enemy_left	
	cmp r2, #94               ;^
	beq lose_life_enemy_left	
	
enemy_update_left 
	strb r0, [r4, r1]         ; Store enemy type to next position
	str r1, [r3]              ; Update current position to next position
	mov r0, #32               ; Space, 32
	add r1, r1, #1            ; Get current position
	strb r0, [r4, r1]         ; Clear current position char
	b enemy_done_move_left

lose_life_enemy_left	
	bl lose_life
		
enemy_done_move_left	
	LDMFD sp!, {lr}
	BX lr  
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;           Input:
;       r0 = enemy_type 
;       r3 = enemy_pose_address
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_moveRight
    STMFD sp!, {lr}
	
	ldr r1, [r3]              ; Load current position from enemy_pose
	add r1, r1, #1            ; Get next position
	ldr r4, =board
	ldrb r2, [r4, r1]         ; Load next position char
	cmp r2, #60               ;<
	beq lose_life_enemy_right
	cmp r2, #62               ;>
	beq lose_life_enemy_right
	cmp r2, #118              ;v
	beq lose_life_enemy_right
	cmp r2, #94               ;^
	beq lose_life_enemy_right	
	
enemy_update_right 
	strb r0, [r4, r1]         ; Store enemy type to next position
	str r1, [r3]              ; Update current position to next position
	mov r0, #32               ; Space, 32
	sub r1, r1, #1            ; Get current position
	strb r0, [r4, r1]         ; Clear current position char
	b enemy_done_move_right

lose_life_enemy_right	
	bl lose_life
		
enemy_done_move_right	
	LDMFD sp!, {lr}
	BX lr 


FIQ_Handler
	STMFD SP!, {r0-r12, lr}   ; Save registers 

EINT1			               ; Check for EINT1 interrupt
	
	; TST is used to whether a single bit is set or clear
	; AND a register values with another arithmetic value
	; If there is one in that position of r1, then Zero flag will be clear after the instruction executes
	; EQ is Zero flag is SET.
	; Zero flag is SET: that bit is 0,
	; Zero flag is Clear: that bit is 1
	; Check External Interrupt Flag Register

	LDR r0, =0xE01FC140
	LDR r1, [r0]
	TST r1, #2                ; EINT0 = bit 1, Interrupt Pending = 1
	BNE BTN_Interrupt_handler
	
	LDR r0, =0xE000C008						  
	LDR r1, [r0]
	TST r1, #1                ; UART0 = bit 0, Interrupt Pending = 0
	BEQ UART0_Interrupt_handler
	
	LDR r0, =0xE0004000
	LDR r1, [r0]
	TST r1, #1                ; Timer0 MR0 = bit 0, Interrupt Pending = 1
	BNE Timer0_Interrupt_handler
;	BEQ FIQ_Exit
;	b Timer0_Interrupt_handler

	LDR r0, =0xE0008000
	LDR r1, [r0]
	TST r1, #1                ; Timer0 MR0 = bit 0, Interrupt Pending = 1
	BEQ FIQ_Exit
	b Timer1_Interrupt_handler
	
UART0_Interrupt_handler
	STMFD SP!, {r0-r12, lr}   ; Save registers 

	; Clear automatically when data is read
	bl read_character
	mov r9, r0
	
	cmp r0, #113              ; q
	beq Exit_Program
	cmp r0, #13               ; Enter key
	beq start_game
	
	ldr r4, =start_state
	ldr r0, [r4]
	cmp r0, #1                ; 0 is game pending to start, 1 is start the game
	bne UART0_Interrupt_Exit  ; r0 = 0, then Exit UART0
	
	ldr r4, =pause_state
	ldr r0, [r4]
	cmp r0, #1                ; 0 is game pending to pause, 1 is pause the game
	beq UART0_Interrupt_Exit  ; r0 = 1, then Exit UART0
	
	mov r0, r9
	cmp r0, #32               ; Space
	beq shot_air_pump        
	
	ldr r4, =player_movement
	ldr r1, [r4]
	cmp r1, #1
	beq UART0_Interrupt_Exit
	
	mov r1, #1
	str r1, [r4]
	
	cmp r0, #119              ; w
	beq move_up_UART
	cmp r0, #115              ; s
	beq move_down_UART
	cmp r0, #97               ; a
	beq move_left_UART
	cmp r0, #100              ; d
	beq move_right_UART
	
	b UART0_Interrupt_Exit

start_game
	ldr r4, =start_state         ; 0 is game pending to start, 1 is start the game
	ldr r0, [r4]
	cmp r0, #1
	beq UART0_Interrupt_Exit
	
	mov r0, #1
	str r0, [r4]

	; Initialize points to 0
	mov r0, #0
	ldr r4, =point
	str r0, [r4]
	
	; Initialize Time value to 0
	mov r0, #0
	ldr r4, =time_value
	str r0, [r4]
	
	mov r0, #0
	
	ldr r4, =player_movement
	str r0, [r4]
	
	; Set new_level_flag to 0
	ldr r4, =new_level_flag
	str r0, [r4]
	
	; Set slow_enemy_flag to 0
	ldr r4, =slow_enemy_flag
	str r0, [r4]
	
	; Start with level 1
	ldr r4, =level
	mov r0, #1
	str r0, [r4]
	
	; Display on Seven Segment
	bl display_digit_on_7_seg
	
	mov r0, #4
	ldr r4, =player_lives
	str r0, [r4]
	
	; Display F on LED
	bl illuminateLiveLEDs
	
	; Display Green on RGB_LED
	mov r0, #51
	bl Illuminate_RGB_LED
	
	bl initial_player
	bl initial_enemy
	
	ldr r4, =board
	bl output_string
	
	b UART0_Interrupt_Reset_Timer_Exit

shot_air_pump 
	mov r0, #49
	bl Illuminate_RGB_LED
	 
	bl air_pump
	bl air_pump_clear
	b UART0_Interrupt_Exit
	
move_up_UART
	bl move_up
	b UART0_Interrupt_Exit

move_down_UART
	bl move_down
	b UART0_Interrupt_Exit
				   
move_left_UART
	bl move_left
	b UART0_Interrupt_Exit

move_right_UART
	bl move_right
	b UART0_Interrupt_Exit


;***************************************
;            BTN Interrupt
;***************************************
BTN_Interrupt_handler
	STMFD SP!, {r0-r12, lr}   ; Save registers 
	
	ldr r4, =start_state
	ldr r0, [r4]
	cmp r0, #1                ; 0 is game pending to pause, 1 is start the game
	bne BTN_Interrupt_Exit
	
	ldr r4, =pause_state         ; 0 is game pending to pause, 1 is pause the game
	ldr r0, [r4]
	cmp r0, #0
	beq pause_now
	
	mov r0, #0                   ; Set to pending to pause
	str r0, [r4]
	
	; Set RGB LED to Green
	mov r0, #51                  ; 3
	bl Illuminate_RGB_LED
	b BTN_Interrupt_Exit
	
pause_now
	mov r0, #1                   ; Set to pause mode
	str r0, [r4]	
	
	; Set RGB LED to Blue
	mov r0, #50                  ; 2
	bl Illuminate_RGB_LED
	b BTN_Interrupt_Exit
	
Timer0_Interrupt_handler
	STMFD SP!, {r0-r12, lr}   ; Save registers
	
	ldr r4, =start_state
	ldr r0, [r4]
	cmp r0, #1                ; 0 is game pending to pause, 1 is start the game
	bne Timer0_Interrupt_Exit
	
	ldr r4, =pause_state      ; 0 is game pending to pause, 1 is pause the game
	ldr r0, [r4]
	cmp r0, #1
	beq Timer0_Interrupt_Exit
	
	mov r0, #0
	ldr r4, =player_movement
	str r0, [r4]
	
	ldr r4, =new_level_flag   ; 0 is same level as before, 1 is starting new level
	ldr r0, [r4]
	cmp r0, #1
	bne enemy_move
	
	mov r0, #0                
	str r0, [r4]              ; Set new level flag to same level
	
	ldr r4, =level            ; Current level
	ldr r0, [r4]
	cmp r0, #5
	bgt enemy_move            ; If level is above 5, the speed of game will stay at 0.1 second.
	
	ldr r4, =Period_SET
	mov r0, r0, lsl #2        ; Logical shift left 2 bits to get next address on Period Set,
	ldr r1, [r4, r0]          ; Load time period from Period Set
	ldr r4, =T0MR0
	str r1, [r4]              ; Store time period to match register
	b done_enemy_move
     
	ldr r4, =enemyMove_flag    ; Set enemyMove flag to 0, 0 is able to move
	ldr r0, [r4]
	cmp r0, #0
	beq enemy_move
	
	mov r0, #0
	str r0, [r4]
	b done_enemy_move	

enemy_move
	;; move B first

	ldr r4, =enemyB_live
	ldr r0, [r4]
	cmp r0, #0                ; 0, died
	beq done_move_B

	ldr r3, =enemyB_type
	ldr r0, [r3]              ; Load enemy type to r0
	ldr r3, =enemyB_curPos
	ldr r1, [r3]
	ldr r4, =enemyB_dir
	ldr r2, [r4]
	bl enemy_direction
	
	ldr r4, =enemyB_dir
	str r1, [r4]
	bl enemy_dirChoice
	
done_move_B
	
	; Start Move Emeny_X
	ldr r4, =slow_enemy_flag  ; 0 is move slow type enemy, 1 is skip move slow type enemy
	ldr r0, [r4]
	cmp r0, #1
	beq skip_move_slow_enemy
	
	mov r0, #1                ; Set flag to 1 and stop move slow type enemy next round
	str r0, [r4]
	
	ldr r4, =enemyMove_flag    ; Set enemyMove flag to 0, 0 is able to move
	ldr r0, [r4]
	cmp r0, #0
	beq move_EnemyX1
	
	mov r0, #0
	str r0, [r4]
	b done_enemy_move	

move_EnemyX1
	; Move Enemy_X1
	ldr r4, =enemyX1_live
	ldr r0, [r4]
	cmp r0, #0
	beq move_EnemyX2
	
	ldr r3, =enemyX1_type
	ldr r0, [r3]              ; Load enemy type to r0
	ldr r3, =enemyX1_curPos
	ldr r1, [r3]
	ldr r4, =enemyX1_dir
	ldr r2, [r4]
	bl enemy_direction
	
	ldr r4, =enemyX1_dir
	str r1, [r4]
	bl enemy_dirChoice
	
	ldr r4, =enemyMove_flag    ; Set enemyMove flag to 0, 0 is able to move
	ldr r0, [r4]
	cmp r0, #0
	beq move_EnemyX2
	
	mov r0, #0
	str r0, [r4]
	b done_enemy_move	

move_EnemyX2		
	; Move Enemy_X2
	ldr r4, =enemyX2_live
	ldr r0, [r4]
	cmp r0, #0
	beq done_enemy_move	
	
	ldr r3, =enemyX2_type
	ldr r0, [r3]              ; Load enemy type to r0
	ldr r3, =enemyX2_curPos
	ldr r1, [r3]
	ldr r4, =enemyX1_dir
	ldr r2, [r4]
	bl enemy_direction
	
	ldr r4, =enemyX2_dir
	str r1, [r4]
	bl enemy_dirChoice
	b done_enemy_move
	
skip_move_slow_enemy
	mov r0, #0                ; Set flag to 0 and move slow type enemy next round
	str r0, [r4]
	
done_enemy_move	
	; Print board
	ldr r4, =game_over
	ldr r0, [r4]
	cmp r0, #1
	beq finish_enemy_move

	ldr r4, =board
	bl output_string
finish_enemy_move
	b Timer0_Interrupt_Exit
	
	
			
;***********************************
;     End Process
;***********************************			
Timer1_Interrupt_handler
	STMFD SP!, {r0-r12, lr}   ; Save registers
	
	ldr r4, =start_state
	ldr r0, [r4]
	cmp r0, #1                ; 0 is game pending to pause, 1 is start the game
	bne Timer1_Interrupt_Exit
	
	ldr r4, =pause_state      ; 0 is game pending to pause, 1 is pause the game
	ldr r0, [r4]
	cmp r0, #1
	beq Timer1_Interrupt_Exit

	mov r0, #51
	bl Illuminate_RGB_LED
	
	bl update_time

	b Timer1_Interrupt_Exit

BTN_Interrupt_Exit
	LDMFD SP!, {r0-r12, lr}   ; Restore registers
	; Need Clear Interrupt
	ORR r1, r1, #2		; Clear Interrupt
	STR r1, [r0]
	; need to reset Timer0 Counter to 0
	b FIQ_Exit

UART0_Interrupt_Exit
	LDMFD SP!, {r0-r12, lr}   ; Restore registers
	b FIQ_Exit

UART0_Interrupt_Reset_Timer_Exit
	LDMFD SP!, {r0-r12, lr}   ; Restore registers
	b FIQ_Exit
	
Timer0_Interrupt_Exit
	LDMFD SP!, {r0-r12, lr}   ; Restore registers
	LDR r4, =0xE0004000
	LDR r0, [r4]
	ORR r0, r0, #1            ; Clear Match Register 0 interrupt: Bit = 0, clear = 1
	STR r0, [r4]
	b FIQ_Exit
	
Timer1_Interrupt_Exit
	LDMFD SP!, {r0-r12, lr}   ; Restore registers
	LDR r4, =0xE0008000
	LDR r0, [r4]
	ORR r0, r0, #1            ; Clear Match Register 0 interrupt: Bit = 0, clear = 1
	STR r0, [r4]
	
FIQ_Exit
	LDMFD SP!, {r0-r12, lr}
	SUBS pc, lr, #4

	END