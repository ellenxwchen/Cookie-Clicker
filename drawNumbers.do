vlib work

vlog graphicsNumber.v

vsim drawNumbers

log {/*}
add wave {/*}

force {clock} 1 0ns, 0 {5ns} -r 10ns
force {initialX} 10100
force {initialY} 10100
force {reset} 1
run 10ns

force {reset} 0
run 10 ns

run 10000 ns