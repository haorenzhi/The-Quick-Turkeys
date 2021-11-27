from itertools import combinations

original_file = open("events.csv")
lines = original_file.readlines()
edges_dict = {}

#officerid, id, eventid
for ind,val in enumerate(lines):
    if val[0] == ',':
        lines[ind] = ' ' + lines[ind]
    lines[ind] = lines[ind].split(',')
    lines[ind][2] = lines[ind][2].strip('\n')
    for j in range(3):
        if lines[ind][0] != ' ':
            lines[ind][j] = int(lines[ind][j])

        else:
            del lines[ind]
            break
    eventid = lines[ind][2]
    if eventid not in edges_dict:
        edges_dict[eventid] = [lines[ind][0]] #adding officerid
    else:
        edges_dict[eventid].append(lines[ind][0])
output_file = open('edges.csv', "x")
for key in edges_dict.keys():
    if isinstance(key, int):
        officers = list(set(edges_dict[key]))
        edge_pairs = list(combinations(officers, 2))
        if key == 0:
            print(edge_pairs)
        for pair in edge_pairs:
            if pair[0] != pair[1]:
                output_file.write(str(pair[0]) + '\t' + str(pair[1]) + '\n')