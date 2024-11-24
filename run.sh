set -e
set -x 



# mkdir -p results/
# make -j

compile_ktree(){
ktree=$1  

sed -i '28d' src/reservation.h
sed -i '28i #define EMBED_DIM '''${ktree}'''' src/reservation.h


make -j

mv ramulator ramulator_${ktree}
mkdir -p results_${ktree}/
mkdir -p results_stream_${ktree}/

modes=("pathoram" "pageoram" "dram" "proram" "oram") # "ringoram" "idealoram")
# modes=("oram" "pathoram") # "ringoram" "idealoram")
# modes=("iroram" "dram" "proram")
modes=("pageoram") 
for mod in "${modes[@]}"
do
    # Echo each string
        echo "$mod"
    # ./ramulator_${ktree} configs/DDR4-config.cfg --mode=${mod} --stats my_output.txt dram.trace > results_${ktree}/${mod}.log &
    time ./ramulator_${ktree} configs/DDR4-config.cfg --mode=${mod} --stats ${mod}_1mr42b.txt random_addr_1000000.trace > results_${ktree}/${mod}_1mr42b.log &
done

wait
}

# modes=("dram" "pathoram" "ringoram" "idealoram" "oram")
# # modes=("oram" "idealoram")
# # modes=("dram" "pathoram" "ringoram")
ktrees=(2 3 4 5 6 7 8)
ktrees=(16)
for ktree in "${ktrees[@]}"
do
compile_ktree ${ktree}
done


# ./ramulator configs/DDR4-config.cfg --mode=${mod} --stats my_output.txt dram.trace > results/${mod}.log &

# gdb -ex=r --args ./ramulator configs/DDR4-config.cfg --mode="oram" --stats my_output.txt random_addr.trace > output.log
# gdb -ex=r --args ./ramulator configs/DDR4-config.cfg --mode="oram" --stats my_output.txt random_addr_1000.trace > output.log
# gdb --args ./ramulator configs/DDR4-config.cfg --mode="oram" --stats my_output.txt dram.trace | tee output.log

wait
echo "Finished"
python result.py
