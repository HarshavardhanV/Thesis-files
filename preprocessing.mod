/*********************************************
 * OPL 12.6.3.0 Model
 * Author: Vempati's
 * Creation Date: Mar 14, 2016 at 11:32:56 AM
 *********************************************/
int n = ...;

range v = 1 .. n;
range k= 1..4;
float a[v]=...;
float b[v]=...;
float Vi[v]=...;
float c[v]=...;
float d[v]=...;
float w[v][k];
execute{
	for ( var i = 1; i <= n; i++)
	{
	w[i][1]=a[i];
    w[i][2]=b[i];
    w[i][3]=c[i];
    w[i][4]=d[i];	
	}
}

// decision variables
dvar boolean x[v];


// expressions

 dexpr float u = sum ( i in v )Vi[i] * x[i];

// model

maximize
  u;

subject to {

  forall ( j in k )
    sum ( i in v)w[i][j]*x[i]<= 600;

   }
