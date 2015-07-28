/*

toufiq5.m
Author: Sheehan Toufiq
Account: stoufig1
Class: CSC 3210
Program #5
Due date: December 5, 2014

Description:

The following is an efficient program to perform the following functions on input strings. 

1. Ask the user to enter in a string of at most 15 characters. 
2. Print out the length of the string 
3. Print out if the string is a palindrome or not 
4. Ask the user to provide a character 
5. Print out the number of times the character is in the string 
6. Ask the user if they want to repeat for a new string 
7. If yes, then repeat steps 1-6, otherwise quit the program 

Here is a sample output: 
Please enter in a string of at most 15 characters: racecar 
The length of the string is 7 characters
The string is a palindrome 
Please enter a character: a 
The character 'a' appears 2 times 
Do you want to repeat for a new string (y/n): y 

Please enter in a string of at most 15 characters: racingcar 
The length of the string is 9 characters 
The string is not a palindrome 
Please enter a character: x 
The character 'a' appears 0 times 
Do you want to repeat for a new string (y/n): n 
Goodbye


Prompts
Please enter in a string of at most 15 characters:
The length of the string is %d characters \n

The string is a palindrome  \n
The string is not a palindrome

Please enter a character:
The character '%c'
appears %d times

Do you want to repeat for a new string (y/n):
Goodbye

*/

.section ".data"
		    input: .word 0                  !where the user input will be read in
		    mChoice: .byte 0								!store menu choice character
		    yesNo: .byte 0                  !store a character representing yes or no
		    nl: .asciz "\n"                 !where we dump the trailing newline input
		    format1: .asciz "%d%c"					!specify a decimal number (word) and a character
		    format2: .asciz "%c%c"          !specify two characters

		    promptA: .asciz "\nPlease enter in a string of at most 15 characters: "
		    promptB: .asciz "\nThe length of the string is %d characters."
		    promptC: .asciz "\nThe string is a palindrome."
		    promptD: .asciz "\nThe string is not a palindrome."

		    promptE: .asciz "\nPlease enter a character."
		    promptF: .asciz "\nThe character '%c' "
		    promptG: .asciz "appears %d times."
		    promptH: .asciz "\nDo you want to repeat for a string (y/n)? "
		    promptI: .asciz "\nGoodbye.\n"


.align 4
.global main
.section ".text"

main:
        save %sp, -96, %sp

