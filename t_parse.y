%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "t2c.h"
	#include "t_parse.h"
%}

%token lWRITE lREAD lIF lASSIGN
%token lRETURN lBEGIN lEND
%left  lEQU lNEQ lGT lLT lGE lLE
%left  lADD lMINUS
%left  lTIMES lDIVIDE
%token lLP lRP
%token lINT lREAL lSTRING
%token lELSE
%token lMAIN
%token lSEMI lCOMMA
%token lID lINUM lRNUM lQSTR

%expect 1

%%
prog	:	mthdcls
		{ printf("Program -> MethodDecls\n");
		  printf("Parsed OK!\n"); }
	|
		{ printf("****** Parsing failed!\n"); }	
	;

mthdcls	:	mthdcl mthdcls
		{ printf("MethodDecls -> MethodDecl MethodDecls\n"); }	
	|	mthdcl
		{ printf("MethodDecls -> MethodDecl\n"); }	
	;

type	:	lINT
		{ printf("Type -> INT\n"); }	
	|	lREAL
		{ printf("Type -> REAL\n"); }	
	;

mthdcl	:	type lMAIN lID lLP formals lRP block
		{ printf("MethodDecl -> Type MAIN ID LP Formals RP Block\n"); }	
	|	type lID lLP formals lRP block
		{ printf("MethodDecl -> Type ID LP Formals RP Block\n"); }	
	;

formals	:	formal oformal
		{ printf("Formals -> Formal OtherFormals\n"); }	
	|
		{ printf("Formals -> \n"); }	
	;

formal	:	type lID
		{ printf("Formal -> Type ID\n"); }	
	;

oformal	:	lCOMMA formal oformal
		{ printf("OtherFormals -> COMMA Formal OtherFormals\n"); }	
	|
		{ printf("OtherFormals -> \n"); }	
	;


block	:	lBEGIN Stmts lEND
		{printf("Block -> BEGIN Statements End \n");}
Stmts	:	stmt OStmts
		{printf("Statements ->Statement OtherStatements \n");}
OStmts	:	stmt OStmts
		{printf("OtherStatements ->Statement OtherStatements \n");}
	|
		{printf("OtherStatements -> \n");}
stmt	:	block
		{printf("Statement -> Block \n");}
	|	lvdecl
		{printf("Statement -> LocalVarDecl \n");}
	|	Assignstmt
		{printf("Statement -> AssignStmt \n");}
	|	Returnstmt
		{printf("Statement -> ReturnStmt \n");}
	|	Ifstmt 
		{printf("Statement -> IfStmt \n");}
	|	Writestmt
		{printf("Statement -> WriteStmt \n");}
	|	Readstmt 
		{printf("Statement -> ReadStmt \n");}
lvdecl	:	type lID lSEMI
		{printf("LocalVarDecl -> Type Id ‘;‘ \n");}
	|type Assignstmt
		{printf("LocalVarDecl -> Type AssignStmt \n");}


Assignstmt	:	lID lASSIGN exp lSEMI
		{printf("AssignStmt -> Id := Expression ‘;’ \n");}
Returnstmt	:	lRETURN exp lSEMI
		{printf("ReturnStmt -> RETURN Expression ‘;’ \n");}
Ifstmt	:	lIF lLP boolexp lRP stmt
		{printf("IfStmt -> IF ‘(‘ BoolExpression ‘)’ Statement \n");}
	|	lIF lLP boolexp lRP stmt lELSE stmt
		{printf("IfStmt -> IF ‘(‘ BoolExpression ‘)’ Statement ELSE Statement \n");}
Writestmt	:	lWRITE lLP exp lCOMMA lQSTR lRP lSEMI
		{printf("WriteStmt -> WRITE ‘(‘ Expression ‘,’ QString ‘)’ ‘;’ \n");}
Readstmt	:	lREAD lLP  lID lCOMMA lQSTR lRP lSEMI 
		{printf("ReadStmt -> READ ‘(‘ Id ‘,’ QString ‘)’ ‘;’ \n");}

exp	:	Multiexp oexp
		{printf("xpression -> MultiplicativeExpr oexp \n");}
oexp	:	lADD Multiexp oexp
		{printf("oexp -> ‘+’ MultiplicativeExpr oexp ‘;’ \n");}
	|	lMINUS Multiexp oexp
		{printf("oexp -> ‘-’ MultiplicativeExpr oexp ‘;’ \n");}
	|
		{printf("oexp ->  \n");}

Multiexp	:	Primaryexp oMultiexp
		{printf("MultiplicativeExpr -> PrimaryExpr oMultiexp \n");}

oMultiexp	:	lTIMES Primaryexp oMultiexp
		{printf("oMultiexp -> ‘*’ PrimaryExpr oMultiexp\n");}
	|	lDIVIDE Primaryexp oMultiexp
		{printf("oMultiexp -> ‘/’ PrimaryExpr oMultiexp\n");}
	|
		{printf("oMultiexp -> \n");}

Primaryexp	:	lINUM 
		{printf("PrimaryExpr -> Integer numbers\n");}
	|	lRNUM
		{printf("PrimaryExpr -> Real numbers\n");}
	|	lID
		{printf("PrimaryExpr -> Id\n");}
	|	lLP exp lRP
		{printf("PrimaryExpr -> ‘(’ Expression ‘)’\n");}
	|	lID lLP Actualparams lRP
		{printf("PrimaryExpr -> Id ‘(’ ActualParams ‘)’\n");}

boolexp	:	exp lEQU exp
		{printf("BoolExpr -> Expression ‘==’ Expression\n");}
	|	exp lNEQ exp
		{printf("BoolExpr -> Expression ‘!=’ Expression\n");}
	|	exp lGT exp
		{printf("BoolExpr -> Expression ‘>’ Expression\n");}
	|	exp lGE exp
		{printf("BoolExpr -> Expression ‘>=’ Expression\n");}
	|	exp lLT exp
		{printf("BoolExpr -> Expression ‘<’ Expression\n");}
	|	exp lLE exp
		{printf("BoolExpr -> Expression ‘<=’ Expression\n");}
Actualparams	:	exp oActualparams         
		{printf("ActualParams -> Expression oActualparams \n");}
	|
		{printf("ActualParams -> \n");}
oActualparams	:	lCOMMA exp oActualparams
		{printf("oActualparams -> ‘,’ Expression oActualparams \n");}
	|
		{printf("oActualparams -> \n");}

%%

int yyerror(char *s)
{
	printf("%s\n",s);
	return 1;
}

