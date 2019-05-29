onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Clock_Block_opt

do {wave.do}

view wave
view structure
view signals

do {Clock_Block.udo}

run -all

quit -force
