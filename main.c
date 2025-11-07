#include <stdio.h>
#include <unistd.h>
#include "my_pid.h"


int main(){
	
	printf("My PID (using interrupt) was : %ld \n" , my_pid_legacy());
	printf("My PID (using syscall instruction ) was : %ld \n", my_pid_modern());
	printf("My PID (using libC ) was : %ld \n ", syscall(__NR_my_pid));

	return 0;
};
