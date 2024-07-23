
   
# ASIC Design

## Compiling the C code in GCC. Here we'll compile a code to calculate sum of numbers from 1 to 10


1. First we'll ensure that we are in home directory. For that we'll type the command cd. Then we'll be using leafpad text editor to write our C code for calculating the sum.
   <img src="images\Screenshot (517).png" alt="Screenshot">

    

   

2. Type the code for calculating sum of numbers from 1 to 10 in C language in that text editor and save it
   <img src="images\\Screenshot (518).png" alt="Screenshot">


3. Now we'll run this programme. Type command gg sum1ton.c & then type ./a.out. This will show the output of our programme.
<img src="images\\Screenshot 2024-07-16 105811.png" alt="Screenshot">

These are the steps to perform this task

## Compiling the same C code in RISC V compiler

1. Here we have first displayed the code our code content. Then using the command showed in the image, we are compiling the code using RISC gcc. Run it and it'll generate a file sum1ton.o
<img src="images/1.png" alt="Image 1">

2. Now using the command shown in the figure, we'll get assembly code of our c programme. We'll get a bunch of code. We'll again run the same command adding | less in the end
<img src="images/2.png" alt="Image 2">

3. We'll get an output again.And since we are interested in main section, we'll directly jump to that section. Now here we'll count no. of instructions. This will be done by subtracting the address of first instruction of current instruction from the same of next section and then it will be divided by 4 since increment is of 4 at every step. This way we'll get to know that there are 15 sets of instructions when we are using O1
<img src="images/3.png" alt="Image 3">

4. Now move back to the first tab, in the command we used for compiling the code, now we'll now use Ofast and will repeat the same process
<img src="images/4.png" alt="Image 4">

5. Now when you calculate no. of instructions in this case, by the method mentioned in step 3, you'll get no. of instructions here are 12
<img src="images/5.png" alt="Image 5">

So using Ofast our set of instructions gets reduced as Ofast level applies a wider range of aggressive optimizations that streamline code, eliminate redundancies, and leverage parallelism, resulting in a reduced instruction count compared to O1.


## Debugging the code in Spike on RISC V

1. Here first we ran our code on risc v compiler. Now we'll debug it in spike. We'll open spike using the command mentioned
```
spike -d pk sum1ton.o
```
Then we want our programme counter to run till 100b0 (memory address instruction of first location). For that we'll type
```
until pc 0 100b0
```
Now assembly code has all instructions before 100b0
<img src="images/2.1 - Copy.png" alt="Image 2.1 - Copy">


2. The next instruction there basically will modify the content of  a2. Lets check whats the content of a2 with command
```
reg 0 a2
```
Now press enter and it'll run the next instruction which is lui a2, 0x1. This instruction stands for load upper immediate . It'll load upper bits of a2 register by 01. Now again check the content of a2 and you'll see that it has been updated
<img src="images/2.3.png" alt="Image 2.3">

3. Now when you press enter, it'll run the next instruction that is 
```
addi sp,sp,-16
```
This updates the content of sp (stack pointer) by -16 (-10 in hexadecimal). Quit the spike by pressing q.Enter spike again by the command mentioned in step 1. NFrom here we'll go to instruction 100b8 with command
```
until pc 0 100b8
```
check the content of sp with this command
```
reg 0 sp
```
This will show you the content of sp register. Press enter and run the next command. Now if you check content of sp register, you'll see that there is a subtraction of hexadecimal 10.
<img src="images/2.4.png" alt="Image 2.4">

For refference 
<img src="images/2.5.png" alt="Image 2.5">


## Instruction formats in RISC V
In RISC-V, an instruction is a basic operation that a processor can execute. Each instruction typically corresponds to a single operation that the processor can perform on data, such as arithmetic operations, logical operations, memory operations, control flow operations, and so on. These instructions are encoded as binary values that the processor can interpret and execute.
There are 6 instruction formats in RISC-V:

R-format  
I-format  
S-format  
B-format  
U-format  
J-format  
<img src="images/3.1.png" alt="Image 3.1">

