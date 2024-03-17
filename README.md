Author name: Laura Chudzio
Student Number: c00253150
Licence Details: swapCase © 2024 by Laura Chudzio is licensed under Attribution-NoDerivatives 4.0 International Attribution-NoDerivatives 4.0 International
Project description: "ASM Case Swap" is an assembly program for Linux, enabling users to toggle character cases within a string input. 
Through system calls and low-level text manipulation, it offers practical insights into system-level programming.

Instructions on producing an executable:

Step 1. Install NASM:
sudo apt-get install nasm

Step 2. Navigate to the Directory:
Open a terminal and navigate to the directory containing your swapCase.asm file using the cd command. For example:
cd /path/to/your/directory

Step 3. Assemble the Code:
Use NASM to assemble your swapCase.asm file into an object file:
nasm -f elf64 swapCase.asm -o swapCase.o
(If you're using a 32-bit system, replace elf64 with elf.)

Step 4. Link Object File:
Link the object file generated by NASM using the GNU linker (ld) to create an executable. 
Replace yourfile.o with the name of your object file.
ld swapCase.o -o swapCase

Step 5. Run the Executable:
./swapCase



Issues/Notes:
Loop Termination:

1. Ensuring that the loop in the swapcase function terminates correctly after processing all characters in the input string, 
avoiding infinite loops or premature exits.

2. Error: Label swapcase.end inconsistently redefined
his error occurs when a label is defined more than once within the same scope or conflicts with another label or symbol. 
