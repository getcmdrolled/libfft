data modify storage fft:internal in append from storage fft:internal in_cpy[0]
data remove storage fft:internal in_cpy[0]
data remove storage fft:internal in_cpy[0]

execute if data storage fft:internal in_cpy[0] run function fft:internal/fft_transfer_even