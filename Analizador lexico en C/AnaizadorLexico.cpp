#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void leerCaracter(char c);
void Estado();
void buscarIndicador();

char *Indicador[] = {"si","sino","finsi","repetir","hasta","mientras","leer","imprimir","cursor","definir"};
int tamanioIndicador=sizeof(Indicador)/sizeof(char *);
int i;
int estado=0;
char identificador[100];
char temp[2];

int main( )
{
   FILE *fp ;
   
   printf( "Abriendo archivo" ) ;
   
   fp = fopen ( "fuente.txt", "r" ) ; 
   
   char caracter;
      if ( fp == NULL )
   {
     printf ( "Archivo no existe \n" ) ;
     return 1;
   }
   printf( "Leyendo archivo fuente.txt \n" ) ;
    
   while (1){
	  caracter=fgetc(fp);
	  if(caracter==EOF){
	  break;
	  }
	  while(i==0){
		   if(caracter!='{'){
		   		printf("Debe iniciar con {"); 
		   		exit(-1);
		   		}
		   i=1;
		   }
	  
	  leerCaracter(caracter);
	  switch(caracter){
		  
		  case '(':printf("<TOKEN_PARENTESIS_ABIERTO>");break;
		  case ')':printf("<TOKEN_PARENTESIS-_CERRADO>");break;
		  case '{':printf("<TOKEN_LLAVE_ABIERTA");break;
		  case '}':printf("<TOKEN_LLAVE_CERRADA>");break;
		  }
	  i++;
	   }
   
 
}

void buscarIndicador(){
	for(int i=0;i<tamanioIndicador;i++){
		if(strcmp(Indicador[i],identificador)==0){
			printf("<TOKEN_%s>",Indicador[i]);
			identificador[0]='\0';
			break;
			}
		if(i==(tamanioIndicador)-1){printf("\nError no hay ID");exit(-1);}
		}
		
	}

void Estado(){
	switch(estado){
		
			case 1:printf("<TOKEN_VARIABLE>"); 
			estado=0;
			break;
			case 2:printf("<TOKEN_VARIABLECOMPUESTA>"); 
			estado=0;
			break;
			case 3:buscarIndicador(); 
			estado=0;
			break;
			case 4:printf("<TOKEN_NUMERO>"); 
			estado=0;
			break;
			case 5:printf("<TOKEN_CONSTANTE ENTERO>"); 
			estado=0;
			break;
			case 6:printf("<TOKEN_CONSTANTE_REAL>"); 
			estado=0;
			break;
			case 7:printf("<TOKEN_OPERADOR_NEGATIVO>"); 
			estado=0;
			break;
			case 8:printf("<TOKEN_OPERADOR_POSITIVO>"); 
			estado=0;
			break;
			case 9:printf("<TOKEN_OPERADOR_IGUAL>"); 
			estado=0;
			break;
			case 10:printf("<TOKEN_ASGINACION>"); 
			estado=0;
			break;
			case 11:printf("<TOKEN_DISTINTO>"); 
			estado=0;
			break;
			case 12:printf("<TOKEN_MENOR_Q>"); 
			estado=0;
			break;
			case 14:printf("<TOKEN_MAYOR_Q>"); 
			estado=0;
			break;
			case 15:printf("<TOKEN_MAYOR_O_IGUAL_Q>"); 
			estado=0;
			break;
			case 16:printf("<TOKEN_MENOR_O_IGUAL_Q>"); 
			estado=0;
			break;
			case 17:printf("<TOKEN_INCREMENTO>"); 
			estado=0;
			break;
				
			}
	
	}

void leerCaracter(char c){
	
	if(c==32||c=='}'||c=='{'||c=='('||c==')'||c==';'){
		Estado();
		}
	
	
	if( c>=65 && c<=90 ){
		if(estado==0){
		estado=1;
		}else if(estado==1||estado==2){
		estado=2;
		}
		else if(estado!=0 && estado!=1 && estado!=2){
		printf("\n error");
		exit(-1);
		}
	}
	
	if(c>=96 && c<=122){
		if(estado==0){
		temp[0]=c; 
		strcat(identificador,temp); 
		estado=3;
		}else if(estado==1||estado==2){
		estado=2;
		}
		else if(estado==3){
		temp[0]=c; 
		strcat(identificador,temp);
		estado=3;}
		else{
		printf("\n errorCM"); 
		exit(-1);
		}
	}
	if(c<=57&&c>=48){
		if(estado==0){
			estado=4;
		}else if(estado==4||estado==5){
			estado=5;
		}else if(estado==13||estado==6){
			estado=6;
		}else if(estado==1||estado==2){
			estado=2;
		}else if(estado==7){
			estado=4;
		}else{
			printf("\n ERROR"); 
			exit(-1);
		}
	
	}
	if(c=='.'){
		if(estado==4||estado==5){
			estado=13;
			}
		else if(estado!=4 && estado!=5){
			printf("\n ERROR"); 
			exit(-1);
		}
		
		 }
	
	if(c=='-'){
		if(estado==0){
			estado=7;
			}else if(estado==12){
			estado=10;}
		}	else if(estado==7){
			estado=17;}
	
	if(c=='+'){
		if(estado==0){
			estado=8;
			}else if(estado==8){
			estado=17;}
		}
	if(c=='='){
		if(estado==0){
			estado=9;
			}else if(estado==18){
			estado=11;
			}
		}else if(estado==12){
			estado=16;
			}else if(estado==13){
			estado=15;}
			
		
	if(c=='/'||c=='*'){
		if(estado==0){
			estado=18;
			}else{
				printf("ERROR");
				exit(-1);
				}
		
		}
	
		
	if(c=='<'){                
	
		if(estado==0){estado=12;}else{printf("ERROR <");}
		}
	if(c=='>'){   
		if(estado==0){estado=14;}else{printf("ERROR >");}
		 }	
	
	
	if(c=='!'){
		if(estado==0){estado=18;}else{printf("\n ERROR !");exit(-1);} 
		
		}
}

