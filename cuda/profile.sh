#!/bin/bash

# run basic
cp makefiles/basic.make Makefile
cp headers/debug_basic.h debug.h
make clean && make
for size in 1024 2048 4096 do
    nvprof --analysis-metrics -o basic_$size.nvprof ./test $size
done

# run coa
cp makefiles/coa.make Makefile
cp headers/debug_coa.h debug.h
for blk in 16 32 do
    cp headers/Floyd_coa_$blk.h Floyd_coa.h
    make clean && make
    for size in 1024 2048 4096 do
        nvprof --analysis-metrics -o coa_$blk_$size.nvprof ./test $size
    done
done

# run sm
cp makefiles/sm.make Makefile
cp headers/debug_sm.h debug.h
for blk in 256 512 do
    cp headers/Floyd_sm_$blk.h Floyd_sm.h
    make clean && make
    for size in 1024 2048 4096 do
        nvprof --analysis-metrics -o sm_$blk_$size.nvprof ./test $size
    done
done

# run blk
cp makefiles/blk.make Makefile
cp headers/debug_blk.h debug.h
for blk in 16 32 do
    cp headers/Floyd_blk_$blk.h Floyd_blk.h
    make clean && make
    for size in 1024 2048 4096 do
        nvprof --analysis-metrics -o blk_$blk_$size.nvprof ./test $size
    done
done
