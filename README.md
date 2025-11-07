# Custom Linux Syscall — my_pid()

This project demonstrates how to implement a **custom Linux system call** named `my_pid()` for educational purposes.  
The syscall returns the PID of the process invoking it.

All files required to patch, build, and test the syscall are contained here.

---

## 📂 Directory Structure

```
my_pid/
├── 0001-arch-x86-syscalls-my_pid-A-custom-syscall-for-educat.patch
├── my_pid.h
├── my_pid.S
├── main.c
├── LICENSE
└── README.md
```

---

## 🧩 Step 1: Get the Linux Kernel Source

Clone the Linux kernel (mainline or a specific version you are working with):

```bash
git clone https://github.com/avinashlalotra/Syscalls
git clone https://github.com/torvalds/linux.git --depth=1
cd linux
```

---

## 🧱 Step 2: Apply the Patch

Apply the syscall patch included in this repo:

```bash
git apply ../Syscalls/0001-arch-x86-syscalls-my_pid-A-custom-syscall-for-educat.patch
```

If you want to confirm that the patch applied correctly:

```bash
git diff --stat
```

This patch will:
- Create a new file `arch/x86/kernel/mysyscall.c`
- Register a new syscall `my_pid` in `arch/x86/entry/syscalls/syscall_64.tbl`
- Add `obj-y += mysyscall.o` to the x86 kernel Makefile

---

## ⚙️ Step 3: Configure and Build the Kernel

Use your current kernel config as a base:

```bash
cp /boot/config-$(uname -r) .config
make oldconfig
```

Now build the kernel (this may take a while):

```bash
make -j$(nproc)
sudo make modules_install
sudo make install
sudo update-grub
```

---

## 🔁 Step 4: Boot the New Kernel

Reboot and select the newly built kernel from the GRUB menu:

```bash
sudo reboot
```

After reboot, confirm that the new kernel is running:

```bash
uname -r
```

---

## 🧠 Step 5: Build and Run the User-Space Program

Change to your working directory:

```bash
cd Syscalls
```

Compile the example program:

```bash
gcc my_pid.S main.c -o mypid
```

Run it:

```bash
./mypid
```

Expected output:

```
The PID (using interrupt): 1234
The PID (using syscall): 1234
The PID (using libc): 1234
```

If you get a negative PID, it means either:
- The syscall wasn’t properly registered, or
- You booted an unpatched kernel.

Reboot into the kernel where you applied the patch.

---

## 🧩 Patch Overview

File: `0001-arch-x86-syscalls-my_pid-A-custom-syscall-for-educat.patch`

This patch:
- Adds `arch/x86/kernel/mysyscall.c`
- Defines `SYSCALL_DEFINE0(my_pid)` returning `task_tgid_vnr(current)`
- Adds syscall entry 470 in `arch/x86/entry/syscalls/syscall_64.tbl`
- Links `mysyscall.o` in `arch/x86/kernel/Makefile`

---

## 🧾 Troubleshooting

| Problem | Likely Cause | Fix |
|----------|--------------|-----|
| Negative PID | Booted into unpatched kernel | Reboot into patched kernel |
| Patch fails | Kernel source mismatch | Use same kernel version as patch |
| Kernel fails to boot | GRUB fallback to older kernel | Boot previous kernel and rebuild |

---

## 🧾 License

This project is licensed under the MIT License.  
See the [LICENSE](LICENSE) file for details.

---

## 👤 Author

**Abinash Singh**  
📌 GitHub: [avinashlalotra/Syscalls](https://github.com/avinashlalotra/Syscalls)
