//ATENÇÃO, ARQUIVO DE TESTE PARA O ESCALONADOR POR PROCESSOS, SE MECHER EM ALGUMA VARIAVEL, ANTES OLHE NO PROC.C O QUE SEU VALOR SIGNIFICA


#include "types.h"      
#include "user.h"       //funções da linguagem C, como printf

#define VALOR 1       //valor definido em printf(inteiro fixo)  
#define FILHOS 10	//numero de filhos a serem criados para teste
#define NUMEROGRANDE 11234567 //um numero grande o suficiente para que as iterações acabem em ordem diferente, dependendo do tempo de acesso por bilhetes

void testedosbilhetes(){
    int i=NUMEROGRANDE;
    while(i--){}
    i=NUMEROGRANDE; //repeti aqui para que nao precisasse incluir outra biblioteca para bigints;
    while(i--){}
}

int main(){
    int pid; //cria-se o pai, que dara origem a todos os outros filhos. OBS: esse processo será criado com o numero default de tickets, porem nuna ira terminar, ao contrario de seus filhos.
    int i;
    for (i=0;i<FILHOS;i++){
        if(i<(FILHOS/3)){
            pid=fork(1);
        }else if(i>=(FILHOS/3) &&  i<(2*(FILHOS/3))    ){
            pid=fork(30);
        }else{
            pid=fork(150);
        }if(pid == 0){
            testedosbilhetes();
            exit();
        }
        
    }
    //while (wait() != -1);
    while(1){
        pid=wait();
        if(pid<0)break;
        printf(VALOR,"Filho %d Terminou!\n",pid );
        
    }
    
    
    exit();
}
