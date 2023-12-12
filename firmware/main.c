/*
 * main.c
 *
 *  Created on: Dec 11, 2023
 *      Author: Lesc
 */

/*
#include "firmware/drivers/mss_gpio/mss_gpio.h"
#include "firmware/CMSIS/system_m2sxxx.h"

static const mss_gpio_id_t LED[8] = {
        MSS_GPIO_0, MSS_GPIO_1, MSS_GPIO_2, MSS_GPIO_3,
        MSS_GPIO_4, MSS_GPIO_5, MSS_GPIO_6, MSS_GPIO_7,
};

void delay()
{
    int d = SystemCoreClock / 128;

    while (d-- > 0)
        ;
}

int main(void)
{
    int i, current_val;

    MSS_GPIO_init();

    //* Init & turn on all LEDs
    for (i = 0; i < 8; i++) {
        MSS_GPIO_config(LED[i], MSS_GPIO_OUTPUT_MODE);
        MSS_GPIO_set_output(LED[i], 0);
    }
    delay();
    delay();
    delay();
    delay();

    //* Blink all LEDs on start up
    for (i = 0; i < 8; i++) {
        for (current_val = 0; current_val < 8; ++current_val)
            MSS_GPIO_set_output(LED[current_val], 1);
        delay();
        for (current_val = 0; current_val < 8; ++current_val)
            MSS_GPIO_set_output(LED[current_val], 0);
        delay();
    }

    //* Sequence-blink
    for (;;) {
        for (i = 0; i < 8; i++) {
            current_val = (MSS_GPIO_get_outputs() & (1 << LED[i])) ? 1 : 0;
            MSS_GPIO_set_output(LED[i], current_val ^ 1);
            delay();
        }
    }
}
*/


#include <stdlib.h>

#include "firmware/drivers/mss_gpio/mss_gpio.h"
#include "firmware/CMSIS/system_m2sxxx.h"

typedef struct{
    __IO uint32_t IN1;
    __IO uint32_t OUT;
}base_t;

#define ENCODER ((base_t *) 0x30000000)
#define DECODER ((base_t *) 0x30001000)


int contador(int num,int encoded_data,base_t* decoder,int erros)
{

    int count = 0;
    int posicao;
    int decoded_data;
    int *posicoes = (int *)calloc(erros,sizeof(int));

    for(int i=0;i<1000;i++)
       {
           for(int j = 0;j < erros;j++)
           {
               while (posicoes[j] == posicao)
               {
                   posicao = rand()% 32 +1;
               }
               posicoes[j] = posicao;
               encoded_data = encoded_data^(1<<posicao);
           }

           DECODER->IN1 = encoded_data;
           decoded_data = DECODER->OUT;
           if(decoded_data == num)
           {
               count++;
           }


       }
    free(posicoes);
    return count;
}
int main(void){
    int num = 25;
    int encoded_data;
    int decoded_data;



    ENCODER->IN1 = num;
    encoded_data = ENCODER->OUT;

    DECODER->IN1 = encoded_data;
    decoded_data = DECODER->OUT;

    int count;

    count = contador(25,encoded_data,DECODER, 1);





    return 0;
}
