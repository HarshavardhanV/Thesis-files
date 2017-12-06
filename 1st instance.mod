/*********************************************
 * OPL 12.6.3.0 Model
 * Author: Vempati's
 * Creation Date: Mar 10, 2016 at 7:40:07 PM
 *********************************************/

int n = ...;

range cities = 1 .. n;
int depot  = 1;
range k= 1..5;
float routes[k][cities];
int q[cities]=...;
int Q = 100;
float a[cities]=...;
float b[cities]=...;

float c[cities][cities];

// decision variables
dvar boolean x[cities][cities];
dvar float+ u[cities];

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

 dexpr float TotalDistance = sum ( i in cities, j in cities : j != i )c[i][j] * x[i][j];

// model

minimize
  TotalDistance;

subject to {
  forall ( j in cities: j!=1 )
    sum ( i in cities : i != j ) x[i][j] == 1;

  forall ( i in cities: i!=1)
    sum ( j in cities : j != i ) x[i][j] == 1;

  forall ( i in cities : i != 1, j in cities : j != 1 && i != j )
    u[i] - u[j] + Q* x[i][j] <= Q-q[j];
    
   forall ( i in cities : i != 1, j in cities : j != 1 && i != j )
     q[i] <= u[i]<=Q;
     
   sum(j in cities) x[1][j]==5;
   }


execute 
{

p=1;
l=1;
r=5;
i=1;
routes[p][l]=1;
while(p<r)
{
for(var j=1;j<=n;j++)
{
if (x[i][j]>0.9)
{
if(i==1)
{
f=j;
}
if (j != 1)
{
i=j;

j=1;
l=l+1;
routes[p][l]=i;

}
else 
{
j=f+1;
i=1;
p=p+1;
l=1;
routes[p][l]= 1;
}
}
}
}


for(var i= 1; i<=5;i++)
{writeln("");
   for(var j = 1;j<=32;j++)
   {
   write(routes[i][j]+" ");   
   }
}
} 