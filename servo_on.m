function servo_on(s)
WriteModBus(s, 40100, hex2dec('041E'));
WriteModBus(s, 40100, hex2dec('041F'));

WriteModBus(s, 40101, 0);

end