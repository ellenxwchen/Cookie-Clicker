vlib work
vlog graphicsNumber.v number0.v number1.v number2.v number3.v number4.v number5.v number6.v number7.v number8.v number9.v
vsim -L altera_mf_ver graphicsNumber

log {/*}
add wave {/*}

force {clock} 1 0ns, 0 {5ns} -r 10ns
force {Millions} 0011

run 10000ns