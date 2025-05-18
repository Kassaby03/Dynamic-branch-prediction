# 🚀 Simulation of Dynamic Branch prediction

A simulation project that models and analyzes Dynamic branch prediction which is a technique used by modern processors to guess the outcome of conditional branches (like if or loop statements) at runtime to maintain a steady instruction pipeline.
---

## 📚 Table of Contents

- [💡 Acknowledgments](#-acknowledgments)
- [🔍 Problem Description](#-problem-description)
- [🧰 Prerequisites](#-prerequisites)
- [🖥️ Environment Setup](#-environment-setup)
- [✏️ Simulation Code Implementation](#-simulation-code-implementation)
- [🏁 Compile and Run](#-compile-and-run)
- [🧪 Testing and Validation](#-testing-and-validation)
- [🧩 Challenges Encountered](#-challenges-encountered)
- [🛠️ Handling Challenges](#-handling-challenges)
- [📝 Conclusion](#-conclusion)
- [📌 References](#-references)
- [👥 Contributors](#-contributors)

---

## 💡 Acknowledgments

1-Use the SimpleScalar sim-outorder simulator to analyze branch prediction performance

2-Implement a code and compile it  

3-Configure the simulator according to the specified parameters

4-Implement a code for static forward not taken backward taken

5-Analyze branch frequency, characterization, and prediction accuracy

---

## 🔍 Problem Description

This project evaluates the performance of different branch prediction strategies in modern processors. Students will use the SimpleScalar sim-outorder simulator to analyze how various prediction schemes impact program execution efficiency.
Project Goals

Compare three branch prediction strategies: static (backward taken/forward not taken), 2-bit dynamic, and correlating branch prediction
Analyze branch frequency and characterization in benchmark applications
Measure prediction accuracy across different schemes
Investigate the relationship between history bits and prediction performance

Methodology
Students will configure the simulator to model a simple processor with specific cache, TLB, and pipeline parameters. Using applications from the SPEC95 benchmark suite, they will collect data on branch behavior and prediction accuracy.
Deliverables

Experimental results showing branch frequency and characterization
Analysis of prediction accuracy for each scheme
Investigation of instruction fetch vs. commit numbers
Study on the optimal number of history bits
Detailed solution to a specific (3,2) correlated prediction problem

This assignment provides hands-on experience with branch prediction mechanics while developing intuition about the performance trade-offs in modern processor design.

---

## 🧰 Prerequisites
Install dependencies and enable 32-bit support:
```bash
sudo apt update
sudo apt install build-essential flex bison gcc-multilib g++-multilib lib32z1 libc6-i386 lib32gcc-s1 binutils-multiarch wget
```
---

## 🖥️ Environment Setup


---

Clone the repo and create directory:
```bash
git clone https://github.com/Kassaby03/Dynamic-branch-prediction
cd simple-scalar

export IDIR=$HOME/simplescalar
export HOST=i686-pc-linux
export TARGET=sslittle-na-sstrix

mkdir -p $IDIR
```

---



Install SimpleTools
```bash
tar xvfz simpletools-2v0.tgz
rm -rf gcc-2.6.3
```

Install SimpleUtils
```bash
tar xvfz simpleutils-990811.tar.gz
cd simpleutils-990811
```

**Fix Required:**  
Replace `yy_current_buffer` with `YY_CURRENT_BUFFER` in `ld/ldlex.l`.

Then:
```bash
./configure --host=$HOST --target=$TARGET --with-gnu-as --with-gnu-ld --prefix=$IDIR
make CFLAGS=-O
make install
```

---

Build the Simulator
```bash
cd $IDIR
tar xvfz simplesim-3v0d-with-cheetah.tar.gz
cd simplesim-3.0
make config-pisa
make
```

Test:
```bash
./sim-safe tests/bin.little/test-math
```

---

#### Step 4: Install GCC Cross-Compiler
```bash
cd $IDIR
tar xvfz gcc-2.7.2.3.ss.tar.gz
cd gcc-2.7.2.3
./configure --host=$HOST --target=$TARGET --with-gnu-as --with-gnu-ld --prefix=$IDIR
chmod -R +w .
```

##### Fix: `ar` & `ranlib` buffer overflow
```bash
mv ar ranlib $IDIR/sslittle-na-sstrix/bin/
chmod +x $IDIR/sslittle-na-sstrix/bin/ar
chmod +x $IDIR/sslittle-na-sstrix/bin/ranlib
```

##### Manual Fixes
- `Makefile`: Add `-I/usr/include`
- `protoize.c`: `#include <varargs.h>` → `#include <stdarg.h>`
- `obstack.h`:  
  ```c
  *((void **)__o->next_free++) = ((void *)datum);
  ```

Then:
```bash
cp ./patched/sys/cdefs.h ../sslittle-na-sstrix/include/sys/cdefs.h
cp ../sslittle-na-sstrix/lib/libc.a ../lib/
cp ../sslittle-na-sstrix/lib/crt0.o ../lib/
```

Compile:
```bash
make LANGUAGES=c CFLAGS=-O CC="gcc -m32"
make enquire
../simplesim-3.0/sim-safe ./enquire -f > float.h-cross
make LANGUAGES=c CFLAGS=-O CC="gcc -m32" install
```

---


Create a file `test.c`:
```c
#include <stdio.h>
int main() {
    printf("Hello World!\n");
    return 0;
}
```

Compile:
```bash
$IDIR/bin/sslittle-na-sstrix-gcc -o hello hello.c
```

Run:
```bash
$IDIR/simplesim-3.0/sim-safe hello
```

Expected Output:
```
sim: ** starting functional simulation **
Hello World!
```
---

## ✏️ Simulation Code Implementation
```c

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
 
// Function that simulates a random branching decision
int random_branch() {
    return rand() % 2;  // Return either 0 or 1 (mimic true/false or taken/not taken)
}
 
// Function that simulates complex branching
void complex_branching(int iterations) {
    int i, j;
    int decision;
    for (i = 0; i < iterations; i++) {
        // Outer loop branches based on a simple modulus pattern
        if (i % 5 == 0) {
            // First complex decision (based on i)
            decision = random_branch(); // Random decision
            if (decision) {
                printf("Iteration %d: Branch 1 taken\n", i);
            } else {
                printf("Iteration %d: Branch 1 not taken\n", i);
            }
        } else if (i % 5 == 1) {
            // Second complex decision
            decision = random_branch();
            if (decision) {
                printf("Iteration %d: Branch 2 taken\n", i);
            } else {
                printf("Iteration %d: Branch 2 not taken\n", i);
            }
        } else if (i % 5 == 2) {
            // Third complex decision
            decision = random_branch();
            if (decision) {
                printf("Iteration %d: Branch 3 taken\n", i);
            } else {
                printf("Iteration %d: Branch 3 not taken\n", i);
            }
        } else if (i % 5 == 3) {
            // Fourth complex decision
            decision = random_branch();
            if (decision) {
                printf("Iteration %d: Branch 4 taken\n", i);
            } else {
                printf("Iteration %d: Branch 4 not taken\n", i);
            }
        } else {
            // Fifth complex decision
            decision = random_branch();
            if (decision) {
                printf("Iteration %d: Branch 5 taken\n", i);
            } else {
                printf("Iteration %d: Branch 5 not taken\n", i);
            }
        }
 
        // Nested loop with additional branching
        for (j = 0; j < 3; j++) {
            // Simulate some branching inside nested loop
            decision = random_branch();
            if (decision) {
                printf("   Inner Loop %d: Branch taken\n", j);
            } else {
                printf("   Inner Loop %d: Branch not taken\n", j);
            }
        }
    }
}
 
int main() {
    int iterations; // Declare variables at the beginning of the block
    
    // Initialize the random number generator
    srand(time(NULL));
 
    // Set the number of iterations for the complex branching test
    iterations = 100;  // You can change this for larger tests
 
    printf("Advanced Branch Prediction Test\n");
    printf("Simulating complex branching with random decisions...\n");
 
    // Call the function to simulate the complex branching behavior
    complex_branching(iterations);
 
    return 0;
}
```

---

## 🏁 Compile and Run

```bash
$IDIR/bin/sslittle-na-sstrix-gcc -o code.c
```

### ▶️ Run with Branch Prediction
put test.ss file in ./tests-pisa/bin.little/
```bash
$IDIR/simplesim-3.0/./sim-outorder -fetch:ifqsize 1 -decode:width 1 -issue:width 1 -issue:inorder true -res:ialu 1 -res:imult 1 -res:memport 1 -res:fpalu 1 -res:fpmult 1 -bpred taken -cache:dl1 dl1:128:32:2:l -cache:il1 il1:128:32:2:l -cache:dl2 ul2:8192:32:1:l -tlb:itlb itlb:16:4096:4:l -tlb:dtlb dtlb:16:4096:8:l -redir:sim sim-backT-forN.txt ./tests-pisa/bin.little/test.ss
```
```bash
$IDIR/simplesim-3.0/./sim-outorder -fetch:ifqsize 1 -decode:width 1 -issue:width 1 -issue:inorder true -res:ialu 1 -res:imult 1 -res:memport 1 -res:fpalu 1 -res:fpmult 1 -bpred 2lev -cache:dl1 dl1:128:32:2:l -cache:il1 il1:128:32:2:l -cache:dl2 ul2:8192:32:1:l -tlb:itlb itlb:16:4096:4:l -tlb:dtlb dtlb:16:4096:8:l -redir:sim sim-2lev.txt ./tests-pisa/bin.little/test.ss 
```
```bash
./sim-outorder -fetch:ifqsize 1 -decode:width 1 -issue:width 1 -issue:inorder true -res:ialu 1 -res:imult 1 -res:memport 1 -res:fpalu 1 -res:fpmult 1 -bpred 2lev -cache:dl1 dl1:128:32:2:l -cache:il1 il1:128:32:2:l -cache:dl2 ul2:8192:32:1:l -tlb:itlb itlb:16:4096:4:l -tlb:dtlb dtlb:16:4096:8:l
```
---

## 🧪 Testing and Validation

🎯 Branch Prediction bimodal stats

```
sim: ** starting performance simulation **

sim: ** simulation statistics **
sim_num_insn                1379329 # total number of instructions committed
sim_num_refs                 476172 # total number of loads and stores committed
sim_num_loads                346548 # total number of loads committed
sim_num_stores          129624.0000 # total number of stores committed
sim_num_branches             347380 # total number of branches committed
sim_elapsed_time                  1 # total simulation time in seconds
sim_inst_rate          1379329.0000 # simulation speed (in insts/sec)
sim_total_insn              1386012 # total number of instructions executed
sim_total_refs               479131 # total number of loads and stores executed
sim_total_loads              349497 # total number of loads executed
sim_total_stores        129634.0000 # total number of stores executed
sim_total_branches           348315 # total number of branches executed
sim_cycle                   2329578 # total simulation time in cycles
sim_IPC                      0.5921 # instructions per cycle
sim_CPI                      1.6889 # cycles per instruction
sim_exec_BW                  0.5950 # total instructions (mis-spec + committed) per cycle
sim_IPB                      3.9707 # instruction per branch
IFQ_count                   1885396 # cumulative IFQ occupancy
IFQ_fcount                  1885396 # cumulative IFQ full count
ifq_occupancy                0.8093 # avg IFQ occupancy (insn's)
ifq_rate                     0.5950 # avg IFQ dispatch rate (insn/cycle)
ifq_latency                  1.3603 # avg IFQ occupant latency (cycle's)
ifq_full                     0.8093 # fraction of time (cycle's) IFQ was full
RUU_count                   4585852 # cumulative RUU occupancy
RUU_fcount                        0 # cumulative RUU full count
ruu_occupancy                1.9685 # avg RUU occupancy (insn's)
ruu_rate                     0.5950 # avg RUU dispatch rate (insn/cycle)
ruu_latency                  3.3087 # avg RUU occupant latency (cycle's)
ruu_full                     0.0000 # fraction of time (cycle's) RUU was full
LSQ_count                   1779754 # cumulative LSQ occupancy
LSQ_fcount                        0 # cumulative LSQ full count
lsq_occupancy                0.7640 # avg LSQ occupancy (insn's)
lsq_rate                     0.5950 # avg LSQ dispatch rate (insn/cycle)
lsq_latency                  1.2841 # avg LSQ occupant latency (cycle's)
lsq_full                     0.0000 # fraction of time (cycle's) LSQ was full
sim_slip                    8211365 # total number of slip cycles
avg_sim_slip                 5.9532 # the average slip between issue and retirement
bpred_bimod.lookups          350375 # total number of bpred lookups
bpred_bimod.updates          347380 # total number of updates
bpred_bimod.addr_hits        326699 # total number of address-predicted hits
bpred_bimod.dir_hits         326928 # total number of direction-predicted hits (includes addr-hits)
bpred_bimod.misses            20452 # total number of misses
bpred_bimod.jr_hits           18494 # total number of address-predicted hits for JR's
bpred_bimod.jr_seen           18905 # total number of JR's seen
bpred_bimod.jr_non_ras_hits.PP           46 # total number of address-predicted hits for non-RAS JR's
bpred_bimod.jr_non_ras_seen.PP          448 # total number of non-RAS JR's seen
bpred_bimod.bpred_addr_rate    0.9405 # branch address-prediction rate (i.e., addr-hits/updates)
bpred_bimod.bpred_dir_rate    0.9411 # branch direction-prediction rate (i.e., all-hits/updates)
bpred_bimod.bpred_jr_rate    0.9783 # JR address-prediction rate (i.e., JR addr-hits/JRs seen)
bpred_bimod.bpred_jr_non_ras_rate.PP    0.1027 # non-RAS JR addr-pred rate (ie, non-RAS JR hits/JRs seen)
bpred_bimod.retstack_pushes        18489 # total number of address pushed onto ret-addr stack
bpred_bimod.retstack_pops        18579 # total number of address popped off of ret-addr stack
bpred_bimod.used_ras.PP        18457 # total number of RAS predictions used
bpred_bimod.ras_hits.PP        18448 # total number of RAS hits
bpred_bimod.ras_rate.PP    0.9995 # RAS prediction rate (i.e., RAS hits/used RAS)
il1.accesses                1453928 # total number of accesses
il1.hits                    1391393 # total number of hits
il1.vc_misses                     0 # total number of victim cache misses
il1.vc_hits                       0 # total number of victim cache hits
il1.misses                    62535 # total number of misses
il1.replacements              62279 # total number of replacements
il1.writebacks                    0 # total number of writebacks
il1.invalidations                 0 # total number of invalidations
il1.miss_rate                0.0430 # miss rate (i.e., misses/ref)
il1.repl_rate                0.0428 # replacement rate (i.e., repls/ref)
il1.wb_rate                  0.0000 # writeback rate (i.e., wrbks/ref)
il1.inv_rate                 0.0000 # invalidation rate (i.e., invs/ref)
dl1.accesses                 476172 # total number of accesses
dl1.hits                     475677 # total number of hits
dl1.vc_misses                     0 # total number of victim cache misses
dl1.vc_hits                       0 # total number of victim cache hits
dl1.misses                      495 # total number of misses
dl1.replacements                239 # total number of replacements
dl1.writebacks                  228 # total number of writebacks
dl1.invalidations                 0 # total number of invalidations
dl1.miss_rate                0.0010 # miss rate (i.e., misses/ref)
dl1.repl_rate                0.0005 # replacement rate (i.e., repls/ref)
dl1.wb_rate                  0.0005 # writeback rate (i.e., wrbks/ref)
dl1.inv_rate                 0.0000 # invalidation rate (i.e., invs/ref)
ul2.accesses                  63258 # total number of accesses
ul2.hits                      62031 # total number of hits
ul2.vc_misses                     0 # total number of victim cache misses
ul2.vc_hits                       0 # total number of victim cache hits
ul2.misses                     1227 # total number of misses
ul2.replacements                212 # total number of replacements
ul2.writebacks                   42 # total number of writebacks
ul2.invalidations                 0 # total number of invalidations
ul2.miss_rate                0.0194 # miss rate (i.e., misses/ref)
ul2.repl_rate                0.0034 # replacement rate (i.e., repls/ref)
ul2.wb_rate                  0.0007 # writeback rate (i.e., wrbks/ref)
ul2.inv_rate                 0.0000 # invalidation rate (i.e., invs/ref)
itlb.accesses               1453928 # total number of accesses
itlb.hits                   1453914 # total number of hits
itlb.vc_misses                    0 # total number of victim cache misses
itlb.vc_hits                      0 # total number of victim cache hits
itlb.misses                      14 # total number of misses
itlb.replacements                 0 # total number of replacements
itlb.writebacks                   0 # total number of writebacks
itlb.invalidations                0 # total number of invalidations
itlb.miss_rate               0.0000 # miss rate (i.e., misses/ref)
itlb.repl_rate               0.0000 # replacement rate (i.e., repls/ref)
itlb.wb_rate                 0.0000 # writeback rate (i.e., wrbks/ref)
itlb.inv_rate                0.0000 # invalidation rate (i.e., invs/ref)
dtlb.accesses                476172 # total number of accesses
dtlb.hits                    476163 # total number of hits
dtlb.vc_misses                    0 # total number of victim cache misses
dtlb.vc_hits                      0 # total number of victim cache hits
dtlb.misses                       9 # total number of misses
dtlb.replacements                 0 # total number of replacements
dtlb.writebacks                   0 # total number of writebacks
dtlb.invalidations                0 # total number of invalidations
dtlb.miss_rate               0.0000 # miss rate (i.e., misses/ref)
dtlb.repl_rate               0.0000 # replacement rate (i.e., repls/ref)
dtlb.wb_rate                 0.0000 # writeback rate (i.e., wrbks/ref)
dtlb.inv_rate                0.0000 # invalidation rate (i.e., invs/ref)
sim_invalid_addrs                 0 # total non-speculative bogus addresses seen (debug var)
ld_text_base             0x00400000 # program text (code) segment base
ld_text_size                  76288 # program text (code) size in bytes
ld_data_base             0x10000000 # program initialized data segment base
ld_data_size                   9008 # program init'ed `.data' and uninit'ed `.bss' size in bytes
ld_stack_base            0x7fffc000 # program stack segment base (highest address in stack)
ld_stack_size                 16384 # program initial stack size
ld_prog_entry            0x004040b0 # program entry point (initial PC)
ld_environ_base          0x7fff8000 # program environment base address address
ld_target_big_endian              0 # target executable endian-ness, non-zero if big endian
mem.page_count                   28 # total number of pages allocated
mem.page_mem                   112k # total size of memory pages allocated
mem.ptab_misses                  36 # total first level page table misses
mem.ptab_accesses           9852844 # total page table accesses
mem.ptab_miss_rate           0.0000 # first level page table miss rate
```
🎯 Branch Prediction 2-level stats
```
sim: ** simulation statistics **
sim_num_insn                1375536 # total number of instructions committed
sim_num_refs                 475395 # total number of loads and stores committed
sim_num_loads                346014 # total number of loads committed
sim_num_stores          129381.0000 # total number of stores committed
sim_num_branches             346652 # total number of branches committed
sim_elapsed_time                  1 # total simulation time in seconds
sim_inst_rate          1375536.0000 # simulation speed (in insts/sec)
sim_total_insn              1380934 # total number of instructions executed
sim_total_refs               477651 # total number of loads and stores executed
sim_total_loads              348260 # total number of loads executed
sim_total_stores        129391.0000 # total number of stores executed
sim_total_branches           347377 # total number of branches executed
sim_cycle                   2280872 # total simulation time in cycles
sim_IPC                      0.6031 # instructions per cycle
sim_CPI                      1.6582 # cycles per instruction
sim_exec_BW                  0.6054 # total instructions (mis-spec + committed) per cycle
sim_IPB                      3.9681 # instruction per branch
IFQ_count                   1879238 # cumulative IFQ occupancy
IFQ_fcount                  1879238 # cumulative IFQ full count
ifq_occupancy                0.8239 # avg IFQ occupancy (insn's)
ifq_rate                     0.6054 # avg IFQ dispatch rate (insn/cycle)
ifq_latency                  1.3608 # avg IFQ occupant latency (cycle's)
ifq_full                     0.8239 # fraction of time (cycle's) IFQ was full
RUU_count                   4572416 # cumulative RUU occupancy
RUU_fcount                        0 # cumulative RUU full count
ruu_occupancy                2.0047 # avg RUU occupancy (insn's)
ruu_rate                     0.6054 # avg RUU dispatch rate (insn/cycle)
ruu_latency                  3.3111 # avg RUU occupant latency (cycle's)
ruu_full                     0.0000 # fraction of time (cycle's) RUU was full
LSQ_count                   1776215 # cumulative LSQ occupancy
LSQ_fcount                        0 # cumulative LSQ full count
lsq_occupancy                0.7787 # avg LSQ occupancy (insn's)
lsq_rate                     0.6054 # avg LSQ dispatch rate (insn/cycle)
lsq_latency                  1.2862 # avg LSQ occupant latency (cycle's)
lsq_full                     0.0000 # fraction of time (cycle's) LSQ was full
sim_slip                    8191808 # total number of slip cycles
avg_sim_slip                 5.9554 # the average slip between issue and retirement
bpred_2lev.lookups           348156 # total number of bpred lookups
bpred_2lev.updates           346652 # total number of updates
bpred_2lev.addr_hits         337688 # total number of address-predicted hits
bpred_2lev.dir_hits          337920 # total number of direction-predicted hits (includes addr-hits)
bpred_2lev.misses              8732 # total number of misses
bpred_2lev.jr_hits            18438 # total number of address-predicted hits for JR's
bpred_2lev.jr_seen            18849 # total number of JR's seen
bpred_2lev.jr_non_ras_hits.PP           41 # total number of address-predicted hits for non-RAS JR's
bpred_2lev.jr_non_ras_seen.PP          443 # total number of non-RAS JR's seen
bpred_2lev.bpred_addr_rate    0.9741 # branch address-prediction rate (i.e., addr-hits/updates)
bpred_2lev.bpred_dir_rate    0.9748 # branch direction-prediction rate (i.e., all-hits/updates)
bpred_2lev.bpred_jr_rate    0.9782 # JR address-prediction rate (i.e., JR addr-hits/JRs seen)
bpred_2lev.bpred_jr_non_ras_rate.PP    0.0926 # non-RAS JR addr-pred rate (ie, non-RAS JR hits/JRs seen)
bpred_2lev.retstack_pushes        18435 # total number of address pushed onto ret-addr stack
bpred_2lev.retstack_pops        18473 # total number of address popped off of ret-addr stack
bpred_2lev.used_ras.PP        18406 # total number of RAS predictions used
bpred_2lev.ras_hits.PP        18397 # total number of RAS hits
bpred_2lev.ras_rate.PP    0.9995 # RAS prediction rate (i.e., RAS hits/used RAS)
il1.accesses                1446435 # total number of accesses
il1.hits                    1385361 # total number of hits
il1.vc_misses                     0 # total number of victim cache misses
il1.vc_hits                       0 # total number of victim cache hits
il1.misses                    61074 # total number of misses
il1.replacements              60818 # total number of replacements
il1.writebacks                    0 # total number of writebacks
il1.invalidations                 0 # total number of invalidations
il1.miss_rate                0.0422 # miss rate (i.e., misses/ref)
il1.repl_rate                0.0420 # replacement rate (i.e., repls/ref)
il1.wb_rate                  0.0000 # writeback rate (i.e., wrbks/ref)
il1.inv_rate                 0.0000 # invalidation rate (i.e., invs/ref)
dl1.accesses                 475395 # total number of accesses
dl1.hits                     474900 # total number of hits
dl1.vc_misses                     0 # total number of victim cache misses
dl1.vc_hits                       0 # total number of victim cache hits
dl1.misses                      495 # total number of misses
dl1.replacements                239 # total number of replacements
dl1.writebacks                  228 # total number of writebacks
dl1.invalidations                 0 # total number of invalidations
dl1.miss_rate                0.0010 # miss rate (i.e., misses/ref)
dl1.repl_rate                0.0005 # replacement rate (i.e., repls/ref)
dl1.wb_rate                  0.0005 # writeback rate (i.e., wrbks/ref)
dl1.inv_rate                 0.0000 # invalidation rate (i.e., invs/ref)
ul2.accesses                  61797 # total number of accesses
ul2.hits                      60561 # total number of hits
ul2.vc_misses                     0 # total number of victim cache misses
ul2.vc_hits                       0 # total number of victim cache hits
ul2.misses                     1236 # total number of misses
ul2.replacements                215 # total number of replacements
ul2.writebacks                   44 # total number of writebacks
ul2.invalidations                 0 # total number of invalidations
ul2.miss_rate                0.0200 # miss rate (i.e., misses/ref)
ul2.repl_rate                0.0035 # replacement rate (i.e., repls/ref)
ul2.wb_rate                  0.0007 # writeback rate (i.e., wrbks/ref)
ul2.inv_rate                 0.0000 # invalidation rate (i.e., invs/ref)
itlb.accesses               1446435 # total number of accesses
itlb.hits                   1446421 # total number of hits
itlb.vc_misses                    0 # total number of victim cache misses
itlb.vc_hits                      0 # total number of victim cache hits
itlb.misses                      14 # total number of misses
itlb.replacements                 0 # total number of replacements
itlb.writebacks                   0 # total number of writebacks
itlb.invalidations                0 # total number of invalidations
itlb.miss_rate               0.0000 # miss rate (i.e., misses/ref)
itlb.repl_rate               0.0000 # replacement rate (i.e., repls/ref)
itlb.wb_rate                 0.0000 # writeback rate (i.e., wrbks/ref)
itlb.inv_rate                0.0000 # invalidation rate (i.e., invs/ref)
dtlb.accesses                475395 # total number of accesses
dtlb.hits                    475386 # total number of hits
dtlb.vc_misses                    0 # total number of victim cache misses
dtlb.vc_hits                      0 # total number of victim cache hits
dtlb.misses                       9 # total number of misses
dtlb.replacements                 0 # total number of replacements
dtlb.writebacks                   0 # total number of writebacks
dtlb.invalidations                0 # total number of invalidations
dtlb.miss_rate               0.0000 # miss rate (i.e., misses/ref)
dtlb.repl_rate               0.0000 # replacement rate (i.e., repls/ref)
dtlb.wb_rate                 0.0000 # writeback rate (i.e., wrbks/ref)
dtlb.inv_rate                0.0000 # invalidation rate (i.e., invs/ref)
sim_invalid_addrs                 0 # total non-speculative bogus addresses seen (debug var)
ld_text_base             0x00400000 # program text (code) segment base
ld_text_size                  76288 # program text (code) size in bytes
ld_data_base             0x10000000 # program initialized data segment base
ld_data_size                   9008 # program init'ed `.data' and uninit'ed `.bss' size in bytes
ld_stack_base            0x7fffc000 # program stack segment base (highest address in stack)
ld_stack_size                 16384 # program initial stack size
ld_prog_entry            0x004040b0 # program entry point (initial PC)
ld_environ_base          0x7fff8000 # program environment base address address
ld_target_big_endian              0 # target executable endian-ness, non-zero if big endian
mem.page_count                   28 # total number of pages allocated
mem.page_mem                   112k # total size of memory pages allocated
mem.ptab_misses                  36 # total first level page table misses
mem.ptab_accesses           9815228 # total page table accesses
mem.ptab_miss_rate           0.0000 # first level page table miss rate
```
🎯 Branch Prediction static prediction (forward not taken backward taken) stats
```
sim: ** simulation statistics **
sim_num_insn                1379329 # total number of instructions committed
sim_num_refs                 476172 # total number of loads and stores committed
sim_num_loads                346548 # total number of loads committed
sim_num_stores          129624.0000 # total number of stores committed
sim_num_branches             347380 # total number of branches committed
sim_elapsed_time                  1 # total simulation time in seconds
sim_inst_rate          1379329.0000 # simulation speed (in insts/sec)
sim_total_insn              1589722 # total number of instructions executed
sim_total_refs               577740 # total number of loads and stores executed
sim_total_loads              447722 # total number of loads executed
sim_total_stores        130018.0000 # total number of stores executed
sim_total_branches           373380 # total number of branches executed
sim_cycle                   3370460 # total simulation time in cycles
sim_IPC                      0.4092 # instructions per cycle
sim_CPI                      2.4436 # cycles per instruction
sim_exec_BW                  0.4717 # total instructions (mis-spec + committed) per cycle
sim_IPB                      3.9707 # instruction per branch
IFQ_count                   2276758 # cumulative IFQ occupancy
IFQ_fcount                  2276758 # cumulative IFQ full count
ifq_occupancy                0.6755 # avg IFQ occupancy (insn's)
ifq_rate                     0.4717 # avg IFQ dispatch rate (insn/cycle)
ifq_latency                  1.4322 # avg IFQ occupant latency (cycle's)
ifq_full                     0.6755 # fraction of time (cycle's) IFQ was full
RUU_count                   4780410 # cumulative RUU occupancy
RUU_fcount                        0 # cumulative RUU full count
ruu_occupancy                1.4183 # avg RUU occupancy (insn's)
ruu_rate                     0.4717 # avg RUU dispatch rate (insn/cycle)
ruu_latency                  3.0071 # avg RUU occupant latency (cycle's)
ruu_full                     0.0000 # fraction of time (cycle's) RUU was full
LSQ_count                   1878386 # cumulative LSQ occupancy
LSQ_fcount                        0 # cumulative LSQ full count
lsq_occupancy                0.5573 # avg LSQ occupancy (insn's)
lsq_rate                     0.4717 # avg LSQ dispatch rate (insn/cycle)
lsq_latency                  1.1816 # avg LSQ occupant latency (cycle's)
lsq_full                     0.0000 # fraction of time (cycle's) LSQ was full
sim_slip                    8203658 # total number of slip cycles
avg_sim_slip                 5.9476 # the average slip between issue and retirement
bpred_taken.lookups               0 # total number of bpred lookups
bpred_taken.updates          347380 # total number of updates
bpred_taken.addr_hits        128021 # total number of address-predicted hits
bpred_taken.dir_hits         128021 # total number of direction-predicted hits (includes addr-hits)
bpred_taken.misses           219359 # total number of misses
bpred_taken.jr_hits             400 # total number of address-predicted hits for JR's
bpred_taken.jr_seen           18905 # total number of JR's seen
bpred_taken.jr_non_ras_hits.PP          400 # total number of address-predicted hits for non-RAS JR's
bpred_taken.jr_non_ras_seen.PP        18905 # total number of non-RAS JR's seen
bpred_taken.bpred_addr_rate    0.3685 # branch address-prediction rate (i.e., addr-hits/updates)
bpred_taken.bpred_dir_rate    0.3685 # branch direction-prediction rate (i.e., all-hits/updates)
bpred_taken.bpred_jr_rate    0.0212 # JR address-prediction rate (i.e., JR addr-hits/JRs seen)
bpred_taken.bpred_jr_non_ras_rate.PP    0.0212 # non-RAS JR addr-pred rate (ie, non-RAS JR hits/JRs seen)
bpred_taken.retstack_pushes            0 # total number of address pushed onto ret-addr stack
bpred_taken.retstack_pops            0 # total number of address popped off of ret-addr stack
bpred_taken.used_ras.PP            0 # total number of RAS predictions used
bpred_taken.ras_hits.PP            0 # total number of RAS hits
bpred_taken.ras_rate.PP <error: divide by zero> # RAS prediction rate (i.e., RAS hits/used RAS)
il1.accesses                1876974 # total number of accesses
il1.hits                    1794737 # total number of hits
il1.vc_misses                     0 # total number of victim cache misses
il1.vc_hits                       0 # total number of victim cache hits
il1.misses                    82237 # total number of misses
il1.replacements              81981 # total number of replacements
il1.writebacks                    0 # total number of writebacks
il1.invalidations                 0 # total number of invalidations
il1.miss_rate                0.0438 # miss rate (i.e., misses/ref)
il1.repl_rate                0.0437 # replacement rate (i.e., repls/ref)
il1.wb_rate                  0.0000 # writeback rate (i.e., wrbks/ref)
il1.inv_rate                 0.0000 # invalidation rate (i.e., invs/ref)
dl1.accesses                 476172 # total number of accesses
dl1.hits                     475677 # total number of hits
dl1.vc_misses                     0 # total number of victim cache misses
dl1.vc_hits                       0 # total number of victim cache hits
dl1.misses                      495 # total number of misses
dl1.replacements                239 # total number of replacements
dl1.writebacks                  228 # total number of writebacks
dl1.invalidations                 0 # total number of invalidations
dl1.miss_rate                0.0010 # miss rate (i.e., misses/ref)
dl1.repl_rate                0.0005 # replacement rate (i.e., repls/ref)
dl1.wb_rate                  0.0005 # writeback rate (i.e., wrbks/ref)
dl1.inv_rate                 0.0000 # invalidation rate (i.e., invs/ref)
ul2.accesses                  82960 # total number of accesses
ul2.hits                      81687 # total number of hits
ul2.vc_misses                     0 # total number of victim cache misses
ul2.vc_hits                       0 # total number of victim cache hits
ul2.misses                     1273 # total number of misses
ul2.replacements                228 # total number of replacements
ul2.writebacks                   47 # total number of writebacks
ul2.invalidations                 0 # total number of invalidations
ul2.miss_rate                0.0153 # miss rate (i.e., misses/ref)
ul2.repl_rate                0.0027 # replacement rate (i.e., repls/ref)
ul2.wb_rate                  0.0006 # writeback rate (i.e., wrbks/ref)
ul2.inv_rate                 0.0000 # invalidation rate (i.e., invs/ref)
itlb.accesses               1876974 # total number of accesses
itlb.hits                   1876960 # total number of hits
itlb.vc_misses                    0 # total number of victim cache misses
itlb.vc_hits                      0 # total number of victim cache hits
itlb.misses                      14 # total number of misses
itlb.replacements                 0 # total number of replacements
itlb.writebacks                   0 # total number of writebacks
itlb.invalidations                0 # total number of invalidations
itlb.miss_rate               0.0000 # miss rate (i.e., misses/ref)
itlb.repl_rate               0.0000 # replacement rate (i.e., repls/ref)
itlb.wb_rate                 0.0000 # writeback rate (i.e., wrbks/ref)
itlb.inv_rate                0.0000 # invalidation rate (i.e., invs/ref)
dtlb.accesses                476172 # total number of accesses
dtlb.hits                    476163 # total number of hits
dtlb.vc_misses                    0 # total number of victim cache misses
dtlb.vc_hits                      0 # total number of victim cache hits
dtlb.misses                       9 # total number of misses
dtlb.replacements                 0 # total number of replacements
dtlb.writebacks                   0 # total number of writebacks
dtlb.invalidations                0 # total number of invalidations
dtlb.miss_rate               0.0000 # miss rate (i.e., misses/ref)
dtlb.repl_rate               0.0000 # replacement rate (i.e., repls/ref)
dtlb.wb_rate                 0.0000 # writeback rate (i.e., wrbks/ref)
dtlb.inv_rate                0.0000 # invalidation rate (i.e., invs/ref)
sim_invalid_addrs                 0 # total non-speculative bogus addresses seen (debug var)
ld_text_base             0x00400000 # program text (code) segment base
ld_text_size                  76288 # program text (code) size in bytes
ld_data_base             0x10000000 # program initialized data segment base
ld_data_size                   9008 # program init'ed `.data' and uninit'ed `.bss' size in bytes
ld_stack_base            0x7fffc000 # program stack segment base (highest address in stack)
ld_stack_size                 16384 # program initial stack size
ld_prog_entry            0x004040b0 # program entry point (initial PC)
ld_environ_base          0x7fff8000 # program environment base address address
ld_target_big_endian              0 # target executable endian-ness, non-zero if big endian
mem.page_count                   28 # total number of pages allocated
mem.page_mem                   112k # total size of memory pages allocated
mem.ptab_misses                  36 # total first level page table misses
mem.ptab_accesses          11740676 # total page table accesses
mem.ptab_miss_rate           0.0000 # first level page table miss rate
```
---

## 🧩 Challenges Encountered
1. **🛠️ Setting up SimpleScalar environment**: The initial configuration of the simulator required understanding a complex set of parameters and ensuring they matched the assignment specifications exactly. The configuration flags needed precise values to match the required computer configuration.

2. **📝 Simulator output interpretation**: Understanding the extensive statistics generated by the SimpleScalar simulator (as seen in sim-2lev.txt) required careful analysis to extract the right metrics for our branch prediction study.


3. **🧩 Correlating branch prediction implementation**: Understanding the specifics of the 2-level branch predictor configuration (1 1024 8 0) required careful study of the SimpleScalar documentation to interpret what these parameters meant for our simulation.

4. **compile a .C file to make it testable for simple scalar**

5. **static branch forward not taken backward taken** 

---

## 🛠️ Handling Challenges
1. **⚙️ SimpleScalar Setup**:
   - Created a consistent configuration file with all required parameters based on assignment specifications
   - Used the command line for 2-lev: `./sim-outorder -fetch:ifqsize 1 -decode:width 1 -issue:width 1 -issue:inorder true -res:ialu 1 -res:imult 1 -res:memport 1 -res:fpalu 1 -res:fpmult 1 -bpred 2lev -cache:dl1 dl1:128:32:2:l -cache:il1 il1:128:32:2:l -cache:dl2 ul2:8192:32:1:l -tlb:itlb itlb:16:4096:4:l -tlb:dtlb dtlb:16:4096:8:l`
   - Used the command line for bimod`sim: command line: ./sim-outorder -fetch:ifqsize 1 -decode:width 1 -issue:width 1 -issue:inorder true -res:ialu 1 -res:imult 1 -res:memport 1 -res:fpalu 1 -res:fpmult 1 -bpred 2lev -cache:dl1 dl1:128:32:2:l -cache:il1 il1:128:32:2:l -cache:dl2 ul2:8192:32:1:l -tlb:itlb itlb:16:4096:4:l -tlb:dtlb dtlb:16:4096:8:l -redir:sim sim-2lev.txt ./tests-pisa/bin.little/test.ss `
   - Used the command line for static branch`sim: command line: ./sim-outorder -fetch:ifqsize 1 -decode:width 1 -issue:width 1 -issue:inorder true -res:ialu 1 -res:imult 1 -res:memport 1 -res:fpalu 1 -res:fpmult 1 -bpred taken -cache:dl1 dl1:128:32:2:l -cache:il1 il1:128:32:2:l -cache:dl2 ul2:8192:32:1:l -tlb:itlb itlb:16:4096:4:l -tlb:dtlb dtlb:16:4096:8:l -redir:sim sim-backT-forN.txt ./tests-pisa/bin.little/test.ss`
   - Validated the configuration by checking simulator output for expected architecture details

2. **📊 Simulator Output Interpretation**:
   - Analyzed the comprehensive statistics in sim-2lev.txt to extract relevant branch prediction metrics
   - Calculated derived metrics such as branch frequency and prediction accuracy
   - Created a systematic approach to compare metrics across different branch prediction schemes

3. **📋 Branch Characterization**:
   - Used metrics like `bpred_2lev.addr_hits` and `bpred_2lev.dir_hits` to understand prediction performance
   - Developed scripts to categorize branches by direction and outcome
   - Cross-referenced branch prediction rates with our expectations based on branch behavior

4. **📈 History Bits Analysis**:
   - Systematically modified the `bpred:2lev` parameter to test different history bit configurations
   - For example, changed `-bpred:2lev 1 1024 8 0` to test different history register widths (8)
   - Analyzed the diminishing returns on prediction accuracy with increasing history bit count

5. **🧮 2-Level Branch Predictor Understanding**:
   - Studied the SimpleScalar documentation to understand the 2-level predictor configuration (1 1024 8 0):
     - 1: Number of entries in first level (shift registers)
     - 1024: Number of entries in second level (pattern history table)
     - 8: Width of shift register (history bits)
     - 0: Not using XOR for indexing (0 = no, 1 = yes)
   - This configuration represents a GAp predictor with 1 global history register of 8 bits and a 1024-entry pattern history table
 6. **🖥️ use a GCC 2.7.2.3 to compile the code**
 7. **we modify code in the bpred.c** 
```c
if (btarget < baddr) {
    dir_update_ptr->dir.bimod = TRUE;
    dir_update_ptr->dir.twolev = TRUE;
    dir_update_ptr->dir.meta = TRUE;
    return btarget;  // Predict taken
} else {
    dir_update_ptr->dir.bimod = FALSE;
    dir_update_ptr->dir.twolev = FALSE;
    dir_update_ptr->dir.meta = FALSE;
    return baddr + sizeof(md_inst_t);  // Predict not taken
}
```

---

## 📝 Conclusion
```
Bimodal Predictor:
Direction prediction rate: 94.11%
Misses: 20,452
IPC (Instructions Per Cycle): 0.5921
CPI (Cycles Per Instruction): 1.6889

2-Level Predictor:
Direction prediction rate: 97.48%
Misses: 8,732
IPC: 0.6031
CPI: 1.6582

Static Prediction (Forward not taken, Backward taken):
Direction prediction rate: 36.85%
Misses: 219,359
IPC: 0.4092
CPI: 2.4436

The 2-level predictor performs the best overall:
Highest prediction accuracy (97.48%)
Lowest number of misses (8,732)
Best IPC (0.6031)
Best CPI (1.6582)

The bimodal predictor performs reasonably well:
Good prediction accuracy (94.11%)
Moderate number of misses (20,452)
Good IPC (0.5921)
Decent CPI (1.6889)

The static predictor performs poorly:
Very low prediction accuracy (36.85%)
High number of misses (219,359)
Poor IPC (0.4092)
High CPI (2.4436)

The results clearly show that dynamic prediction (both 2-level and bimodal) significantly outperforms static prediction. The 2-level predictor's superior performance is due to its ability to capture more complex branch patterns by using both global and local branch history, while the bimodal predictor only uses local history. The static predictor's poor performance demonstrates that branch behavior is too complex to be predicted accurately using simple static rules.

The impact on overall performance is significant - the 2-level predictor achieves about 47% better IPC than static prediction, demonstrating the importance of sophisticated branch prediction in modern processors
```
---

## 📌 References
```
https://courses.cs.washington.edu/courses/cse471
https://www2.seas.gwu.edu/~bhagiweb/cs211/SimpleScalar/simplescalar-ubuntu-install.txt
https://www.ecs.umass.edu/ece/koren/architecture/Simplescalar/SimpleScalar_introduction.htm

```
---

## 👥 Contributors
OMAR AHMED ABDELAZIZ

ALI MOHAMED ALI

MARIOS MAGED

HAGAR ALI

HANA NABHAN
