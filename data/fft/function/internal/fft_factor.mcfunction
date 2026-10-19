execute store result storage fft:compute idx int 1 run scoreboard players get !counter fft_math

data modify storage fft:internal comp_result set value [0, 0]
execute store result storage fft:internal comp_result[0] float 0.000001 run compute default float fft:factor_real
execute store result storage fft:internal comp_result[1] float 0.000001 run compute default float fft:factor_ima
data modify storage fft:internal factors append from storage fft:internal comp_result

scoreboard players operation !counter fft_math += !1 fft_math
execute unless score !counter fft_math >= !countermax fft_math run function fft:internal/fft_factor