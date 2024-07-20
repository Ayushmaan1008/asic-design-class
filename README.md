
   
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


