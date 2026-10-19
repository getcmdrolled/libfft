# get len
execute store result storage fft:internal len int 1 run data get storage fft:internal in_buf[0]
data modify storage fft:internal len_buf prepend from storage fft:internal len

# check len 1
execute if data storage fft:internal {len:1} run data modify storage fft:internal out_buf prepend value [[0, 0.0f]]
execute if data storage fft:internal {len:1} run data modify storage fft:internal out_buf[0][0][0] set from storage fft:internal in_buf[0][0]
execute if data storage fft:internal {len:1} run data remove storage fft:internal in_buf[0]
execute if data storage fft:internal {len:1} run data remove storage fft:internal len_buf[0]
execute if data storage fft:internal {len:1} run return 0

# get even item
data modify storage fft:internal in set value []
data modify storage fft:internal in_cpy set from storage fft:internal in_buf[0]
function fft:internal/fft_transfer_even
data modify storage fft:internal in_buf prepend from storage fft:internal in
function fft:internal/fft
data modify storage fft:internal even_buf prepend from storage fft:internal out_buf[0]
data remove storage fft:internal out_buf[0]

# get odd item
data modify storage fft:internal in set value []
data modify storage fft:internal in_cpy set from storage fft:internal in_buf[0]
function fft:internal/fft_transfer_odd
data modify storage fft:internal in_buf prepend from storage fft:internal in
function fft:internal/fft
data modify storage fft:internal odd_buf prepend from storage fft:internal out_buf[0]
data remove storage fft:internal out_buf[0]

# calculate factor
data modify storage fft:internal factors set value []
data modify storage fft:compute inlen set from storage fft:internal len_buf[0]
execute store result score !countermax fft_math run data get storage fft:compute inlen
scoreboard players set !counter fft_math 0
function fft:internal/fft_factor

# get & calculate first half of result
data modify storage fft:internal half set value []
data modify storage fft:internal even_cpy set from storage fft:internal even_buf[0]
data modify storage fft:internal odd_cpy set from storage fft:internal odd_buf[0]
execute store result score !countermax fft_math run data get storage fft:internal len_buf[0] 0.5
scoreboard players set !counter fft_math 0
function fft:internal/fft_computehalf
data modify storage fft:internal half1 set from storage fft:internal half

# get & calculate second half of result (using old factors to just keep going)
data modify storage fft:internal half set value []
data modify storage fft:internal odd_cpy set from storage fft:internal odd_buf[0]
data modify storage fft:internal even_cpy set from storage fft:internal even_buf[0]
execute store result score !countermax fft_math run data get storage fft:internal len_buf[0] 0.5
scoreboard players set !counter fft_math 0
function fft:internal/fft_computehalf
data modify storage fft:internal half2 set from storage fft:internal half

# concatenate two halves
function fft:internal/fft_concathalves

# return
data remove storage fft:internal even_buf[0]
data remove storage fft:internal odd_buf[0]
data remove storage fft:internal in_buf[0]
data remove storage fft:internal len_buf[0]
data modify storage fft:internal out_buf prepend from storage fft:internal half1