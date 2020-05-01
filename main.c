#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "cradle.h"

void Term();
void Expression();
void Add();
void Substract();
void Factor();


void Multiply()
{
    Match('*');
    Factor();
    /* signed multiplication a*b: %(esp)=a and eax=b */
    EmitLn("imull (%esp), %eax"); 
    /* push of the stack by modifying the stack pointer register */
    EmitLn("addl $4, %esp"); 
} 

void Divide()
{
    Match('/');
    Factor();
    /* for a expression like a/b we have eax=b and %(esp)=a
     * but we need eax=a, and b on the stack 
     */
    EmitLn("movl (%esp), %edx");
    EmitLn("addl $4, %esp"); 

    EmitLn("pushl %eax"); //we push b on the stack

    EmitLn("movl %edx, %eax"); // we push a to eax

    /* 
     * SAR preserves the sign of the source operand by clearing empty bit positions
     * if the operand is positive and setting the mpety bits if the operand is 
     * is negative.
     */
    EmitLn("sarl $31, %edx"); 
    EmitLn("idivl (%esp)"); // signed division: it divides the content of the 64-bit integer EDX:EAX by (%esp)
    EmitLn("addl $4, %esp");

}

void Factor()
{

    if(Look == '(') {

        Match('(');
        Expression();
        Match(')');
     } else if(IsAddop(Look)) {

        Match('-');
        sprintf(tmp,"movl $%c, %%eax", GetNum());
        EmitLn(tmp);
        EmitLn("negl %eax");

    } else {

        sprintf(tmp,"movl $%c, %%eax", GetNum());
        EmitLn(tmp);
    }
}

void Term()
{
    Factor();
    while (strchr("*/", Look)) {

        EmitLn("pushl %eax");

        switch(Look)
        {
            case '*':
                Multiply();
                break;
            case '/':
                Divide();
                break;
            default:
                Expected("Mulop");
        }
    }
}

void Expression()
{
    if(IsAddop(Look))
        EmitLn("xor %eax, %eax"); // this is a way to create a 0 in the register eax
    else
        Term();

    while (strchr("+-", Look)) {  // strchr returns a pointer to the occurrences of character +- inside Look 

        EmitLn("pushl %eax"); //push the value of the eax register to the stack

        switch(Look)
        {
            case '+':
                Add();
                break;
            case '-':
                Substract();
                break;
            default:
                Expected("Addop");
        }
    }
}


void Add()
{
    Match('+');
    Term();
    EmitLn("addl (%esp), %eax");
    EmitLn("addl $4, %esp");  
    
}


void Substract()
{
    Match('-');
    Term();
    EmitLn("subl (%esp), %eax");
    EmitLn("negl %eax");
    EmitLn("addl $4, %esp"); 
}


int main()
{
    Init();
    Expression();
    return 0;
}