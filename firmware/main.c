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

int jaEstaNoVetor(int vetor[], int tamanho, int numero)
{
    for (int i = 0; i < tamanho; ++i)
    {
        if (vetor[i] == numero)
        {
            return 1;
        }
    }
    return 0;
}
int randomError(int num,int in,base_t* decoder,int erros)
{

    int count = 0;
    int posicao;
    int decoded_data;
    int *posicoes = (int *)calloc(erros,sizeof(int));
    int done,j;
    int encoded_data;

    for(int i=0;i<1000;i++)
       {
            encoded_data = in;
            for(int j=0;j<erros;j++)
            {
             do {
                    posicao = rand() % 32+1;
                } while (jaEstaNoVetor(posicoes, j, posicao));
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


int burstError(int num,int in,base_t* decoder,int erros)
{

    int count = 0;
    int posicao;
    int decoded_data;
    int done,j;
    int encoded_data;

    int bin = 0b1;
    for(int i=0;i<erros-1;i++)
    {
        bin = (bin << 1) + 1;
    }

    for(int i=0;i<1000;i++)
    {
       encoded_data = in;
       posicao = rand() % (32-erros);
       encoded_data = encoded_data^(bin<<posicao);
       DECODER->IN1 = encoded_data;
       decoded_data = DECODER->OUT;
       if(decoded_data == num)
       {
           count++;
       }


    }
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

    int count1 = 0;
    int count2 = 0;
    int count3 = 0;
    int count4 =0;
    int count5 = 0;
    int count6 = 0;
    int count7 = 0;
    int count8 = 0;
    int count9 = 0;
    int count10 = 0;
    int count11 =0;
    int count12 =0;

     count1 = burstError(25,encoded_data,DECODER, 1);
     count2 = burstError(25,encoded_data,DECODER, 2);
     count2 = burstError(25,encoded_data,DECODER, 2);
     count3 = burstError(25,encoded_data,DECODER, 3);
     count4 = burstError(25,encoded_data,DECODER, 4);
     count5 = burstError(25,encoded_data,DECODER, 5);
     count6 = burstError(25,encoded_data,DECODER, 6);
     count7 = burstError(25,encoded_data,DECODER, 7);
     count8 = burstError(25,encoded_data,DECODER, 8);
     count9 = burstError(25,encoded_data,DECODER, 9);
     count10 = burstError(25,encoded_data,DECODER, 10);
     count11 = burstError(25,encoded_data,DECODER, 11);
     count12 = burstError(25,encoded_data,DECODER, 12);






    return 0;
}

