/*
 Copyright (C) 2012 Xilinx, Inc.

 This file is part of the port for FreeRTOS made by Xilinx to allow FreeRTOS
 to operate with Xilinx Zynq devices.

 This file is free software; you can redistribute it and/or modify it under
 the terms of the GNU General Public License (version 2) as published by the
 Free Software Foundation AND MODIFIED BY the FreeRTOS exception
 (see text further below).

 This file is distributed in the hope that it will be useful, but
 WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 more details.

 You should have received a copy of the GNU General Public License; if not it
 can be viewed here: <http://www.gnu.org/licenses/>

 The following exception language was found at
 http://www.freertos.org/a00114.html on May 8, 2012.

 GNU General Public License Exception

 Any FreeRTOS source code, whether modified or in its original release form,
 or whether in whole or in part, can only be distributed by you under the
 terms of the GNU General Public License plus this exception. An independent
 module is a module which is not derived from or based on FreeRTOS.

 EXCEPTION TEXT:

 Clause 1

 Linking FreeRTOS statically or dynamically with other modules is making a
 combined work based on FreeRTOS. Thus, the terms and conditions of the
 GNU General Public License cover the whole combination.

 As a special exception, the copyright holder of FreeRTOS gives you permission
 to link FreeRTOS with independent modules that communicate with FreeRTOS
 solely through the FreeRTOS API interface, regardless of the license terms
 of these independent modules, and to copy and distribute the resulting
 combined work under terms of your choice, provided that

 Every copy of the combined work is accompanied by a written statement that
 details to the recipient the version of FreeRTOS used and an offer by
 yourself to provide the FreeRTOS source code (including any modifications
 you may have  made) should the recipient request it.
 The combined work is not itself an RTOS, scheduler, kernel or related product.
 The independent modules add significant and primary functionality to FreeRTOS
 and do not merely extend the existing functionality already present
 in FreeRTOS.

 Clause 2

 FreeRTOS may not be used for any competitive or comparative purpose,
 including the publication of any form of run time or compile time metric,
 without the express permission of Real Time Engineers Ltd. (this is the norm
 within the industry and is intended to ensure information accuracy).

*/

/* Kernel includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "timers.h"
#include "xil_printf.h"

#include "xil_types.h"
#include "xgpio.h"
#include "xtmrctr.h"
#include "xparameters.h"
#include "xgpiops.h"
#include "xil_io.h"
#include "xil_exception.h"
#include "xscugic.h"


static XGpioPs psGpioInstancePtr;
extern XGpioPs_Config XGpioPs_ConfigTable[XPAR_XGPIOPS_NUM_INSTANCES];
static int iPinNumber = 10;
XGpioPs_Config*GpioConfigPtr;
static XTmrCtr TimerInstancePtr;
static XGpio GPIOInstance_Ptr;
//void print(char *str);
extern char inbyte(void);


void Button_InterruptHandler(void *data)
{
	print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\r\n");
	print(" Inside GPIO ISR \n \r ");
	XGpioPs_WritePin(&psGpioInstancePtr,iPinNumber, 1);
	print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\r\n");
	XTmrCtr_Start(&TimerInstancePtr,0);
	XGpio_InterruptClear(&GPIOInstance_Ptr, 0x1);
}

void Timer_InterruptHandler(void *data, u8 TmrCtrNumber)
{
	print("\r\n");
	print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\r\n");
	print(" Inside Timer ISR \n \r ");
	XTmrCtr_Stop(&TimerInstancePtr,TmrCtrNumber);
	XGpioPs_WritePin(&psGpioInstancePtr,iPinNumber,0);
//	XGpioPs_WritePin(&psGpioInstancePtr,55,0);
	XTmrCtr_Reset(&TimerInstancePtr,TmrCtrNumber);
	print(" Timer ISR Exit\n \n \r");
	print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\r\n");
}

void EMIO_Button_InterruptHandler(void *CallBackRef, int Bank, u32 Status)
{
	print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\r\n");
	print(" Inside EMIO GPIO ISR \n \r ");
	XGpioPs_WritePin(&psGpioInstancePtr,55,1);
	print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\r\n");
	XTmrCtr_Start(&TimerInstancePtr,0);
	XGpioPs_IntrClear(&psGpioInstancePtr, XGPIOPS_BANK2, 0x1);
}

/*
 * This example creates two tasks were each task prints a statement.
 * Each task yields after it prints a message which apppears on
 * task might be pre-empted before print could complete.
 */