Now before jumping into each format directly, lets take a look of subfields which are going to be there in the instructions. I'll be explaining them here. In case any new instruction is there, it will be explained in that format.  

**opcode**   
Reffered to as opearation code. It is of 7 bit length and it specifies what the instruction does, such as arithmetic operations, logical operations, memory operations, or control flow operations. For example, opcode 0110011 specifies R format.  

**rd**   
It stands for destination register. It is a field in the instruction format that specifies which register will receive the result of an operation.   

**rs1 and rs2**    
They stand for source register 1 and source register 2, respectively. They are fields in the instruction format that specify which registers contain the operands or data used by an instruction.

**func3 and func7**  
func3 provides additional details about the specific operation within the opcode category and func7 basically complements it by providing additional details of same information.

**Immediate**  
It is a constant value that is part of an instruction. It is directly encoded within the instruction's binary representation, typically following the opcode and other necessary fields. In different formats, they occupies different bits, which will be explained furthur in the formats.  

Now lets dive into different formats

## 1. R type instruction
The R type instruction is used for arithmetic and logical operations. These operations are performed on registers and not on memory location. We divide 32 bits into 6 different fields.
<img src="images/3.2.png" alt="Image 3.2">
opcode takes 7 bits of length  
rd takes 5 bits of length  
func3 takes 3 bits of length  
rs1 and rs2 takes length of 5 bits  
func7 takes 7 bits of length  

Lets look at some of the variety of examples  

```ADD r6,r7,r8```  
Opcode for ADD = 0110011  
rd = r6 = 00110  
rs1 = r7 = 00111  
rs2 = r8 = 01000  
func3 = 000  
func7 = 0000000  
32 bit pattern: 0000000_01000_00111_000_00110_0110011  

```SUB r8,r6,r7```  
Opcode for SUB = 0110011  
rd = r8 = 01000  
rs1 = r6 = 00110  
rs2 = r7 = 00111  
func3 = 000  
func7 = 0100000   
32 bit pattern: 0100000_00111_00110_000_01000_0110011

```AND r7,r6,r8```   
Opcode for AND = 0110011  
rd = r7 = 00111  
rs1 = r6 = 00110  
rs2 = r8 = 01000  
func3 = 111  
func7 = 0000000   
32 bit pattern: 0000000_01000_00110_111_00111_0110011

```OR r8,r7,r5```  
Opcode for OR = 0110011  
rd = r8 = 01000  
rs1 = r7 = 00111  
rs2 = r8 = 00101  
func3 = 110  
func7 = 0000000   
32 bit pattern: 0000000_00101_00111_110_01000_0110011

```XOR r8,r6,r4```  
Opcode for XOR = 0110011  
rd = r8 = 01000  
rs1 = r6 = 00110  
rs2 = r4 = 00100  
func3 = 100  
func7 = 0000000  
32 bit pattern: 0000000_00100_00110_100_01000_0110011

```SLT r10,r2,r4```  
Opcode for SLT = 0110011  
rd = r10 = 01010  
rs1 = r2 = 00010  
rs2 = r4 = 00100  
func3 = 010  
func7 = 0000000  
32 bit pattern: 0000000_00100_010_01010_0110011

```SRL r16,r11,r2```  
Opcode for SRL = 0110011  
rd = r16 = 10000  
rs1 = r11 = 01011  
rs2 = r2 = 00010  
func3 = 101  
func7 = 0000000  
32 bit pattern: 0000000_00010_01011_101_10000_0110011  

```SLL r15,r11,r2```  
Opcode for SLL = 0110011  
rd = r15 = 011111  
rs1 = r11 = 01011 
rs2 = r2 = 00010
func3 = 001  
func7 = 0000000  
32 bit pattern: 0000000_00010_01011_001_01111_0110011  

