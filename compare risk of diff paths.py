import sys
import os

#argv='testcase.csv'
# recursive function to obtain the path as a string
def obtainPath(i, j):
    if dist[i][j] == float("inf"):
        return " no path to "
    if parent[i][j] == i:
        return " "
    else :
        return obtainPath(i, parent[i][j]) + str(parent[i][j]) + obtainPath(parent[i][j], j)

def new_obtainPath(i, j):
    if new_dist[i][j] == float("inf"):
        return " no path to "
    if new_parent[i][j] == i:
        return " "
    else :
        return new_obtainPath(i, new_parent[i][j]) + str(new_parent[i][j]) + new_obtainPath(new_parent[i][j], j)

#if len(sys.argv) < 2:
#	print "Check README for usage."
#	sys.exit(-1)
os.chdir(r"C:\Users\Vempati's\Desktop\thesis data files")

#Using Fil to open the file

try:	
	fil = open('link_distance.txt', "r")
except IOError:
	print "File not found."
	sys.exit(-1)


# no of vertices
V = int(fil.readline().strip())

# array of shortest path distances 
dist = []
new_dist=[]
risk=[]
# array of shortest paths
parent = []
new_parent=[]

# no of edges
E = int(fil.readline().strip())




# initialize to infinity
for i in range (0, V):
    dist.append([])
    new_dist.append([])
    parent.append([])
    new_parent.append([])
    risk.append([])
    for j in range (0, V):
        dist[i].append(float("inf"))
        new_dist[i].append(float("inf"))
        parent[i].append(0)
        risk[i].append(0)
        new_parent[i].append(0)




# read edges from input file and store
for i in range (0,E):
    t = fil.readline().strip().split()
    x = int(t[0])
    y = int(t[1])
    w = float(t[2])
    z=  float(t[3])
    dist[x][y] = z
    dist[y][x] = z
    new_dist[x][y] = z
    new_dist[y][x] = z
    risk[x][y] = w   
    risk[y][x] = w    
    parent[x][y] = x
    parent[y][x] = y
    new_parent[x][y] = x
    new_parent[y][x] = y      


# path from vertex to itself is set to 0
for i in range (0,V):
    dist[i][i] = 0
    new_dist[i][i]=0

    



# initialize the path matrix
for i in range (0,V):
    for j in range (0,V):
        if dist[i][j] == float("inf"):
            parent[i][j] = 0
        else:
            parent[i][j] = i



# actual floyd warshall algorithm
for k in range(0,V):
    for i in range(0,V):
        for j in range(0,V):
            if dist[i][j] > dist[i][k] + dist[k][j]:
                dist[i][j] = dist[i][k] + dist[k][j]
                parent[i][j] = parent[k][j]
                
                
candidate_set=['56', '42', '15', '60', '61', '62', '36', '64', '65', '66', '67', '82', 
'69', '81', '86', '87', '84', '85', '24', '26', '27', '20', '21', '48', '49', '46', '44',
'45', '28', '43', '41', '1', '0', '2', '3', '5', '4', '7', '6', '9', 
'68', '97', '83', '77', '98', '75', '74', '73', '72', '70', '90', '100', '101', '104', 
'78', '11', '10', '13', '38', '79', '14', '17', '76', '55', '32', 
'57', '30', '37', '50', '53', '34', '59', '18', '103', '12']

candidate_set=map(int,candidate_set)
candidate_set.sort()
for i in candidate_set:
    for j in candidate_set:
        if new_dist[i][j] == float("inf"):
            new_parent[i][j] = 0
        else:
            new_parent[i][j] = i
                  
for k in candidate_set:
    for i in candidate_set:
        for j in candidate_set:
            if new_dist[i][j]>new_dist[i][k] + new_dist[k][j]:
                new_dist[i][j] = new_dist[i][k] + new_dist[k][j]
                new_parent[i][j] = new_parent[k][j]

print candidate_set
candidate_set=map(str,candidate_set)


# display final paths
print "All Pairs Shortest Paths : \n"

# display shortest paths 
#for i in range (0,V):
#    for j in range (0,V):
#        print "From :", i+1, " To :", j+1
#        print "Path :", str(i+1) + obtainPath(i,j) + str(j+1)
#        print "Distance :", dist[i][j]
#        print
fil.close()
normal_distance=0
alternate_distance=0
new_fil = open('all_od_pairs.txt', "r")
new_fil=new_fil.readlines()
for i in new_fil:
    t = i.split()
    x = int(t[0])
    y = int(t[1])
    print "path :",x,y,' ',obtainPath(x,y), "Dist:", dist[x][y],'\n',"Alternate Shortest Path :", new_obtainPath(x,y), "Dist:",new_dist[x][y]
    normal_distance=normal_distance+dist[x][y]
    new_1=obtainPath(x,y)
    new_1=new_1.split()
    new_2=new_obtainPath(x,y)
    new_2=new_2.split()
    new=[]
    new.append(str(x))
    for i in new_1:
        if i!=' ':
            new.append(i)
    new.append(str(y))
    
    t_risk=0
    for a, b in zip(new, new[1:]):
        t_risk=t_risk+risk[int(a)][int(b)]
    
    print "total Risk :", t_risk   
    alternate_distance=alternate_distance+ t_risk 
    new=[]
    new.append(str(x))
    for i in new_2:
        if i!=' ':
            new.append(i)
    new.append(str(y))
    
    t_risk=0
    for a, b in zip(new, new[1:]):
        print a,b
        t_risk=t_risk+risk[int(a)][int(b)]
    
    print "total Risk for alternate path :", t_risk
    

print "total distance :", normal_distance
print "alternate_distance: ", alternate_distance    