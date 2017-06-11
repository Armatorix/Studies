#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <gmp.h>
#include <string.h>
#include<sys/time.h>

struct timeval t1, t2;
struct timespec ts1, ts2;
long long elapsedTime;


mpz_t privatekey, 
	publickey,
	module;
	
gmp_randstate_t rstate;

int size;

void generateBigRandom(mpz_t num,int bytes)
{
	mpz_urandomb(num,rstate,bytes);
	mpz_abs(num,num);
}


int isPrime(mpz_t number)
{
	mpz_t iter,sqrOfIter,rest;
	mpz_init(iter);mpz_init(rest);mpz_init(sqrOfIter);
	
	if(!mpz_cmp_ui(number,1))
	{
		return 0;
	}
	mpz_mod_ui(iter,number,2);
	if(!mpz_cmp_ui(iter,0))
	{
		return 0;
	}	
	
	mpz_set_ui(iter, 3);
	mpz_mul(sqrOfIter,iter,iter);
	while(mpz_cmp(sqrOfIter,number)<=0)
	{
		
		mpz_mod(rest,number,iter);
		if(!mpz_sgn(rest))
		{
			return 0;
		}
		mpz_add_ui(iter,iter,2);
		mpz_mul(sqrOfIter,iter,iter);
	}
	return 1;
}


void generateBigPrime(mpz_t numb)
{
	mpz_t temp;
	mpz_init(temp);
	
	generateBigRandom(numb,size);
	mpz_mod_ui(temp,numb,2);
	
	if(!mpz_cmp_ui(temp,0))
		{
		mpz_add_ui(numb,numb,1);
		}
	while (!isPrime(numb))
		{
		mpz_add_ui(numb,numb,2);
		}
}
void nwd(mpz_t ret, mpz_t a, mpz_t b)
{
	mpz_t t,b_temp, a_temp;
	mpz_init(t);mpz_init(b_temp);mpz_init(a_temp);
	
	mpz_set(b_temp,b);
	mpz_set(a_temp,a);
	
	while(mpz_cmp_ui(b_temp,0))
	{
		mpz_set(t,b_temp);
		mpz_mod(b_temp,a_temp,b_temp);
		mpz_set(a_temp,t);
	}
	mpz_set(ret,a_temp);
}
int isCoPrime(mpz_t a, mpz_t b)
{
	mpz_t ret;
	mpz_init(ret);
	
	nwd(ret,a,b);
	if(!mpz_cmp_ui(ret,1))
	{
		return 1;
	}
	else
	{
		return 0;
	}
}
void coPrimeGen(mpz_t toGenerate, mpz_t generator)
{
	mpz_t temp;
	mpz_init(temp);
	
	generateBigRandom(toGenerate,size);
	mpz_mod_ui(temp,toGenerate,2);
	if(!mpz_cmp_ui(temp,0))
	{
		mpz_add_ui(toGenerate,toGenerate,1);
	}
	while(!isCoPrime(generator,toGenerate))
	{
		mpz_add_ui(toGenerate,toGenerate,2);
		mpz_mod(toGenerate,toGenerate,generator);
	}
	
}


void computePrivkey(mpz_t ret, mpz_t a, mpz_t n)
{
	
	mpz_t a0, n0,p0,p1,q,r,t;
	mpz_init(a0);mpz_init(n0);mpz_init(p0);mpz_init(p1);mpz_init(q);mpz_init(r);mpz_init(t);
	
	mpz_set_ui(p0,0);
	mpz_set_ui(p1,1);
	mpz_set(a0,a);
	mpz_set(n0,n);
	mpz_div(q,n0,a0);
	mpz_mod(r,n0,a0);
	
	while(mpz_cmp_ui(r,0)>0)
	{
		mpz_mul(t,q,p1);
		mpz_sub(t,p0,t);
		if(mpz_cmp_ui(t,0)>=0)
		{
			mpz_mod(t,t,n);
		}
		else
		{
			mpz_neg(t,t);
			mpz_mod(t,t,n);
			mpz_sub(t,n,t);
		}
		mpz_set(p0,p1);
		mpz_set(p1,t);
		mpz_set(n0,a0);
		mpz_set(a0,r);
		mpz_div(q,n0,a0);
		mpz_mod(r,n0,a0);
	}
	mpz_set(ret,p1);
}

