vlib work
vlog graphicsNumber.v
vsim datapath

log {/*}
add wave {/*}

force {clock} 1 0ns, 0 {5ns} -r 10ns
force {drawMill} 1
force {Millions} 0011
force {numberColour3} 111
run 10000ns