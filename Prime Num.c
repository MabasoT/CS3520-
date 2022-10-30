/*
Authour: Ts'oanelo Mabaso
Date:    28-Oct-22
Function:The program prints out the first 10 reversible prime numbers 
*/

#include<stdio.h>

                  
                            
int sqr;                        //square


int primeNum(int n)                        //To check the prime number
{
	int count2 = 0;
	for(int i = 1; i <= n; i++)
	{
		if( n % i == 0 )
			count2++;
	}
	if(count2 == 2)
	{
		//printf("%d\n",1);
		return 1;
	}
	else
	{
		//printf("%d\n",0);
		return 0;	
	}
	
}

int reverseNum(int n)                //To reverse the number
{
	int reverse = 0;
	while(n != 0)
	{
		reverse = reverse*10 + n % 10;
		n /= 10;
	}
	return reverse;
}


int checkPal(int n, int m)      //To check if the numbers are palindromes or not
{
	if( n != m)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}


int CheckSquare(int m)              //This one is to check the square
{
	//int check = 0;
	for(int i = 2; i <= m ; i++)
	{
		if(m / i == i )
		{
			if(m % i == 0)
			{
				//printf("%d\n",1);
				return 1;					
			}
			else
			{
				//printf("%d\n",0);
				return 0;
			}			
		}

	}
	return 0;
}

int findSqrt(int m)
{
	
	for(int i = 2; i <= m ; i++)
	{
		if(m / i == i )
		{
			//printf("%d\n",i);
			return i;
		}

	}

}

int main()
{
	int rev;
	
	printf("The first 10 reversible prime square numbers are :\n");
	for(int count = 1, num = 1; count <= 10; num++)
	{
		if(primeNum(num))
		{
			
			sqr = num*num;
			rev = reverseNum(sqr);
			if(checkPal(sqr, rev))
			{
				if(CheckSquare(rev) && primeNum(findSqrt(rev)))
				{
					printf("%d\n",sqr);
					//printf("%d\n",count);
					count++;
					
				}
			
			}
			
		}
			
	}
	
	return 0;	
}