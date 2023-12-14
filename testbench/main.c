/*
 * main.c
 *
 *  Created on: Dec 11, 2023
 *      Author: Lesc
 */

/*//teste leds piscando
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
#include <stdint.h>
#include "firmware/drivers/mss_gpio/mss_gpio.h"
#include "firmware/CMSIS/system_m2sxxx.h"

//para o TBEC-RSC
typedef struct{
    __IO uint32_t IN1;
    __IO uint32_t OUT;
}base_t;

//#define ENCODER ((base_t *) 0x30000000)
//#define DECODER ((base_t *) 0x30001000)

//para o CLC
typedef struct{
    __IO uint32_t IN;
    __IO uint32_t OUT1;
    __IO uint32_t OUT2;
}clc_encoder;

typedef struct{
    __IO uint32_t IN1;
    __IO uint32_t IN2;
    __IO uint32_t OUT;
}clc_decoder;

#define ENCODER ((clc_encoder *) 0x30000000)
#define DECODER ((clc_decoder *) 0x30001000)

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
int randomError(int num,int in,base_t* decoder,int erros, int wordSize)
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
                    posicao = rand() % wordSize+1;
                } while (jaEstaNoVetor(posicoes, j, posicao));
                  posicoes[j] = posicao;
                  encoded_data = encoded_data^(1<<posicao);
             }

            decoder->IN1 = encoded_data;
           decoded_data = decoder->OUT;
           if(decoded_data == num)
           {
               count++;
           }


       }
    free(posicoes);
    return count;
}


int burstError(base_t* encoder,base_t* decoder,int erros,int wordSize)
{

    int count = 0;
    int posicao;
    int decoded_data;
    int done,j;
    int encoded_data;
    int num;

    int bin = 0b1;
    for(int i=0;i<erros-1;i++)
    {
        bin = (bin << 1) + 1;
    }

    for(int i=0;i<1000;i++)
    {
       num = rand() % (2<<(wordSize/2)-1);
       encoder->IN1 = num;
       encoded_data = encoder->OUT;
       posicao = rand() % (wordSize-erros);
       encoded_data = encoded_data^(bin<<posicao);
       decoder->IN1 = encoded_data;
       decoded_data = decoder->OUT;
       if(decoded_data == num)
       {
           count++;
       }


    }
    return count;
}
int main(void){
    /*
    int num = 25;
    int encoded_data;
    int decoded_data;
    srand(*((volatile unsigned int*)0xE0001004));

    //TBEC-RSC
    ENCODER->IN1 = num;
    encoded_data = ENCODER->OUT;

    DECODER->IN1 = encoded_data;
    decoded_data = DECODER->OUT;

    int count;

    int count1 = 0;
    int count2 = 0;
    int count3 = 0;
    int count4 = 0;
    int count5 = 0;
    int count6 = 0;
    int count7 = 0;
    int count8 = 0;
    int count9 = 0;
    int count10 = 0;
    int count11 = 0;
    int count12 = 0;

    count1 = burstError(ENCODER, DECODER, 1, 32);
    count2 = burstError(ENCODER, DECODER, 2, 32);
    count3 = burstError(ENCODER, DECODER, 3, 32);
    count4 = burstError(ENCODER, DECODER, 4, 32);
    count5 = burstError(ENCODER, DECODER, 5, 32);
    count6 = burstError(ENCODER, DECODER, 6, 32);
    count7 = burstError(ENCODER, DECODER, 7, 32);
    count8 = burstError(ENCODER, DECODER, 8, 32);
    count9 = burstError(ENCODER, DECODER, 9, 32);
    count10 = burstError(ENCODER, DECODER, 10, 32);
    count11 = burstError(ENCODER, DECODER, 11, 32);
    count12 = burstError(ENCODER, DECODER, 12, 32);

    */

       //CLC
       int num = 25;
       int encoded_data1,encoded_data2;
       uint64_t encoded_data;
       int decoded_data;

       ENCODER->IN = num;
       encoded_data1 = ENCODER->OUT1;
       encoded_data2 =  ENCODER->OUT2;
       encoded_data = encoded_data1 + (encoded_data2<<32);


       DECODER->IN1 = encoded_data1;
       DECODER->IN2 = encoded_data2;
       decoded_data = DECODER->OUT;

    return 0;
}

