import numpy as np
data = np.loadtxt('officer_beat.txt',dtype=str,encoding='utf-8', delimiter = '\t')
start=0
end=0
result=[]
while end<np.shape(data)[0]:
    while end<np.shape(data)[0] and data[end][0]==data[start][0]:
        end=end+1
    for i in range(start,end):
        for j in range(i+1,end):
            result.append([int(data[i][1]),int(data[j][1])])
    start=end
np.savetxt("officer_beat_refine.txt",result,delimiter='\t',fmt='%d')
