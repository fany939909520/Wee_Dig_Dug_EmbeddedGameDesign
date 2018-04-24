extern int lab7(void);	
extern int pin_connect_block_setup_for_uart0(void);
extern int pin_connect_block_setup_for_LEDS(void);
extern int pin_connect_block_setup_for_Buttons(void);
extern int uart_init(void);
extern int interrupt_init(void);

int main()
{ 	
   pin_connect_block_setup_for_uart0();
   pin_connect_block_setup_for_LEDS();
   pin_connect_block_setup_for_Buttons();
   uart_init();
   interrupt_init();
   lab7();
};
