#include "button.h"
#include "lpc17xx.h"

#include "../led/led.h"
int a=-5;

void EINT0_IRQHandler (void)	  
{	
	a=0;
	LED_Out(a);
  LPC_SC->EXTINT &= (1 << 0);             /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  
{
	a+=1;
  if (a == 128) a=0;
	LED_Out(a);
	
	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{
	a-=1;
	LED_Out(a);
  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */
	
}


