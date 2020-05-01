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
    Factor();
    /* signed multiplication a*b: %(esp)=a and eax=b */
    EmitLn("imull (%esp), %eax"); 
    /* push of the stack by modifying the stack pointer register */
    EmitLn("addl $4, %esp"); 
} 

void Divide()
{
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
    EmitLn("idivl (%esp)"); // signed division: it divides the content of the eax by (%esp)
    EmitLn("addl $4, %esp");

}
/*
void Variable(){


}*/

void Ident(){
    char name = GetName();
    if(Look == '('){
        Match('(');
        Match(')');
        sprintf(tmp,"jmp %c", name);
        EmitLn(tmp);
    } else{
        sprintf(tmp,"movl %c, %%eax", name);
        EmitLn(tmp);
    }
}


void Factor()
{   
    if(Look == '(') {
        Match('(');
        Expression();
        Match(')');
     } else if(IsAlpha(Look)){
         Ident();
     }
    else {
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
        }
    }
}

void Expression()
{
    if(IsAddop(Look))
        EmitLn("xor %eax, %eax"); // this is a way to create a 0 in the register eax, we do it to deal with unary minus
    else
        Term();

    while (strchr("+-", Look)) {  // strchr returns a pointer to the occurrences of character +- inside Look 
        sprintf(tmp,"movl $%c, %%eax", GetName());
        EmitLn(tmp);
        EmitLn("pushl %eax"); //push the 0 to the stack so if we have -3 now its 0-3

        switch(Look)
        {
            case '+':
                Add();
                break;
            case '-':
                Substract();
                break;
        }
    }
}


void Assignment(){
    Match("=");
    Expression();
    EmitLn("movl %eax");
    EmitLn("pushl %eax")
}


void Add()
{
    Term();
    EmitLn("addl (%esp), %eax");
    EmitLn("addl $4, %esp");  
    
}


void Substract()
{
    Term();
    EmitLn("subl (%esp), %eax");
    EmitLn("negl %eax");
    EmitLn("addl $4, %esp"); 
}


int main()
{
    Init();
    Assignment();
    return 0;
}