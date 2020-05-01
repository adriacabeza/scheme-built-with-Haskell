#include "cradle.h"
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>


void GetChar() 
{
    Look = getchar(); // gets a char as an unsigned char from stdin
}


void Error(char *s)
{
    printf("\nError: %s.", s);
}

void Abort(char *s)
{
    Error(s);
    exit(1);
}


void Expected(char *s)
{
    sprintf(tmp, "%s Expected", s);
    Abort(tmp);
}


void Match(char x)
{
    if(Look == x) {
        GetChar();
        SkipWhite();
    } else {
        sprintf(tmp, "' %c ' ",  x);
        Expected(tmp);
    }
}


int IsAlpha(char c)
{
    return (toupper(c) >= 'A') && (toupper(c) <= 'Z');
} 

int IsDigit(char c)
{
    return (c >= '0') && (c <= '9');
}

int isAlNum(char c)
{
    return ((isAlpha(c)) || (IsDigit(c)));
}

int IsAddop(char c)
{
    return (c == '+') || (c == '-');
}

int isWhite(char c
{
    return ((c == ' ') || (c == '\t'));

}

// TODO CHANGE GET NAME TO GET STRINGS AND GET NUM
char GetName()
{
    char c = Look;

    if( !IsAlpha(Look)) {
        sprintf(tmp, "Name");
        Expected(tmp);
    }

    GetChar();

    return toupper(c);
}


char GetNum()
{
    char c = Look;

    if( !IsDigit(Look)) {
        sprintf(tmp, "Integer");
        Expected(tmp);
    }

    GetChar();

    return c;
}

void Emit(char *s)
{
    printf("\t%s", s);
}

void EmitLn(char *s)
{
    Emit(s);
    printf("\n");
}


void SkipWhite(){
    while isWhite(Look){
        GetChar();
    }
}

void Init()
{
    /*
    printf("\t%s",".globl _main" );
    printf("\n");
    printf("%s","_main:" );
    */
    GetChar();
}
