function servo_off(s)
WriteModBus(s, 40100, hex2dec('041F'));
WriteModBus(s, 40100, hex2dec('041E'));

end