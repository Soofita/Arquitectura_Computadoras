#include <stdio.h>

int main(){
int n,i;
unsigned long long t1=0,t2=1,siguienteTermino;
printf("Introduce el numero de terminos que deseas: ");
if(scanf("%d",&n)!=1||n<=0){
printf("Por favor, introduce un numero entero positivo valido.\n");
return 1;
}

printf("Serie de Fibonacci: \n");

for(i=1;i<=n;i++){
printf("%llu",t1);
siguienteTermino=t1+t2;
t1=t2;
t2=siguienteTermino;
}

printf("\n");
return 0;
}
