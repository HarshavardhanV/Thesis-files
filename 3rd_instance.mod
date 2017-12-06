/*********************************************
 * OPL 12.6.3.0 Model
 * Author: Vempati's
 * Creation Date: Mar 10, 2016 at 8:40:50 PM
 *********************************************/
int n = ...;

range cities = 1 .. n;
int depot  = 1;
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
    for ( var j = 1; j <= n; j++) 
          {
      c[i][j] = Opl.sqrt(Opl.pow(a[i] - a[j], 2)
          + Opl.pow(b[i] - b[j], 2));
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
     
   sum(j in cities) x[1][j]==6;
   }