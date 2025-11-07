.text
.global my_pid_legacy, my_pid_modern
.type my_pid_legacy, @function
.type my_pid_modern, @function
.equ __NR_my_pid, 470

/*software interrupt, slow */
my_pid_legacy:
	mov $__NR_my_pid, %eax
	int $0x80
	ret

/* fast path for 64 bit */
my_pid_modern:
	mov $__NR_my_pid, %rax
	syscall
	ret
