#include <stdio.h>
#include <mpi.h>

int main(int argc, char *argv[])
{
    int i;
    int p; 
    MPI_Init(&argc,&argv);
    MPI_Comm_rank(MPI_COMM_WORLD,&i);
    MPI_Comm_size(MPI_COMM_WORLD,&p);
    printf("Hello world\n");
    printf("El identificador del hilo actual es %d y hay %d procesos\n", i,p);
    MPI_Finalize();
    return 0;
}
