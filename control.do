vlib work
vlog graphicsNumber.v
vsim control

log {/*}
add wave {/*}

force {clock} 1 0ns, 0 {5ns} -r 10ns
force {done} 0
run 10 ns

force {done} 1
run 10 ns
run 10000ns