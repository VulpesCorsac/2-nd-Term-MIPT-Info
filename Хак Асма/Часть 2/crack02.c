#include <stdio.h>
#include <string.h>

int canary = 0;

void die()
{
	printf("You did it wrong, nasty boy!\n");
}

void doGreatWork()
{
	if( canary != 398 )
	{
		printf("Hack attempt detected!\nYOU. WILL. NOT. PASS.\n");
		return;
	}
	printf("Win!\n");
}

bool checkPass()
{
	char input[20];
	int i;
	printf("Enter password:\n");
	scanf("%s",&input[0]);
	for( i = 0; input[i] != '\0'; i++ )
		canary += input[i];
	return false;
}

void process()
{
	if( checkPass() )
		doGreatWork();
	else
		die();
}

int main()
{
	process();
	return 0;
}
