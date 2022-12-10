nWave: 
	nWave &

clean:
	rm -rf INCA_libs \
	rm -rf nWaveLog \
	rm -rf novas.*

rtl:
	irun test_FFTP.v +access+r +notimingchecks -loadpli1 debpli:novas_pli_boot
