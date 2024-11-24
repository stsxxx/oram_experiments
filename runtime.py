ks = [ "dram","pathoram", "pageoram", "proram", "iroram"]
perf = [0] * 5
stash = []
cases = ["random_addr", "stream_addr", "redis", "mcf", "lbm", "pagerank", "orca", "dblp", "graphsearch", "criteo"]

for case in cases:

    for k in range(len(ks)):
        f = open("results_all42" + "/" + ks[k] + "_" + case + ".log", "r")

        for line in f.readlines():
            # if "Max stash size is:" in line:
            #     stash.append(line.split()[-1])
            if "The final time in ns is:" in line:
                perf[k] = float(line.split()[-2])
                # perf.append(float(line.split()[-2]))
                break
            # print(line)

    # assert(len(stash) == len(perf))
    print(case)
    # print("DRAM base time:", perf[-1])
    for i in range(len(perf)):
        if i < len(perf) - 1:  
            perf[i] /= 10
    # perf[-1] *= 10
    for i in range(len(perf)):
        print(perf[i])
    # perf[-1] *= 10
    # scale = perf[0]
    # for i in range(0, len(perf)):
    #     perf[i] /= scale

    # for i in range(0, len(perf)):
    #     print(ks[i], ' ', perf[i], ' vs. pathoram:', perf[1] / perf[i])

    