/*-----------------------------------------------------------*/

int main( void )
{
 	prvInitializeExceptions();

	/* Start the tasks and timer running. */
	vTaskStartScheduler();

	/* If all is well, the scheduler will now be running, and the following line
	will never be reached.  If the following line does execute, then there was
	insufficient FreeRTOS heap memory available for the idle and/or timer tasks
	to be created.  See the memory management section on the FreeRTOS web site
	for more details. */
	for( ;; );
}



/*-----------------------------------------------------------*/
void vApplicationMallocFailedHook( void )
{
	/* vApplicationMallocFailedHook() will only be called if
	configUSE_MALLOC_FAILED_HOOK is set to 1 in FreeRTOSConfig.h.  It is a hook
	function that will get called if a call to pvPortMalloc() fails.
	pvPortMalloc() is called internally by the kernel whenever a task, queue or
	semaphore is created.  It is also called by various parts of the demo
	application.  If heap_1.c or heap_2.c are used, then the size of the heap
	available to pvPortMalloc() is defined by configTOTAL_HEAP_SIZE in
	FreeRTOSConfig.h, and the xPortGetFreeHeapSize() API function can be used
	to query the size of free heap space that remains (although it does not
	provide information on how the remaining heap might be fragmented). */
	taskDISABLE_INTERRUPTS();
	for( ;; );
}

/*-----------------------------------------------------------*/
void vApplicationStackOverflowHook( xTaskHandle *pxTask, signed char *pcTaskName )
{
	( void ) pcTaskName;
	( void ) pxTask;

	/* vApplicationStackOverflowHook() will only be called if
	configCHECK_FOR_STACK_OVERFLOW is set to either 1 or 2.  The handle and name
	of the offending task will be passed into the hook function via its
	parameters.  However, when a stack has overflowed, it is possible that the
	parameters will have been corrupted, in which case the pxCurrentTCB variable
	can be inspected directly. */
	taskDISABLE_INTERRUPTS();
	for( ;; );
}

