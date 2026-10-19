data modify storage fft:internal in_buf set value []
data modify storage fft:internal len_buf set value []
data modify storage fft:internal even_buf set value []
data modify storage fft:internal odd_buf set value []
data modify storage fft:internal out_buf set value []

data modify storage fft:internal in_buf prepend from storage fft:io in
function fft:internal/fft

data modify storage fft:io out set from storage fft:internal out_buf[0]
data remove storage fft:internal out_buf[0]