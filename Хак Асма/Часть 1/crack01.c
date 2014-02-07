#include <stdio.h>
#include <string.h>

int canary = 0;

void die()
{
	printf("You did it wrong, nasty boy!\n");
}

void doGreatWork()
{
	if( canary == 0 )
	{
		printf("Hack attempt detected!\nYOU. WILL. NOT. PASS.\n");
		return;
	}
	printf("Win!\n");
}

bool checkPass()
{
	char password = "\n";
	char input[20];
	int i;
	printf("Enter password:\n");
	scanf("%s",&input[0]);
	if( strcmp(input, password) == 0 ) {
		canary = 128;
		return true;
	}
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
