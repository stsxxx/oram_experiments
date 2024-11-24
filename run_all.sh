mkdir -p results_all/
mkdir -p results/
func(){
    make -j

    workload=$1
    echo ${workload}
    sleep 2
    modes=("proram" "pathoram" "pageoram" "dram" "iroram") 
    # modes=("pathoram" "pageoram" "proram")
    for mod in "${modes[@]}"
    do
      path="./oram_traces/${workload}_1000000_prefetch_1.txt"
      ls ${path}
      time ./ramulator configs/DDR4-config.cfg --mode=${mod} --stats results/${mod}_${workload}.txt ${path} > results_all/${mod}_${workload}.log &
    done

    
}

workload="random_addr"
func $workload


workload="stream_addr"
func $workload
wait 

workload="redis"
func $workload


workload="mcf"
func $workload
wait

workload="lbm"
func $workload


workload="pagerank"
func $workload
wait

workload="dblp"
func $workload


workload="orca"
func $workload
wait

workload="graphsearch"
func $workload


workload="criteo"
func $workload
wait



echo "All finished"