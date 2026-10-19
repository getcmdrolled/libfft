data modify storage fft:internal half1 append from storage fft:internal half2[0]
data remove storage fft:internal half2[0]

execute if data storage fft:internal half2[0] run function fft:internal/fft_concathalves