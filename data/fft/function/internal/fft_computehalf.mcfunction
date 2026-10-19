data modify storage fft:compute a0 set from storage fft:internal factors[0][0]
data modify storage fft:compute a1 set from storage fft:internal factors[0][1]
data modify storage fft:compute b0 set from storage fft:internal odd_cpy[0][0]
data modify storage fft:compute b1 set from storage fft:internal odd_cpy[0][1]

data modify storage fft:internal comp_result set value [0, 0]
execute store result storage fft:internal comp_result[0] float 0.000001 run compute default float fft:complex_mult_real
execute store result storage fft:internal comp_result[1] float 0.000001 run compute default float fft:complex_mult_ima
data modify storage fft:compute a0 set from storage fft:internal comp_result[0]
data modify storage fft:compute a1 set from storage fft:internal comp_result[1]
data modify storage fft:compute b0 set from storage fft:internal even_cpy[0][0]
data modify storage fft:compute b1 set from storage fft:internal even_cpy[0][1]

data modify storage fft:internal comp_result set value [0, 0]
execute store result storage fft:internal comp_result[0] float 0.000001 run compute default float fft:complex_add_real
execute store result storage fft:internal comp_result[1] float 0.000001 run compute default float fft:complex_add_ima
data modify storage fft:internal half append from storage fft:internal comp_result

data remove storage fft:internal factors[0]
data remove storage fft:internal odd_cpy[0]
data remove storage fft:internal even_cpy[0]

scoreboard players operation !counter fft_math += !1 fft_math
execute unless score !counter fft_math >= !countermax fft_math run function fft:internal/fft_computehalf