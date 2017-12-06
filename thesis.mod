/*********************************************
 * OPL 12.6.3.0 Model
 * Author: Vempati's
 * Creation Date: Mar 10, 2016 at 7:40:07 PM
 *********************************************/

int n = ...;

range cities = 1 .. n;
float a[cities]=...;
float b[cities]=...;

float c[cities][cities];

// decision variables
dvar boolean x[cities];
dvar float+ D;

execute
{

for ( var i = 1; i <= n; i++)
 {
    for ( var j = i+1; j <= n; j++) 
          {
      c[i][j] = Opl.sqrt(Opl.pow(a[i] - a[j], 2)
          + Opl.pow(b[i] - b[j], 2));
          
          }

}
}

execute
{

for ( var i = 1; i <= n; i++)
 {
    for ( var j = 1; j <= n; j++) 
          {
          	if (i!=j)
          	{
          	if (c[i][j]==0)
          	{
          	c[i][j]=c[j][i];          	
          	}          	
          	}          
          
      		write(c[i][j]+"\n");
          
          }

}
}
// expressions

// dexpr float TotalDistance = sum ( i in cities, j in cities : j != i )c[i][j] * x[i][j];

// model

minimize
  D;

subject to {
    sum ( i in cities ) x[i] == 2;

 

  forall ( i in cities, j in cities)
    if (i!=j)
    {
    c[i][j]*(1+5000*(1-x[i])+5000*(1-x[j])) >= D;
    
  }    
   D<=10;
 }   
 
 execute
 {
 for  ( var i = 1; i <= n; i++)
 {
 if (x[i]!=0)
 {
 write(i+"\n") ;
 } 
 }
 }