void generateKeys()
{
	mpz_t p,q,fiN,e,d,n;
	mpz_init(p);mpz_init(q);mpz_init(fiN);mpz_init(e);mpz_init(d);mpz_init(n);
	
	generateBigPrime(p);
	generateBigPrime(q);
	
	mpz_mul(n,p,q);
	mpz_sub_ui(p,p,1);
	mpz_sub_ui(q,q,1);
	mpz_mul(fiN,p,q);
	
	coPrimeGen(e,fiN);
	computePrivkey(d,e,fiN);
	
	mpz_set(module, n);
	mpz_set(privatekey, d);
	mpz_set(publickey, e);
}
//fast powering meth
//mod module
void modPower(mpz_t ret, mpz_t base, mpz_t pow)
{
	mpz_t temp;
	mpz_init(temp);
	mpz_mod_ui(temp,pow,2);
	if(!mpz_cmp_ui(pow,0))
	{
	mpz_set_ui(ret,1);
	}
	else if(!mpz_cmp_ui(temp,1))
	{
		mpz_sub_ui(pow,pow,1);
		modPower(ret,base,pow);
		mpz_mul(ret,base,ret);
			
	}
	else
	{
		mpz_div_ui(pow,pow,2);
		modPower(ret,base, pow);
		mpz_mul(ret,ret,ret);
	}
	mpz_mod(ret,ret,module);	
}

void cryptMessage(mpz_t out ,mpz_t in)
{
	mpz_t message,crypted,temp,temp2,key;
	mpz_init(message);mpz_init(crypted);mpz_init(temp);mpz_init(temp2);mpz_init(key);
	
	mpz_set(message,in);
	mpz_set_ui(crypted,0);
	
	while(mpz_cmp_ui(message,0))
	{
		mpz_set(key,publickey);
		mpz_mod(temp,message,module);
		
		mpz_mul(crypted,crypted,module);
		mpz_div(message,message,module);
		modPower(temp2,temp,key);
		mpz_add(crypted,crypted,temp2);
	}
	mpz_set(out,crypted);

}



void decryptMessage(mpz_t out ,mpz_t in)
{
	mpz_t message, key, crypted, temp, temp2;
	mpz_init(key);mpz_init(message);mpz_init(crypted);mpz_init(temp);mpz_init(temp2);
	
	mpz_set(message,in);
	mpz_set_ui(crypted,0);
	
	while(mpz_cmp_ui(message,0))
	{
		mpz_set(key,privatekey);
		mpz_mod(temp,message,module);
		
		mpz_mul(crypted,crypted,module);
		mpz_div(message,message,module);
		modPower(temp2,temp,key);
		mpz_add(crypted,crypted,temp2);
	}
	mpz_set(out,crypted);

}

void decryptMessageConstant(mpz_t out ,mpz_t in)
{
	mpz_t message, key, crypted, temp, temp2;
	mpz_init(key);mpz_init(message);mpz_init(crypted);mpz_init(temp);mpz_init(temp2);
	
	mpz_set(message,in);
	mpz_set_ui(crypted,0);
	
	while(mpz_cmp_ui(message,0))
	{
		mpz_set(key,privatekey);
		mpz_mod(temp,message,module);
		
		mpz_mul(crypted,crypted,module);
		mpz_div(message,message,module);
		modPowerConst(temp2,temp,key);
		mpz_add(crypted,crypted,temp2);
	}
	mpz_set(out,crypted);

}

void decryptMessageMask(mpz_t out ,mpz_t in)
{
	mpz_t message, key, crypted, temp, temp2,mask,maskC;
	mpz_init(key);mpz_init(message);mpz_init(crypted);mpz_init(temp);mpz_init(temp2);mpz_init(mask);mpz_init(maskC);
	
	
	mpz_set(message,in);
	mpz_set_ui(crypted,0);
	generateBigRandom(mask,3);
	cryptMessage(maskC,mask);
	mpz_mul(message,maskC,message);
	while(mpz_cmp_ui(message,0))
	{
		mpz_set(key,privatekey);
		mpz_mod(temp,message,module);
		
		mpz_mul(crypted,crypted,module);
		mpz_div(message,message,module);
		modPower(temp2,temp,key);
		mpz_add(crypted,crypted,temp2);
	}
	mpz_div(crypted,crypted,mask);
	mpz_set(out,crypted);

}


void initCrypter()
{
	size=32;
	mpz_init(privatekey);
	mpz_init(publickey);
	mpz_init(module);
	
	srand(time(0));
	unsigned long long seed;
	seed = rand();
	seed = (seed << 32) | rand();
	
	gmp_randinit_mt(rstate);
	gmp_randseed_ui(rstate,seed);
}
int main()
{
	mpz_t crypted,mess,temp;
	initCrypter();mpz_init(crypted);mpz_init(temp);mpz_init(mess);
	generateKeys();
	gmp_printf("Priv:\n%Zd\nPublic:\n%Zd\nModul:\n%Zd\n", privatekey, publickey, module);
	mpz_set_ui(mess,66666);
	gmp_printf("Message:\n%Zd\n", mess);
	cryptMessage(mess,mess);
	gmp_printf("Message crypted:\n%Zd\n", mess);
	decryptMessageMask(mess,mess);
	gmp_printf("Message decrypted:\n%Zd\n", mess);

}
