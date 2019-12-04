%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void Salir();
%}

numero   [0-9]+
Mayus [A-Z]+
letras [a-z]+
comillas ["]
char {Mayus}|{letras}
booleano (verdadero)|(falso)
digito   {letras}|{Mayus}|{numero}|{letras}{Mayus}|{letras}{numero}|{Mayus}{numero}|{Mayus}{letras}|{numero}{Mayus}|{numero}{letras}|{letras}{Mayus}{numero}|{letras}{numero}{Mayus}|{Mayus}{letras}{numero}|{Mayus}{numero}{letras}|{numero}{Mayus}{letras}|{numero}{letras}{Mayus}
indicadores (si)|(sino)|(finsi)|(definir)|(leer)|(imprimir)|(mientras)|(repetir)|(hasta)|(cursor)
variable {Mayus}{digito}|{Mayus}
tipoDato (entero)|(real)|(booleano)|(cadena)|(caracter)
mayor_q ">"
menor_q "<"
igual "="
distinto "!"
operador "*"|"/"
operadorPositivo "+"
operadorNegativo "-"
numeroComp {numero}|{operadorNegativo}{numero}

/*30*/


%%
 
{numeroComp}+   {
            fputs( "TOKEN_ENTERO: %s (%d)\n", yyout );
            }
{numeroComp}+"."{numero}*      {
            fputs( "TOKEN_CONSTANTE_ENTERO: %s (%g)\n", yyout );
            }

{booleano}+   {
            fputs( "TOKEN_BOOLEANO: %s (%d)\n", yyout );
            }
(si) {
            fputs( "TOKEN_SI: %s\n", yyout);
      /*50*/      }
(sino) {
            fputs( "TOKEN_SINO: %s\n", yyout );
            }
(mientras) {
            fputs( "TOKEN_MIENTRAS: %s\n", yyout);
            }
(repetir) {
            fputs( "TOKEN_REPETIR: %s\n", yyout );
            }
(finsi) {
            fputs( "TOKEN_FIN_SI: %s\n", yyout);
            }
(hasta) {
            fputs( "TOKEN_HASTA: %s\n", yyout);
            }
(leer) {
            fputs( "TOKEN_LEER: %s\n", yyout );
            }
(definir) {
            /*70*/fputs( "TOKEN_DEFINIR: %s\n", yyout );
            }
(imprimir) {
           fputs( "TOKEN_IMPRIMIR: %s\n", yyout);
            }
(cursor) {
           fputs( "TOKEN_CURSOR: %s\n", yyout);
            }
{comillas}{char}{comillas} {
            fputs( "TOKEN_CHAR: %s\n", yyout );
           
            }
{comillas}{digito}{comillas} {
            fputs( "TOKEN_CADENA: %s\n", yyout );
           
            }

Salir	 { Salir();
	    }

{variable}   fputs( "TOKEN_VARIABLE: %s\n", yyout );

{menor_q}{operadorNegativo}	  fputs( "TOKEN_ASIGNACION: %s\n", yyout );

{operador}  fputs( "TOKEN_OPERADOR: %s\n", yyout );
{operadorNegativo}  fputs( "TOKEN_OPERADORNEG: %s\n", yyout );
{operadorPositivo}  fputs( "TOKEN_OPERADORPOS: %s\n", yyout);
{mayor_q}{igual}  fputs( "TOKEN_MAYOR_O_IGUAL_Q : %s\n", yyout );
{menor_q}{igual}  fputs( "TOKEN_MENOR_O_IGUAL_Q : %s\n", yyout );
{mayor_q}    fputs( "TOKEN_MAYOR_Q: %s\n", yyout );
{menor_q}    fputs( "TOKEN_MENOR_Q: %s\n", yyout );
{distinto}{igual}   fputs( "TOKEN_DISTINTO: %s\n", yyout );
{operadorPositivo}{operadorPositivo}    fputs( "TOKEN_INCREMENTO: %s\n", yyout);
{operadorNegativo}{operadorNegativo}    fputs( "TOKEN_INCREMENTO: %s\n", yyout );
"("    fputs( "TOKEN_PARENTESIS_ABIERTO: %s\n", yyout);
")"    fputs( "TOKEN_PARENTESIS_CERRADO: %s\n", yyout );
"{"    fputs( "TOKEN_LLAVE_ABIERTA: %s\n", yyout );
"}"    fputs( "TOKEN_LLAVE_CERRADA: %s\n", yyout );
;   


"{"[^}\n]*"}"     
[ \t\n]+          

.           fputs( "ERROR: %s\n", yyout );
            fputs(yytext,yyout);
            fputs("\n",yyout);
        

%%
int main(int argc, char *argv[]){
 FILE *fp ;
   
   printf( "Escribir fuente.txt depues del ./ejecutable.out \n abrir archivo salida.txt" ) ;
   
   fp = fopen ( "fuente.txt", "r" ) ; 
   
   char caracter;
      if ( fp == NULL )
   {
     printf ( "Archivo no existe \n" ) ;
     return 1;
   }
   
 
   
   
   
	if (argc == 2){
		
                yyin= fp;
               
		yyout= fopen("salida.txt", "w");
		if (yyin == NULL){
			printf("no se puede abrir %s ", argv[1]);
			exit(1);
		}
	}
	else{
	    yyin = stdin;
	}
	yylex();
	return 0;
}
void Salir(){
	printf("Saliendo...");
	exit(0);
}