void vApplicationSetupHardware( void )
{
	XScuGic * InterruptController = prvGetInterruptControllerInstance();
	int iPinNumberEMIO = 54;
	u32 uPinDirectionEMIO = 0x0;
	u32 uPinDirection = 0x1;
	print("##### Application Starts #####\n\r");
	print("\r\n");
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//Step-1 :AXI GPIO Initialization
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	u32 xStatus = XGpio_Initialize(&GPIOInstance_Ptr,XPAR_AXI_GPIO_0_DEVICE_ID);
	if(XST_SUCCESS != xStatus)
		print("GPIO INIT FAILED\n\r");
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//Step-2 :AXI GPIO Set the Direction
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	XGpio_SetDataDirection(&GPIOInstance_Ptr, 1,1);
	//set up GPIO interrupt
	XGpio_InterruptEnable(&GPIOInstance_Ptr, 0x1);
	XGpio_InterruptGlobalEnable(&GPIOInstance_Ptr);

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//Step-3 :AXI Timer Initialization
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	xStatus = XTmrCtr_Initialize(&TimerInstancePtr, XPAR_AXI_TIMER_0_DEVICE_ID);
	if(XST_SUCCESS != xStatus)
		print("TIMER INIT FAILED \n\r");
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//Step-4 :Set Timer Handler
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	XTmrCtr_SetHandler(&TimerInstancePtr, Timer_InterruptHandler, &TimerInstancePtr);
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//Step-5 :Setting timer Reset Value
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	XTmrCtr_SetResetValue(&TimerInstancePtr, 0, 0x0F000000);
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//Step-6 :Setting timer Option (Interrupt Mode And Auto Reload )
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	XTmrCtr_SetOptions(&TimerInstancePtr, XPAR_AXI_TIMER_0_DEVICE_ID, (XTC_INT_MODE_OPTION | XTC_AUTO_RELOAD_OPTION | XTC_DOWN_COUNT_OPTION));
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//Step-7 :PS GPIO Intialization
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	GpioConfigPtr = XGpioPs_LookupConfig(XPAR_PS7_GPIO_0_DEVICE_ID);
	if(GpioConfigPtr == NULL)
		print(" PS GPIO config lookup FAILED \n\r");
	xStatus = XGpioPs_CfgInitialize(&psGpioInstancePtr, GpioConfigPtr, GpioConfigPtr->BaseAddr);
	if(XST_SUCCESS != xStatus)
		print(" PS GPIO INIT FAILED \n\r");
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//Step-8 :PS GPIO pin setting to Output
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	XGpioPs_SetDirectionPin(&psGpioInstancePtr, 54, uPinDirection);
	XGpioPs_SetOutputEnablePin(&psGpioInstancePtr, 54,1);
//	XGpioPs_SetDirectionPin(&psGpioInstancePtr, 8,uPinDirection);
//	XGpioPs_SetOutputEnablePin(&psGpioInstancePtr, 8, 1);
	print(" INITED MIO \n\r");
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//Step-9 :EMIO PIN Setting to Input port
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	XGpioPs_SetDirectionPin(&psGpioInstancePtr,	iPinNumberEMIO, uPinDirectionEMIO);
	XGpioPs_SetOutputEnablePin(&psGpioInstancePtr, iPinNumberEMIO, 0);
	//XGpioPs_IntrEnable(&psGpioInstancePtr, XGPIOPS_BANK2, 0x1);
	// instance, bank, edge, rising, single edge
	XGpioPs_IntrEnablePin(&psGpioInstancePtr, iPinNumberEMIO);
	XGpioPs_SetIntrType(&psGpioInstancePtr, XGPIOPS_BANK2, 1, 1, 0);
	XGpioPs_SetCallbackHandler(&psGpioInstancePtr, (void *) &psGpioInstancePtr, EMIO_Button_InterruptHandler);

	print(" INITED FIRST EMIO \n\r");
	// EMIO output
	XGpioPs_SetDirectionPin(&psGpioInstancePtr, 55, uPinDirection);
	XGpioPs_SetOutputEnablePin(&psGpioInstancePtr, 55, 1);

	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	//Step-10 : SCUGIC interrupt controller Initialization
	//Registration of the Timer ISR
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	u32 Status = XScuGic_Connect(InterruptController,
							 XPAR_FABRIC_AXI_TIMER_0_INTERRUPT_INTR,
							 (Xil_ExceptionHandler)XTmrCtr_InterruptHandler,
							 (void *)&TimerInstancePtr);

	if (Status != XST_SUCCESS) {
		print(" Error connection timer interrupt \n \r");
	}

	Status = XScuGic_Connect(InterruptController,
							XPAR_FABRIC_AXI_GPIO_0_IP2INTC_IRPT_INTR,
							 (Xil_ExceptionHandler)Button_InterruptHandler,
							 (void *)&GPIOInstance_Ptr);
	if (Status != XST_SUCCESS) {
		print(" Error connection button interrupt \n \r");
	}

	/*
	 * Connect the device driver handler that will be called when an
	 * interrupt for the device occurs, the handler defined above performs
	 * the specific interrupt processing for the device.
	 */
	Status = XScuGic_Connect(InterruptController,
							XPS_GPIO_INT_ID,
							(Xil_ExceptionHandler)XGpioPs_IntrHandler,
							(void *)&psGpioInstancePtr);
	if (Status != XST_SUCCESS) {
		print(" Error connection button EMIO interrupt \n \r");
	}

	/*
	* Enable the interrupt for the device and then cause (simulate) an
	* interrupt so the handlers will be called
	*/
	XScuGic_Enable(InterruptController, XPAR_FABRIC_AXI_GPIO_0_IP2INTC_IRPT_INTR);
	XScuGic_Enable(InterruptController, XPS_GPIO_INT_ID);
	XScuGic_Enable(InterruptController, XPAR_FABRIC_AXI_TIMER_0_INTERRUPT_INTR);

	// turn off all LEDs
	XGpioPs_WritePin(&psGpioInstancePtr, iPinNumber, 0);
	XGpioPs_WritePin(&psGpioInstancePtr, 55, 0);

	print(" End of init \n\r");
}