## 2. I type instruction
It is designed for instructions that involve an immediate value and a register. These instructions typically perform operations like loading constants into registers, arithmetic and logical operations with immediate operands, and branching based on immediate conditions. Similar to R type, it is also not related to memory location. Here it is divided into 5 fields.
<img src="images/3.3 - Copy.png" alt="Image 3.3 - Copy">
opcode takes 7 bits of length  
rd takes 5 bits of length  
func3 takes 3 bits of length  
rs1 takes length of 5 bits  
12 bits signed immediate, **imm[11:0]** takes 12 bits of length. It provides the constant value used in the addition.  

Lets look at some of the examples

```ADDI r12,r3,5```  
Opcode for ADDI = 0010011  
rd = r12 = 01100  
rs1 = r3 = 00011  
imm[11:0] = 5 = 0000000000101  
func3 = 000  
32 bit pattern: 000000000101_00011_000_01100_0010011   

```LW r13,r11,2```  
Opcode for LW = 0000011  
rd = r12 = 01100  
rs1 = r3 = 01011  
imm[11:0] = 2 = 0000000000010  
func3 = 010  
32 bit pattern: 000000000010_01011_010_01101_0000011

## 3. S type instruction  
It is used for memory store operations. These instructions are responsible for storing data from a register into memory. It is divided into 6 fields.
<img src="images/3.4.png" alt="Image 3.4">
opcode takes 7 bits of length  
Immediate is of 12 bit signed immediate is encoded as follows -  
**imm[11:5] in bits [31:25]  
imm[4:0] in bits [11:7]**  
func3 takes 3 bits of length  
rs1 and rs2 takes length of 5 bits   

Let's look at an example  
```SW r3,r1,4```  
Opcode for SW = 0100011  
rs2 = r3 = 00011  
rs1 = r3 = 00001  
imm[11:0] = 4 = 0000000000100  
func3 = 010  
32 bit pattern: 0000000_00011_010_00100_0100011  

## 4. B type instruction 
 This instruction format is used for branching instructions, which are essential for controlling program flow based on conditions. It is divided into 8 fields.
 <img src="images/3.5.png" alt="Image 3.5">
 opcode takes 7 bits of length  
Immediate is of 12 bit signed immediate is encoded as follows -  
**imm[12] in bit [31]  
imm[10:5] in bits [25:30]  
imm[4:1] in bits [11:8]  
imm[11] on bit[7]**   
func3 takes 3 bits of length  
rs1 and rs2 takes length of 5 bits  
When the operation has been performed,  conditions is being checked and value of Programe Counter is being updated. If true,  
PC = Current PC value + Immediate  
If false,  
PC = Current PC value + 4 bytes  

Lets look at some of the examples  

```BNE r0,r1,20```  
Opcode = 1100011  
rs1 = r0 = 00000  
rs2 = r1 = 00001  
imm[12:1] = 20 = 000000010100  
func3 = 001  
32 bit pattern: 0_000001_00001_00000_001_0100_0_1100011  

```BEQ r0,r0,15```  
Opcode = 1100011  
rs1 = r0 = 00000  
rs2 = r0 = 00000  
imm[12:1] = 20 = 000000001111  
func3 = 000  
32 bit pattern: 0_000000_00000_00000_000_1111_0_1100011 

## 5. U type instruction  
It is used for instructions that require a large immediate value to be encoded directly within the instruction itself. This format is primarily used for operations that involve loading constants into registers. It is divided into 3 fields.
<img src="images/3.6.png" alt="Image 3.6">
opcode takes 7 bits of length  
rd takes 5 bits of length  
**imm[31:12]** takes 20 bits of length  

## 6. J type instruction  
This instruction is used for commands that allow programs to jump to different parts of their code. This is essential for tasks like repeating actions (loops), calling functions, and managing how instructions run. It is divided into 6 fields.  
<img src="images/3.7.png" alt="Image 3.7">
opcode takes 7 bits of length  
rd takes 5 bits of length  
Immediate is of 20 bit signed immediate is encoded as follows -  
**imm[19:12] in bit [19:12]  
imm[11] at bit [20]  
imm[10:1] in bits [30:21]  
imm[20] on bit[31]**







