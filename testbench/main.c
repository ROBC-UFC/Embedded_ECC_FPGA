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

#define ENCODER_RSC ((base_t *) 0x30000000)
#define DECODER_RSC ((base_t *) 0x30001000)

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

#define ENCODER_CLC ((clc_encoder *) 0x30000000)
#define DECODER_CLC ((clc_decoder *) 0x30001000)

void delay()
{
    int d = SystemCoreClock / 2;

    while (d-- > 0)
        ;
}
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


int burstErrorRSC(base_t* encoder,base_t* decoder,int erros)
{

    int count = 0;
    int posicao;
    int decoded_data;
    int encoded_data;
    int num;

    int bin = 0b1;
    bin = (bin<<erros)-1;

    for(int i=0;i<1000;i++)
    {
       num = rand() % (1<<16);
       encoder->IN1 = num;
       encoded_data = encoder->OUT;
       posicao = rand() % (32-erros) + 1;
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


int burstErrorCLC(clc_encoder* encoder,clc_decoder* decoder,int erros)
{

    int count = 0;
    int posicao;
    uint32_t num;
    uint32_t encoded_data1,encoded_data2;
    uint64_t encoded_data;
    uint32_t decoded_data;

    uint64_t bin = (1ULL << erros) - 1;

    for(int i=0;i<1000;i++)
    {
       num = rand() % (1<<16);
       encoder->IN = num;
       encoded_data1 = encoder->OUT1;
       encoded_data2 =  encoder->OUT2;
       encoded_data = ((uint64_t)encoded_data2 << 32) | encoded_data1;

       posicao = rand() % (40-erros) + 1;
       encoded_data = encoded_data^(bin<<posicao);

       encoded_data1 = (uint32_t)(encoded_data & 0xFFFFFFFF);
       encoded_data2 =  (uint32_t)(encoded_data>>32);
       decoder->IN1 = encoded_data1;
       decoder->IN2 = encoded_data2;
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
    srand(10);

    //TBEC-RSC
    ENCODER_RSC->IN1 = num;
    encoded_data = ENCODER_RSC->OUT;

    DECODER_RSC->IN1 = encoded_data;
    decoded_data = DECODER_RSC->OUT;

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

    count1 = burstErrorRSC(ENCODER_RSC, DECODER_RSC, 1);
    count2 = burstErrorRSC(ENCODER_RSC, DECODER_RSC, 2);
    count3 = burstErrorRSC(ENCODER_RSC, DECODER_RSC, 3);
    count4 = burstErrorRSC(ENCODER_RSC, DECODER_RSC, 4);
    count5 = burstErrorRSC(ENCODER_RSC, DECODER_RSC, 5);
    count6 = burstErrorRSC(ENCODER_RSC, DECODER_RSC, 6);
    count7 = burstErrorRSC(ENCODER_RSC, DECODER_RSC, 7);
    count8 = burstErrorRSC(ENCODER_RSC, DECODER_RSC, 8);
    count9 = burstErrorRSC(ENCODER_RSC, DECODER_RSC, 9);
    count10 = burstErrorRSC(ENCODER_RSC, DECODER_RSC, 10);
    count11 = burstErrorRSC(ENCODER_RSC, DECODER_RSC, 11);
    count12 = burstErrorRSC(ENCODER_RSC, DECODER_RSC, 12);

    */

       //CLC
       uint32_t num = 43885;
       uint32_t encoded_data1,encoded_data2;
       uint64_t encoded_data;
       uint32_t decoded_data;
       srand(35);

       ENCODER_CLC->IN = num;
       encoded_data1 = ENCODER_CLC->OUT1;
       encoded_data2 =  ENCODER_CLC->OUT2;
       encoded_data = (((uint64_t)encoded_data2 << 32)) | encoded_data1;

       encoded_data = encoded_data^((uint64_t)0b11<<33);


       encoded_data1 = (uint32_t)(encoded_data & 0xFFFFFFFF);
       encoded_data2 =  (uint32_t)(encoded_data>>32);
       DECODER_CLC->IN1 = encoded_data1;
       DECODER_CLC->IN2 = encoded_data2;
       decoded_data = DECODER_CLC->OUT;

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


       count1 = burstErrorCLC(ENCODER_CLC, DECODER_CLC, 1);
       count2 = burstErrorCLC(ENCODER_CLC, DECODER_CLC, 2);
       count3 = burstErrorCLC(ENCODER_CLC, DECODER_CLC, 3);
       count4 = burstErrorCLC(ENCODER_CLC, DECODER_CLC, 4);
       count5 = burstErrorCLC(ENCODER_CLC, DECODER_CLC, 5);
       count6 = burstErrorCLC(ENCODER_CLC, DECODER_CLC, 6);
       count7 = burstErrorCLC(ENCODER_CLC, DECODER_CLC, 7);
       count8 = burstErrorCLC(ENCODER_CLC, DECODER_CLC, 8);
       count9 = burstErrorCLC(ENCODER_CLC, DECODER_CLC, 9);
       count10 = burstErrorCLC(ENCODER_CLC, DECODER_CLC, 10);
       count11 = burstErrorCLC(ENCODER_CLC, DECODER_CLC, 11);
       count12 = burstErrorCLC(ENCODER_CLC, DECODER_CLC, 12);



    return 0;
}

