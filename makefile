include mkflags

all: testfile

build: Folder CenCtrl.o CLA.o Sum.o CSA.o Mod.o Pipe.o Mux.o NTT.o PhiFuc.o SPMB.o bluestein.o configurable_BFFT.o

testfile: FFTC.o build
	g++ $(LDFLAGS) -o testfile test_file.cc NTT.o PhiFuc.o SPMB.o bluestein.o \
FFTC.o configurable_BFFT.o CLA.o  Sum.o CSA.o Mod.o Pipe.o Mux.o CenCtrl.o -lntl -lgmp -lm -pthread

testV2C: 
	g++ $(LDFLAGS) -o V2C.exe test_vtoc.cc -lntl -lgmp -lm
 
FFTC.o: FFTC.cc FFTC.h

configurable_BFFT.o: configurable_BFFT.cc  configurable_BFFT.h

CenCtrl.o: CenCtrl.cc CenCtrl.h

Sum.o: Sum.cc Sum.h

CSA.o: CSA.cc CSA.h

Pipe.o: Pipe.cc Pipe.h

Mod.o: Mod.cc Mod.h

Mux.o: Mux.cc Mux.h

CLA.o: CLA.cc CLA.h

NTT.o: NTT.cc NTT.h

PhiFuc.o:PhiFuc.cc PhiFuc.h

SPMB.o:SPMB.cc SPMB.h

bluestein.o: bluestein.cc bluestein.h
#####################################################################################################################################################
##Comand all (This comand) only for radix-16
##      R16_ALL:
##             perfrom  SRAM , ROM_R16 and simulation 
##
#####################################################################################################################################################
R16_ALL: SRAM ROM_R16
	cd $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P ; \
	irun test_FFTP.v +access+r +notimingchecks -loadpli1 debpli:novas_pli_boot
R16_ALL_COVERAGE: SRAM ROM_R16
	cd $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P ; \
	irun test_FFTP.v +access+r +notimingchecks -coverage all
#R16_ALL_SYN: SRAM_syn ROM_R16_syn LIB_TO_DB SYN 
R16_ALL_SYN: SRAM_syn LIB_TO_DB SYN
	cd $(FFTC_PATH)/syn/dv ; \
	dc_shell -f syn_script_r16.tcl
	cp $(FFTC_PATH)/syn/gate_netlist/* $(FFTC_PATH)/syn/vlog
	cd $(FFTC_PATH)/syn/vlog ; \
	irun test_FFTP.v +access+r -timescale 1ns/1ps +ncnontcglitch -loadpli1 debpli:novas_pli_boot
R16_CONFIG_ALL: SRAM_CONFIG ROM_CONFIG_R16
	cd $(FFTC_PATH)/BFFTP/Configurable_BFFT ; \
	irun test_FFTP.v +access+r +notimingchecks
R16_CONFIG_ALL_COVERAGE: SRAM_CONFIG ROM_CONFIG_R16
	cd $(FFTC_PATH)/BFFTP/Configurable_BFFT ; \
	irun test_FFTP.v +access+r +notimingchecks -coverage all
R16_CONFIG_ALL_SYN: SRAM_CONFIG_syn ROM_CONFIG_R16_syn LIB_TO_DB CONFIG_SYN
	cd $(FFTC_PATH)/syn/dv ; \
	dc_shell -f syn_script_Reconfigure_r16.tcl
	cp $(FFTC_PATH)/syn/gate_netlist/* $(FFTC_PATH)/syn/vlog
	cd $(FFTC_PATH)/syn/vlog ; \
	irun test_FFTP.v +access+r -timescale 1ns/1ps +ncnontcglitch
#####################################################################################################################################################
##Comand all (This comand) only for radix-8
##      R16_ALL:
##             perfrom  SRAM , ROM_R8 and simulation 
##
#####################################################################################################################################################
R8_ALL: SRAM ROM_R8
	cd $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P ; \
	irun test_FFTP.v +access+r +notimingchecks
R8_ALL_SYN: SRAM_syn ROM_R8_syn LIB_TO_DB SYN
	cd $(FFTC_PATH)/syn/dv ; \
	dc_shell -f syn_script_r8.tcl
	cp $(FFTC_PATH)/syn/gate_netlist/* $(FFTC_PATH)/syn/vlog
	cd $(FFTC_PATH)/syn/vlog ; \
	irun test_FFTP.v +access+r -timescale 1ns/1ps +ncnontcglitch
#####################################################################################################################################################
##Comand all (This comand) only for radix-4
##      R4_ALL:
##             perfrom  SRAM , ROM_ND and simulation 
##
#####################################################################################################################################################
R4_ALL: SRAM ROM_ND
	cd $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P ; \
	irun test_FFTP.v +access+r +notimingchecks
R4_ROM_ALL: SRAM ROM
	cd $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P ; \
	irun test_FFTP.v +access+r +notimingchecks
R4_ALL_SYN: SRAM_syn ROM_ND_syn LIB_TO_DB SYN
	cd $(FFTC_PATH)/syn/dv ; \
	dc_shell -f syn_script_r4.tcl
	cp $(FFTC_PATH)/syn/gate_netlist/* $(FFTC_PATH)/syn/vlog
	cd $(FFTC_PATH)/syn/vlog ; \
	irun test_FFTP.v +access+r -timescale 1ns/1ps +ncnontcglitch
#####################################################################################################################################################
## Pre simulation command:
##   Frist  command ------------>  SRAM
##   Final command ------------>  ROM or ROM_ND or ROM_R16 ( ROM and ROM_ND are commands for Radix-4 , ROM_R16 for Radix-16
##
####################################################################################################################################################
SRAM: SRAM_Folder 
	$(sram_path)  verilog -mux $(MUX) \
	-bits $(double_bit_size) -instname $(instname)  -frequency $(Freq) -words $(sram_word_size)
	cp $(instname).v  $(FFTC_PATH)/BFFTP
	mv $(instname).v  ./SRAM
SRAM_CONFIG: SRAM_Folder
	$(sram_path)  verilog -mux $(MUX) \
	-bits $(double_bit_size) -instname $(instname)  -frequency $(Freq) -words $(sram_word_size)
	$(sram_path)  verilog -mux $(MUX) \
	-bits $(bit_size) -instname $(instname_64)  -frequency $(Freq) -words $(sram_word_size)
	cp $(instname).v  $(FFTC_PATH)/BFFTP
	mv $(instname).v  ./SRAM
	cp $(instname_64).v  $(FFTC_PATH)/BFFTP
	mv $(instname_64).v  ./SRAM	
SRAM_Folder:
	 mkdir -p SRAM
Folder:
	cd $(FFTC_PATH); mkdir -p ROM_Data
	cd $(FFTC_PATH); mkdir -p BFFTP
	cd $(FFTC_PATH); mkdir -p Reconfigure
	cd $(FFTC_PATH); mkdir -p syn_tcl
	cd $(FFTC_PATH); mkdir -p test_input
	cp $(FFTC_PATH)/A_in.txt $(FFTC_PATH)/test_input
#################################################################################################
#ROM Gen
ROM: ROM_F ROM_I PRE_r4 REORDER 
	cd $(ROMDATA_PATH) ; \
	cp $(ROMDATA_PATH)/*.v    $(FFTC_PATH)/BFFTP
	cp $(ROMDATA_PATH)/*.rcf  $(FFTC_PATH)/BFFTP
	cd $(FFTC_PATH)/BFFTP; mkdir -p R$(RADIX)_$(FFT_POINT)P	
	cd $(FFTC_PATH)/BFFTP; mkdir -p R$(RADIX)_$(FFT_POINT)P/data	
	mv $(FFTC_PATH)/BFFTP/*.v  $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P
	mv $(FFTC_PATH)/BFFTP/*.rcf  $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P
	mv $(FFTC_PATH)/test_input/*.txt  $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P/data
	rm $(ROMDATA_PATH)/*.v
	rm $(ROMDATA_PATH)/*.rcf
##################################################################################################
#ROM Gen
ROM_ND: R4_ROM_ND PRE_ND_r4 REORDER 
	cd $(ROMDATA_PATH) ; \
	cp $(ROMDATA_PATH)/*.v    $(FFTC_PATH)/BFFTP
	cp $(ROMDATA_PATH)/*.rcf  $(FFTC_PATH)/BFFTP
	cd $(FFTC_PATH)/BFFTP; mkdir -p R$(RADIX)_$(FFT_POINT)P	
	cd $(FFTC_PATH)/BFFTP; mkdir -p R$(RADIX)_$(FFT_POINT)P/data	
	mv $(FFTC_PATH)/BFFTP/*.v  $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P
	mv $(FFTC_PATH)/BFFTP/*.rcf  $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P
	mv $(FFTC_PATH)/test_input/*.txt  $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P/data
	rm $(ROMDATA_PATH)/*.v
	rm $(ROMDATA_PATH)/*.rcf
#################################################################################################
ROM_R8: ROM_R8_F ROM_R8_I REORDER_r8 PRE_r8
	cd $(ROMDATA_PATH) ; \
	cp $(ROMDATA_PATH)/*.v    $(FFTC_PATH)/BFFTP
	cp $(ROMDATA_PATH)/*.rcf  $(FFTC_PATH)/BFFTP
	cd $(FFTC_PATH)/BFFTP; mkdir -p R$(RADIX)_$(FFT_POINT)P	
	cd $(FFTC_PATH)/BFFTP; mkdir -p R$(RADIX)_$(FFT_POINT)P/data	
	mv $(FFTC_PATH)/BFFTP/*.v  $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P
	mv $(FFTC_PATH)/BFFTP/*.rcf  $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P
	mv $(FFTC_PATH)/test_input/*.txt  $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P/data
	rm $(ROMDATA_PATH)/*.v
	rm $(ROMDATA_PATH)/*.rcf
#####################################################################################################################################################
ROM_R16: ROM_R16_F ROM_R16_I REORDER_r16 PRE_r16
	cd $(ROMDATA_PATH) ; \
	cp $(ROMDATA_PATH)/*.v    $(FFTC_PATH)/BFFTP
	cp $(ROMDATA_PATH)/*.rcf  $(FFTC_PATH)/BFFTP
	cd $(FFTC_PATH)/BFFTP; mkdir -p R$(RADIX)_$(FFT_POINT)P	
	cd $(FFTC_PATH)/BFFTP; mkdir -p R$(RADIX)_$(FFT_POINT)P/data	
	mv $(FFTC_PATH)/BFFTP/*.v  $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P
	mv $(FFTC_PATH)/BFFTP/*.rcf  $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P
	mv $(FFTC_PATH)/test_input/*.txt  $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P/data
	rm $(ROMDATA_PATH)/*.v
	rm $(ROMDATA_PATH)/*.rcf
#####################################################################################################################################################
ROM_CONFIG_R16: ROM_R16_F ROM_R16_I
	cd $(ROMDATA_PATH) ; \
	cp $(ROMDATA_PATH)/*.v    $(FFTC_PATH)/BFFTP
	cp $(ROMDATA_PATH)/*.rcf  $(FFTC_PATH)/BFFTP
	cd $(FFTC_PATH)/BFFTP; mkdir -p Configurable_BFFT	
	cd $(FFTC_PATH)/BFFTP; mkdir -p Configurable_BFFT/data	
	cd $(FFTC_PATH)/BFFTP; mkdir -p Configurable_BFFT/data/$(FFT_POINT)P
	mv $(FFTC_PATH)/BFFTP/*.v  $(FFTC_PATH)/BFFTP/Configurable_BFFT
	mv $(FFTC_PATH)/BFFTP/*.rcf  $(FFTC_PATH)/BFFTP/Configurable_BFFT
	mv $(FFTC_PATH)/test_input/*.txt  $(FFTC_PATH)/BFFTP/Configurable_BFFT/data
	mv $(FFTC_PATH)/Reconfigure/*.txt  $(FFTC_PATH)/BFFTP/Configurable_BFFT/data
	cp $(FFTC_PATH)/BFFTP/Configurable_BFFT/data/*.txt  $(FFTC_PATH)/BFFTP/Configurable_BFFT/data/$(FFT_POINT)P
	cp $(FFTC_PATH)/BFFTP/Configurable_BFFT/test_FFTP.v $(FFTC_PATH)/BFFTP/Configurable_BFFT/data/$(FFT_POINT)P
	rm $(ROMDATA_PATH)/*.v
	rm $(ROMDATA_PATH)/*.rcf
#####################################################################################################################################################
## Gate - level
## Systhesis command:
##   Frist  command ------------>  SRAM_syn
##   Second command ------------>  ROM_syn or ROM_ND_syn or ROM_R16_syn ( ROM_syn and ROM_ND_syn are commands for Radix-4 , ROM_R16_syn for Radix-16
##   Third  command ------------>  LIB_TO_DB 
##   Final  command ------------>  SYN
####################################################################################################################################################
SYN:
	cp -r $(FFTC_PATH)/BFFTP/R$(RADIX)_$(FFT_POINT)P/*  $(FFTC_PATH)/syn/vlog
	cp $(FFTC_PATH)/syn_tcl/*.tcl  $(FFTC_PATH)/syn/dv
	cp $(FFTC_PATH)/syn_tcl/*.v  $(FFTC_PATH)/syn/gate_netlist/
CONFIG_SYN:
	cp -r $(FFTC_PATH)/BFFTP/Configurable_BFFT/*  $(FFTC_PATH)/syn/vlog
	cp $(FFTC_PATH)/syn_tcl/*.tcl  $(FFTC_PATH)/syn/dv
	cp $(FFTC_PATH)/syn_tcl/*.v  $(FFTC_PATH)/syn/gate_netlist/
SYN_Folder:
	mkdir -p syn
	cd $(FFTC_PATH)/syn ; mkdir -p lib
SRAM_syn:SYN_Folder
	$(sram_path)  synopsys -mux $(MUX) \
	-bits $(double_bit_size) -instname $(instname) -libname $(instname) -frequency $(Freq) -words $(sram_word_size)
	mv $(FFTC_PATH)/*.lib  $(FFTC_PATH)/syn/lib
SRAM_CONFIG_syn:SYN_Folder
	$(sram_path)  synopsys  -mux $(MUX) \
	-bits $(double_bit_size) -instname $(instname) -libname $(instname) -frequency $(Freq) -words $(sram_word_size)
	$(sram_path)  synopsys -spec $(specname) -mux $(MUX) \
	-bits $(bit_size) -instname $(instname_64) -libname $(instname_64) -frequency $(Freq) -words $(sram_word_size)	
	mv $(FFTC_PATH)/*.lib  $(FFTC_PATH)/syn/lib
#################################################################################################
#ROM Gen
#Radix-4
ROM_syn:SYN_Folder ROM_F_syn ROM_I_syn PRE_r4_syn REORDER_syn
	mv $(ROMDATA_PATH)/*.lib $(FFTC_PATH)/syn/lib
#################################################################################################
#ROM Gen
#Radix-4 
ROM_ND_syn: SYN_Folder R4_ROM_ND_syn PRE_ND_r4_syn REORDER_syn
	mv $(ROMDATA_PATH)/*.lib  $(FFTC_PATH)/syn/lib	
#################################################################################################
# Radix-8
ROM_R8_syn:  ROM_R8_F_syn ROM_R8_I_syn REORDER_r8_syn PRE_r8_syn
	mv $(ROMDATA_PATH)/*.lib  $(FFTC_PATH)/syn/lib
################################################################################################
# Radix-16 
#ROM_R16_syn: ROM_R16_F_syn ROM_R16_I_syn REORDER_r16_syn PRE_r16_syn
ROM_R16_syn: ROM_R16_I_syn REORDER_r16_syn PRE_r16_syn
	mv $(ROMDATA_PATH)/*.lib  $(FFTC_PATH)/syn/lib
################################################################################################
ROM_CONFIG_R16_syn: ROM_R16_F_syn ROM_R16_I_syn
	mv $(ROMDATA_PATH)/*.lib  $(FFTC_PATH)/syn/lib
################################################################################################
#libaray compiler 
#lc_schell
LIB_TO_DB:
	cp $(FFTC_PATH)/lc_script.tcl  $(FFTC_PATH)/syn/lib
	cd $(FFTC_PATH)/syn/lib ; \
	lc_shell -f  $(FFTC_PATH)/syn/lib/lc_script.tcl
	cd $(FFTC_PATH)/syn ; mkdir -p Mem_lib
	mv $(FFTC_PATH)/syn/lib/*.db  $(FFTC_PATH)/syn/Mem_lib
###############################################################################################
#No divided into number banks
R4_ROM_ND:R4_ROM0 R4_ROM1 R4_IROM0 R4_IROM1

R4_ROM0:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname ROM0 \
	-code_file $(instnamer4ROM0) -mux $(MUX) -words $(rom_word_size_N4D) \
	-bits $(bit_size) -frequency $(Freq)
R4_ROM1:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname ROM1 \
	-code_file $(instnamer4ROM1) -mux $(MUX) -words $(rom_word_size_N4D) \
	-bits $(double_bit_size) -frequency $(Freq)
R4_IROM0:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname IROM0 \
	-code_file $(Iinstnamer4ROM0) -mux $(MUX) -words $(rom_word_size_N4D) \
	-bits $(bit_size) -frequency $(Freq)
R4_IROM1:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname IROM1 \
	-code_file $(Iinstnamer4ROM1) -mux $(MUX) -words $(rom_word_size_N4D) \
	-bits $(double_bit_size) -frequency $(Freq)
###############################################################################################
#Forward
ROM_F: ROMr0d0 ROMr0d1 ROMr0d2 ROMr0d3 ROMr1d0 ROMr1d1 ROMr1d2 ROMr1d3

ROMr0d0:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname R0D0_$(rom_word_size)_$(bit_size) \
	-code_file $(instnamer0d0) -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
ROMr0d1:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname R0D1_$(rom_word_size)_$(bit_size) \
	-code_file $(instnamer0d1) -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
ROMr0d2:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname R0D2_$(rom_word_size)_$(bit_size) \
	-code_file $(instnamer0d2) -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
ROMr0d3:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname R0D3_$(rom_word_size)_$(bit_size) \
	-code_file $(instnamer0d3) -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
ROMr1d0:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname R1D0_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamer1d0) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
ROMr1d1:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname R1D1_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamer1d1) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
ROMr1d2:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname R1D2_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamer1d2) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
ROMr1d3:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname R1D3_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamer1d3) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
###############################################################################################
ROM_I: IROMr0d0 IROMr0d1 IROMr0d2 IROMr0d3 IROMr1d0 IROMr1d1 IROMr1d2 IROMr1d3

IROMr0d0:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname IR0D0_$(rom_word_size)_$(bit_size) \
	-code_file $(Iinstnamer0d0) -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
IROMr0d1:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname IR0D1_$(rom_word_size)_$(bit_size) \
	-code_file $(Iinstnamer0d1) -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
IROMr0d2:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname IR0D2_$(rom_word_size)_$(bit_size) \
	-code_file $(Iinstnamer0d2) -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
IROMr0d3:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname IR0D3_$(rom_word_size)_$(bit_size) \
	-code_file $(Iinstnamer0d3) -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
IROMr1d0:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname IR1D0_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamer1d0) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
IROMr1d1:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname IR1D1_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamer1d1) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
IROMr1d2:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname IR1D2_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamer1d2) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
IROMr1d3:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname IR1D3_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamer1d3) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
#################################################################################################
#re-order and inverse re-order factor 
REORDER:reROM0 reROM1 ireROM0 ireROM1

reROM0:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname reorderROM0 \
	-code_file $(reorderROM0) -mux $(reorder_MUX) -words $(reROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
reROM1:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname reorderROM1 \
	-code_file $(reorderROM1) -mux $(reorder_MUX) -words $(reROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
ireROM0:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname ireorderROM0 \
	-code_file $(ireorderROM0) -mux $(reorder_MUX) -words $(IreROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
ireROM1:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname ireorderROM1 \
	-code_file $(ireorderROM1) -mux $(reorder_MUX) -words $(IreROM_word_size) \
	-bits $(IReROM1_BIT_SIZE) -frequency $(Freq)

#################################################################################################
PRE_ND_r4:b0ROM0_r4 b0ROM1_r4 b1ROM0_r4 b1ROM1_r4 

b0ROM0_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname H_b0ROM0 \
	-code_file $(H_b0ROM0_r4) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM1_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname H_b0ROM1 \
	-code_file $(H_b0ROM1_r4) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM0_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b1ROM0 \
	-code_file $(H_b1ROM0_r4) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM1_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname H_b1ROM1 \
	-code_file $(H_b1ROM1_r4) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
#################################################################################################
PRE_r4:b0r0_r4 b0r1_r4 b0r2_r4 b0r3_r4 b1r0_r4 b1r1_r4 b1r2_r4 b1r3_r4

b0r0_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname H_b0r0 \
	-code_file $(H_b0r0_r4_mux16) -mux $(MUX_16) -words $(H2rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
b0r1_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname H_b0r1 \
	-code_file $(H_b0r1_r4_mux16) -mux $(MUX_16) -words $(H2rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
b0r2_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname H_b0r2 \
	-code_file $(H_b0r2_r4_mux16) -mux $(MUX_16) -words $(H2rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
b0r3_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname H_b0r3 \
	-code_file $(H_b0r3_r4_mux16) -mux $(MUX_16) -words $(H2rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
b1r0_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname H_b1r0 \
	-code_file $(H_b1r0_r4_mux16) -mux $(MUX_16) -words $(H2rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
b1r1_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname H_b1r1 \
	-code_file $(H_b1r1_r4_mux16) -mux $(MUX_16) -words $(H2rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
b1r2_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname H_b1r2 \
	-code_file $(H_b1r2_r4_mux16) -mux $(MUX_16) -words $(H2rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
b1r3_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog -instname H_b1r3 \
	-code_file $(H_b1r3_r4_mux16) -mux $(MUX_16) -words $(H2rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
###############################################################################################
R4_ROM_ND_syn:R4_ROM0_syn R4_ROM1_syn R4_IROM0_syn R4_IROM1_syn

R4_ROM0_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname ROM0 \
	-code_file $(instnamer4ROM0) -libname ROM0 -mux $(MUX) -words $(rom_word_size_N4D) \
	-bits $(bit_size) -frequency $(Freq)
R4_ROM1_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname ROM1 \
	-code_file $(instnamer4ROM1) -libname ROM1 -mux $(MUX) -words $(rom_word_size_N4D) \
	-bits $(double_bit_size) -frequency $(Freq)
R4_IROM0_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname IROM0 \
	-code_file $(Iinstnamer4ROM0) -libname IROM0 -mux $(MUX) -words $(rom_word_size_N4D) \
	-bits $(bit_size) -frequency $(Freq)
R4_IROM1_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname IROM1 \
	-code_file $(Iinstnamer4ROM1) -libname IROM1 -mux $(MUX) -words $(rom_word_size_N4D) \
	-bits $(double_bit_size) -frequency $(Freq)	
#################################################################################################
#Forward
ROM_F_syn: ROMr0d0_syn ROMr0d1_syn ROMr0d2_syn ROMr0d3_syn ROMr1d0_syn ROMr1d1_syn ROMr1d2_syn ROMr1d3_syn

ROMr0d0_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname R0D0_$(rom_word_size)_$(bit_size)  \
	-code_file $(instnamer0d0) -libname R0D0 -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
ROMr0d1_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname R0D1_$(rom_word_size)_$(bit_size)  \
	-code_file $(instnamer0d1) -libname R0D1 -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
ROMr0d2_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname R0D2_$(rom_word_size)_$(bit_size)  \
	-code_file $(instnamer0d2) -libname R0D2 -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
ROMr0d3_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname R0D3_$(rom_word_size)_$(bit_size)  \
	-code_file $(instnamer0d3) -libname R0D3 -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
ROMr1d0_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname R1D0_$(rom_word_size)_$(double_bit_size)  \
	-code_file $(instnamer1d0) -libname R1D0 -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
ROMr1d1_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname R1D1_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamer1d1) -libname R1D1 -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
ROMr1d2_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname R1D2_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamer1d2) -libname R1D2 -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
ROMr1d3_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname R1D3_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamer1d3) -libname R1D3 -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
###############################################################################################
ROM_I_syn: IROMr0d0_syn IROMr0d1_syn IROMr0d2_syn IROMr0d3_syn IROMr1d0_syn IROMr1d1_syn IROMr1d2_syn IROMr1d3_syn

IROMr0d0_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname IR0D0_$(rom_word_size)_$(bit_size) \
	-code_file $(Iinstnamer0d0) -libname IR0D0 -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
IROMr0d1_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname IR0D1_$(rom_word_size)_$(bit_size) \
	-code_file $(Iinstnamer0d1) -libname IR0D1 -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
IROMr0d2_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname IR0D2_$(rom_word_size)_$(bit_size) \
	-code_file $(Iinstnamer0d2) -libname IR0D2 -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
IROMr0d3_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname IR0D3_$(rom_word_size)_$(bit_size) \
	-code_file $(Iinstnamer0d3) -libname IR0D3 -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
IROMr1d0_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname IR1D0_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamer1d0) -libname IR1D0 -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
IROMr1d1_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname IR1D1_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamer1d1) -libname IR1D1 -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
IROMr1d2_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname IR1D2_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamer1d2) -libname IR1D2 -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
IROMr1d3_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname IR1D3_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamer1d3) -libname IR1D3 -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
#################################################################################################
#re-order and inverse re-order factor 
REORDER_syn:reROM0_syn reROM1_syn ireROM0_syn ireROM1_syn

reROM0_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname reorderROM0 \
	-code_file $(reorderROM0) -libname reorderROM0 -mux $(reorder_MUX) -words $(reROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
reROM1_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname reorderROM1 \
	-code_file $(reorderROM1) -libname reorderROM1 -mux $(reorder_MUX) -words $(reROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
ireROM0_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname ireorderROM0 \
	-code_file $(ireorderROM0) -libname ireorderROM0 -mux $(reorder_MUX) -words $(IreROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
ireROM1_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ireorderROM1 \
	-code_file $(ireorderROM1) -libname ireorderROM1 -mux $(reorder_MUX) -words $(IreROM_word_size) \
	-bits $(IReROM1_BIT_SIZE) -frequency $(Freq)
#################################################################################################
PRE_ND_r4_syn:b0ROM0_syn_r4 b0ROM1_syn_r4 b1ROM0_syn_r4 b1ROM1_syn_r4 

b0ROM0_syn_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0ROM0 \
	-code_file $(H_b0ROM0_r4) -libname H_b0ROM0 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM1_syn_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0ROM1 \
	-code_file $(H_b0ROM1_r4) -libname H_b0ROM1 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM0_syn_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1ROM0 \
	-code_file $(H_b1ROM0_r4) -libname H_b1ROM0 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM1_syn_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1ROM1 \
	-code_file $(H_b1ROM1_r4) -libname H_b1ROM1 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)	
#################################################################################################
PRE_r4_syn:b0r0_syn_r4 b0r1_syn_r4 b0r2_syn_r4 b0r3_syn_r4 b1r0_syn_r4 b1r1_syn_r4 b1r2_syn_r4 b1r3_syn_r4  

b0r0_syn_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0r0 \
	-code_file $(H_b0r0_r4_mux16) -libname H_b0r0 -mux $(MUX_16) -words $(H2rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
b0r1_syn_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0r1 \
	-code_file $(H_b0r1_r4_mux16) -libname H_b0r1 -mux $(MUX_16) -words $(H2rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
b0r2_syn_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0r2 \
	-code_file $(H_b0r2_r4_mux16) -libname H_b0r2 -mux $(MUX_16) -words $(H2rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
b0r3_syn_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0r3 \
	-code_file $(H_b0r3_r4_mux16) -libname H_b0r3 -mux $(MUX_16) -words $(H2rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
b1r0_syn_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1r0 \
	-code_file $(H_b1r0_r4_mux16) -libname H_b1r0 -mux $(MUX_16) -words $(H2rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
b1r1_syn_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1r1 \
	-code_file $(H_b1r1_r4_mux16) -libname H_b1r1 -mux $(MUX_16) -words $(H2rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
b1r2_syn_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1r2 \
	-code_file $(H_b1r2_r4_mux16) -libname H_b1r2 -mux $(MUX_16) -words $(H2rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
b1r3_syn_r4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1r3 \
	-code_file $(H_b1r3_r4_mux16) -libname H_b1r3 -mux $(MUX_16) -words $(H2rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
##############################################################################################
##  Radix-8   Command  
##   
#############################################################################################
#radix-8 ROM DATA 
#Forward
ROM_R8_F: R8_ROM0 R8_ROM1 R8_ROM2  R8_ROM3

R8_ROM0:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ROM0 \
	-code_file $(instnamer8ROM0) -mux $(MUX) -words $(rom_word_size_r8) \
	-bits $(bit_size) -frequency $(Freq)
R8_ROM1:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ROM1 \
	-code_file $(instnamer8ROM1) -mux $(MUX) -words $(rom_word_size_r8) \
	-bits $(double_bit_size) -frequency $(Freq)
R8_ROM2:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ROM2 \
	-code_file $(instnamer8ROM2) -mux $(MUX) -words $(rom_word_size_r8) \
	-bits $(double_bit_size) -frequency $(Freq)
R8_ROM3:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ROM3 \
	-code_file $(instnamer8ROM3) -mux $(MUX) -words $(rom_word_size_r8) \
	-bits $(double_bit_size) -frequency $(Freq)
#radix-16 inverse twiddle factor rom 
ROM_R8_I: R8_IROM0 R8_IROM1 R8_IROM2 R8_IROM3

R8_IROM0:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname IROM0 \
	-code_file $(Iinstnamer8ROM0) -mux $(MUX) -words $(rom_word_size_r8) \
	-bits $(bit_size) -frequency $(Freq)
R8_IROM1:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname IROM1 \
	-code_file $(Iinstnamer8ROM1) -mux $(MUX) -words $(rom_word_size_r8) \
	-bits $(double_bit_size) -frequency $(Freq)
R8_IROM2:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname IROM2 \
	-code_file $(Iinstnamer8ROM2) -mux $(MUX) -words $(rom_word_size_r8) \
	-bits $(double_bit_size) -frequency $(Freq)
R8_IROM3:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname IROM3 \
	-code_file $(Iinstnamer8ROM3) -mux $(MUX) -words $(rom_word_size_r8) \
	-bits $(double_bit_size) -frequency $(Freq)
#################################################################################################
#radix-8 reorder
#if Cyclotomic prime is 22 bits ,then rom5 bit size is 32-bits,
#cyclotomic prime is 23~25 bits,then rom5 bit size is 64 bits.
REORDER_r8:reROM0_r8 reROM1_r8 reROM2_r8 reROM3_r8 \
ireROM0_r8 ireROM1_r8  ireROM2_r8 

reROM0_r8:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname reorderROM0 \
	-code_file $(reorderROM0_R8) -mux $(MUX) -words $(reROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
reROM1_r8:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname reorderROM1 \
	-code_file $(reorderROM1_R8) -mux $(MUX) -words $(reROM_word_size) \
	-bits $(reROM_r8_bitsize) -frequency $(Freq)
reROM2_r8:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname reorderROM2 \
	-code_file $(reorderROM2_R8) -mux $(MUX) -words $(reROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
reROM3_r8:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname reorderROM3 \
	-code_file $(reorderROM3_R8) -mux $(MUX) -words $(reROM_word_size) \
	-bits $(reROM_r8_bitsize) -frequency $(Freq)
ireROM0_r8:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ireorderROM0 \
	-code_file $(ireorderROM0_R8) -mux $(MUX) -words $(IreROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
ireROM1_r8:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ireorderROM1 \
	-code_file $(ireorderROM1_R8) -mux $(MUX) -words $(IreROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
ireROM2_r8:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ireorderROM2 \
	-code_file $(ireorderROM2_R8) -mux $(MUX) -words $(IreROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
#ireROM3_r16:
#	cd $(ROMDATA_PATH) ; \
#	$(rodsd_path) verilog  -instname ireorderROM3 \
#	-code_file $(ireorderROM3_R8) -mux $(MUX) -words $(IreROM_word_size) \
#	-bits $(bit_size) -frequency $(Freq)
#################################################################################################
PRE_r8:b0ROM0_r8 b0ROM1_r8 b0ROM2_r8 b0ROM3_r8 \
b1ROM0_r8 b1ROM1_r8 b1ROM2_r8 b1ROM3_r8 

b0ROM0_r8:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b0ROM0 \
	-code_file $(H_b0ROM0_r8) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM1_r8:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b0ROM1 \
	-code_file $(H_b0ROM1_r8) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM2_r8:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b0ROM2 \
	-code_file $(H_b0ROM2_r8) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM3_r8:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b0ROM3 \
	-code_file $(H_b0ROM3_r8) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM0_r8:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b1ROM0 \
	-code_file $(H_b1ROM0_r8) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM1_r8:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b1ROM1 \
	-code_file $(H_b1ROM1_r8) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM2_r8:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b1ROM2 \
	-code_file $(H_b1ROM2_r8) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM3_r8:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b1ROM3 \
	-code_file $(H_b1ROM3_r8) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
##############################################################################################
##  Radix-8   synthesizer command
##
##  ROM , IROM , Reorder Synthesizer command
##############################################################################################
ROM_R8_F_syn: R8_ROM0_syn R8_ROM1_syn R8_ROM2_syn R8_ROM3_syn

R8_ROM0_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ROM0 \
	-code_file $(instnamer8ROM0) -libname ROM0 -mux $(MUX) -words $(rom_word_size_r8) \
	-bits $(bit_size) -frequency $(Freq)
R8_ROM1_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname ROM1 \
	-code_file $(instnamer8ROM1) -libname ROM1 -mux $(MUX) -words $(rom_word_size_r8) \
	-bits $(double_bit_size) -frequency $(Freq)
R8_ROM2_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ROM2 \
	-code_file $(instnamer8ROM2) -libname ROM2 -mux $(MUX) -words $(rom_word_size_r8) \
	-bits $(double_bit_size) -frequency $(Freq)
R8_ROM3_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ROM3 \
	-code_file $(instnamer8ROM3) -libname ROM3 -mux $(MUX) -words $(rom_word_size_r8) \
	-bits $(double_bit_size) -frequency $(Freq)

ROM_R8_I_syn:R8_IROM0_syn R8_IROM1_syn R8_IROM2_syn R8_IROM3_syn

R8_IROM0_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname IROM0 \
	-code_file $(Iinstnamer8ROM0) -libname IROM0 -mux $(MUX) -words $(rom_word_size_r8) \
	-bits $(bit_size) -frequency $(Freq)
R8_IROM1_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys -instname IROM1 \
	-code_file $(Iinstnamer8ROM1) -libname IROM1 -mux $(MUX) -words $(rom_word_size_r8) \
	-bits $(double_bit_size) -frequency $(Freq)
R8_IROM2_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname IROM2 \
	-code_file $(Iinstnamer8ROM2) -libname IROM2 -mux $(MUX) -words $(rom_word_size_r8) \
	-bits $(double_bit_size) -frequency $(Freq)
R8_IROM3_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname IROM3 \
	-code_file $(Iinstnamer8ROM3) -libname IROM3 -mux $(MUX) -words $(rom_word_size_r8) \
	-bits $(double_bit_size) -frequency $(Freq)
#################################################################################################
#radix-8 reorder
#if Cyclotomic prime is 22 bits ,then rom5 bit size is 32-bits,
#cyclotomic prime is 23~25 bits,then rom5 bit size is 64 bits.
#################################################################################################
REORDER_r8_syn:reROM0_r8_syn reROM1_r8_syn reROM2_r8_syn reROM3_r8_syn \
ireROM0_r8_syn ireROM1_r8_syn  ireROM2_r8_syn 

reROM0_r8_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname reorderROM0 \
	-code_file $(reorderROM0_R8) -libname reorderROM0 -mux $(MUX) -words $(reROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
reROM1_r8_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname reorderROM1 \
	-code_file $(reorderROM1_R8) -libname reorderROM1 -mux $(MUX) -words $(reROM_word_size) \
	-bits $(reROM_r8_bitsize) -frequency $(Freq)
reROM2_r8_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname reorderROM2 \
	-code_file $(reorderROM2_R8) -libname reorderROM2 -mux $(MUX) -words $(reROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
reROM3_r8_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname reorderROM3 \
	-code_file $(reorderROM3_R8) -libname reorderROM3 -mux $(MUX) -words $(reROM_word_size) \
	-bits $(reROM_r8_bitsize) -frequency $(Freq)
ireROM0_r8_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ireorderROM0 \
	-code_file $(ireorderROM0_R8) -libname ireorderROM0 -mux $(MUX) -words $(IreROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
ireROM1_r8_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ireorderROM1 \
	-code_file $(ireorderROM1_R8) -libname ireorderROM1 -mux $(MUX) -words $(IreROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
ireROM2_r8_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ireorderROM2 \
	-code_file $(ireorderROM2_R8) -libname ireorderROM2 -mux $(MUX) -words $(IreROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
#ireROM3_r16:
#	cd $(ROMDATA_PATH) ; \
#	$(rodsd_path) verilog  -instname ireorderROM3 \
#	-code_file $(ireorderROM3_R8) -mux $(MUX) -words $(IreROM_word_size) \
#	-bits $(bit_size) -frequency $(Freq)
#################################################################################################
PRE_r8_syn:b0ROM0_r8_syn b0ROM1_r8_syn b0ROM2_r8_syn b0ROM3_r8_syn \
b1ROM0_r8_syn b1ROM1_r8_syn b1ROM2_r8_syn b1ROM3_r8_syn 

b0ROM0_r8_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0ROM0 \
	-code_file $(H_b0ROM0_r8) -libname H_b0ROM0 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM1_r8_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0ROM1 \
	-code_file $(H_b0ROM1_r8) -libname H_b0ROM1 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM2_r8_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0ROM2 \
	-code_file $(H_b0ROM2_r8) -libname H_b0ROM2 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM3_r8_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0ROM3 \
	-code_file $(H_b0ROM3_r8) -libname H_b0ROM3 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM0_r8_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1ROM0 \
	-code_file $(H_b1ROM0_r8) -libname H_b1ROM0 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM1_r8_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1ROM1 \
	-code_file $(H_b1ROM1_r8) -libname H_b1ROM1 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM2_r8_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1ROM2 \
	-code_file $(H_b1ROM2_r8) -libname H_b1ROM2 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM3_r8_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1ROM3 \
	-code_file $(H_b1ROM3_r8) -libname H_b1ROM3 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)

##############################################################################################
##  Radix-16   Command  
##   
#############################################################################################
#radix-16 ROM DATA 
#Forward
ROM_R16_F: R16_ROM0 R16_ROM1 R16_ROM2  R16_ROM3  R16_ROM4  R16_ROM5  R16_ROM6  R16_ROM7

R16_ROM0:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ROM0_$(rom_word_size)_$(bit_size) \
	-code_file $(instnamerom0) -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
R16_ROM1:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ROM1_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamerom1) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_ROM2:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ROM2_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamerom2) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_ROM3:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ROM3_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamerom3) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_ROM4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ROM4_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamerom4) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_ROM5:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ROM5_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamerom5) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_ROM6:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ROM6_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamerom6) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_ROM7:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ROM7_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamerom7) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
##################################################################################################
#radix-16 inverse twiddle factor rom 
ROM_R16_I: R16_IROM0 R16_IROM1 R16_IROM2 R16_IROM3 R16_IROM4 R16_IROM5 R16_IROM6 R16_IROM7 

R16_IROM0:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname IFFTR0_$(rom_word_size)_$(bit_size) \
	-code_file $(Iinstnamerom0) -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
R16_IROM1:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname IFFTR1_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamerom1) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_IROM2:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname IFFTR2_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamerom2) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_IROM3:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname IFFTR3_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamerom3) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_IROM4:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname IFFTR4_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamerom4) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_IROM5:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname IFFTR5_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamerom5) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_IROM6:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname IFFTR6_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamerom6) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_IROM7:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname IFFTR7_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamerom7) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
#################################################################################################
#radix-16 reorder
#if Cyclotomic prime is 22 bits ,then rom5 bit size is 32-bits,
#cyclotomic prime is 23~25 bits,then rom5 bit size is 64 bits.
REORDER_r16:reROM0_r16 reROM1_r16 reROM2_r16 reROM3_r16 \
ireROM0_r16 ireROM1_r16  ireROM2_r16 ireROM3_r16

reROM0_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname reorderROM0 \
	-code_file $(reorderROM0_R16) -mux $(MUX) -words $(reROM_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
reROM1_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname reorderROM1 \
	-code_file $(reorderROM1_R16) -mux $(MUX) -words $(reROM_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
reROM2_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname reorderROM2 \
	-code_file $(reorderROM2_R16) -mux $(MUX) -words $(reROM_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
reROM3_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname reorderROM3 \
	-code_file $(reorderROM3_R16) -mux $(MUX) -words $(reROM_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
ireROM0_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ireorderROM0 \
	-code_file $(ireorderROM0_R16) -mux $(MUX) -words $(IreROM_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
ireROM1_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ireorderROM1 \
	-code_file $(ireorderROM1_R16) -mux $(MUX) -words $(IreROM_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
ireROM2_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ireorderROM2 \
	-code_file $(ireorderROM2_R16) -mux $(MUX) -words $(IreROM_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
ireROM3_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname ireorderROM3 \
	-code_file $(ireorderROM3_R16) -mux $(MUX) -words $(IreROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
#################################################################################################
PRE_r16:b0ROM0_r16 b0ROM1_r16 b0ROM2_r16 b0ROM3_r16 b0ROM4_r16  b0ROM5_r16 b0ROM6_r16 b0ROM7_r16\
b1ROM0_r16 b1ROM1_r16 b1ROM2_r16 b1ROM3_r16 b1ROM4_r16  b1ROM5_r16 b1ROM6_r16 b1ROM7_r16 

b0ROM0_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b0ROM0 \
	-code_file $(H_b0ROM0_r16) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM1_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b0ROM1 \
	-code_file $(H_b0ROM1_r16) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM2_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b0ROM2 \
	-code_file $(H_b0ROM2_r16) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM3_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b0ROM3 \
	-code_file $(H_b0ROM3_r16) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM4_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b0ROM4 \
	-code_file $(H_b0ROM4_r16) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM5_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b0ROM5 \
	-code_file $(H_b0ROM5_r16) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM6_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b0ROM6 \
	-code_file $(H_b0ROM6_r16) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM7_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b0ROM7 \
	-code_file $(H_b0ROM7_r16) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM0_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b1ROM0 \
	-code_file $(H_b1ROM0_r16) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM1_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b1ROM1 \
	-code_file $(H_b1ROM1_r16) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM2_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b1ROM2 \
	-code_file $(H_b1ROM2_r16) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM3_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b1ROM3 \
	-code_file $(H_b1ROM3_r16) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM4_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b1ROM4 \
	-code_file $(H_b1ROM4_r16) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM5_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b1ROM5 \
	-code_file $(H_b1ROM5_r16) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM6_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b1ROM6 \
	-code_file $(H_b1ROM6_r16) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM7_r16:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) verilog  -instname H_b1ROM7 \
	-code_file $(H_b1ROM7_r16) -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
#################################################################################################
# synthesis  
# radix - 16 synthesize command
################################################################################################
#radix-16 ROM DATA 
#Forward
ROM_R16_F_syn: R16_ROM0_syn R16_ROM1_syn R16_ROM2_syn R16_ROM3_syn R16_ROM4_syn R16_ROM5_syn R16_ROM6_syn R16_ROM7_syn

R16_ROM0_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ROM0_$(rom_word_size)_$(bit_size) \
	-code_file $(instnamerom0) -mux $(MUX) -libname ROM0_$(rom_word_size)_$(bit_size) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
R16_ROM1_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ROM1_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamerom1) -mux $(MUX) -libname ROM1_$(rom_word_size)_$(double_bit_size) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_ROM2_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ROM2_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamerom2) -mux $(MUX) -libname ROM2_$(rom_word_size)_$(double_bit_size) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_ROM3_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ROM3_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamerom3) -mux $(MUX) -libname ROM3_$(rom_word_size)_$(double_bit_size) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_ROM4_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ROM4_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamerom4) -mux $(MUX) -libname ROM4_$(rom_word_size)_$(double_bit_size) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_ROM5_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ROM5_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamerom5) -mux $(MUX) -libname ROM5_$(rom_word_size)_$(double_bit_size) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_ROM6_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ROM6_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamerom6) -mux $(MUX) -libname ROM6_$(rom_word_size)_$(double_bit_size) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_ROM7_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ROM7_$(rom_word_size)_$(double_bit_size) \
	-code_file $(instnamerom7) -mux $(MUX) -libname ROM7_$(rom_word_size)_$(double_bit_size) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
##################################################################################################
#radix-16 inverse twiddle factor rom 
ROM_R16_I_syn: R16_IROM0_syn R16_IROM1_syn R16_IROM2_syn R16_IROM3_syn R16_IROM4_syn R16_IROM5_syn R16_IROM6_syn R16_IROM7_syn 

R16_IROM0_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname IFFTR0_$(rom_word_size)_$(bit_size) \
	-code_file $(Iinstnamerom0) -libname IFFTR0_$(rom_word_size)_$(bit_size) -mux $(MUX) -words $(rom_word_size) \
	-bits $(bit_size) -frequency $(Freq)
R16_IROM1_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname IFFTR1_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamerom1) -libname IFFTR1_$(rom_word_size)_$(double_bit_size) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_IROM2_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname IFFTR2_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamerom2) -libname IFFTR2_$(rom_word_size)_$(double_bit_size) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_IROM3_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname IFFTR3_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamerom3) -libname IFFTR3_$(rom_word_size)_$(double_bit_size) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_IROM4_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname IFFTR4_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamerom4) -libname IFFTR4_$(rom_word_size)_$(double_bit_size) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_IROM5_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname IFFTR5_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamerom5) -libname IFFTR5_$(rom_word_size)_$(double_bit_size) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_IROM6_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname IFFTR6_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamerom6) -libname IFFTR6_$(rom_word_size)_$(double_bit_size) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
R16_IROM7_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname IFFTR7_$(rom_word_size)_$(double_bit_size) \
	-code_file $(Iinstnamerom7) -libname IFFTR7_$(rom_word_size)_$(double_bit_size) -mux $(MUX) -words $(rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
#################################################################################################
#radix-16 reorder
#if Cyclotomic prime is 22 bits ,then rom5 bit size is 32-bits,
#cyclotomic prime is 23~25 bits,then rom5 bit size is 64 bits.
REORDER_r16_syn:reROM0_r16_syn reROM1_r16_syn reROM2_r16_syn reROM3_r16_syn \
ireROM0_r16_syn ireROM1_r16_syn  ireROM2_r16_syn ireROM3_r16_syn

reROM0_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname reorderROM0 \
	-code_file $(reorderROM0_R16) -libname reorderROM0 -mux $(MUX) -words $(reROM_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
reROM1_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname reorderROM1 \
	-code_file $(reorderROM1_R16) -libname reorderROM1 -mux $(MUX) -words $(reROM_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
reROM2_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname reorderROM2 \
	-code_file $(reorderROM2_R16) -libname reorderROM2 -mux $(MUX) -words $(reROM_word_size) \
	-bits $(double_bit_size)  -frequency $(Freq)
reROM3_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname reorderROM3 \
	-code_file $(reorderROM3_R16) -libname reorderROM3 -mux $(MUX) -words $(reROM_word_size) \
	-bits $(double_bit_size)  -frequency $(Freq)
ireROM0_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ireorderROM0 \
	-code_file $(ireorderROM0_R16) -libname ireorderROM0 -mux $(MUX) -words $(IreROM_word_size) \
	-bits $(double_bit_size)  -frequency $(Freq)
ireROM1_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ireorderROM1 \
	-code_file $(ireorderROM1_R16) -libname ireorderROM1 -mux $(MUX) -words $(IreROM_word_size) \
	-bits $(double_bit_size)  -frequency $(Freq)
ireROM2_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ireorderROM2 \
	-code_file $(ireorderROM2_R16) -libname ireorderROM2 -mux $(MUX) -words $(IreROM_word_size) \
	-bits $(double_bit_size)  -frequency $(Freq)
ireROM3_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname ireorderROM3 \
	-code_file $(ireorderROM3_R16) -libname ireorderROM3 -mux $(MUX) -words $(IreROM_word_size) \
	-bits $(bit_size) -frequency $(Freq)
#################################################################################################
PRE_r16_syn:b0ROM0_r16_syn b0ROM1_r16_syn b0ROM2_r16_syn b0ROM3_r16_syn b0ROM4_r16_syn b0ROM5_r16_syn b0ROM6_r16_syn b0ROM7_r16_syn\
b1ROM0_r16_syn b1ROM1_r16_syn b1ROM2_r16_syn b1ROM3_r16_syn b1ROM4_r16_syn b1ROM5_r16_syn b1ROM6_r16_syn b1ROM7_r16_syn 

b0ROM0_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0ROM0 \
	-code_file $(H_b0ROM0_r16) -libname H_b0ROM0 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM1_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0ROM1 \
	-code_file $(H_b0ROM1_r16) -libname H_b0ROM1 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM2_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0ROM2 \
	-code_file $(H_b0ROM2_r16) -libname H_b0ROM2 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM3_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0ROM3 \
	-code_file $(H_b0ROM3_r16) -libname H_b0ROM3 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM4_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0ROM4 \
	-code_file $(H_b0ROM4_r16) -libname H_b0ROM4 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM5_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0ROM5 \
	-code_file $(H_b0ROM5_r16) -libname H_b0ROM5 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM6_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0ROM6 \
	-code_file $(H_b0ROM6_r16) -libname H_b0ROM6 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b0ROM7_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b0ROM7 \
	-code_file $(H_b0ROM7_r16) -libname H_b0ROM7 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM0_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1ROM0 \
	-code_file $(H_b1ROM0_r16) -libname H_b1ROM0 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM1_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1ROM1 \
	-code_file $(H_b1ROM1_r16) -libname H_b1ROM1 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM2_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1ROM2 \
	-code_file $(H_b1ROM2_r16) -libname H_b1ROM2 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM3_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1ROM3 \
	-code_file $(H_b1ROM3_r16) -libname H_b1ROM3 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM4_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1ROM4 \
	-code_file $(H_b1ROM4_r16) -libname H_b1ROM4 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM5_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1ROM5 \
	-code_file $(H_b1ROM5_r16) -libname H_b1ROM5 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM6_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1ROM6 \
	-code_file $(H_b1ROM6_r16) -libname H_b1ROM6 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
b1ROM7_r16_syn:
	cd $(ROMDATA_PATH) ; \
	$(rodsd_path) synopsys  -instname H_b1ROM7 \
	-code_file $(H_b1ROM7_r16) -libname H_b1ROM7 -mux $(MUX) -words $(H2rom_word_size) \
	-bits $(double_bit_size) -frequency $(Freq)
#################################################################################################
#ROM_DATA_GEN
clean:
	rm -f *.o
	rm -rf BFFTP
	rm -f $(ROMDATA_PATH)/*.txt
	rm -f $(FFTC_PATH)/SRAM/*
	rm -f $(FFTC_PATH)/syn_tcl/*
	rm -f $(FFTC_PATH)/test_input/*
	
clean_syn:
	rm -f *.o
	cd $(ROMDATA_PATH) ; rm -f *.txt
	cd $(FFTC_PATH)/SRAM; rm -f *
	cd $(FFTC_PATH)/syn_tcl; rm -f *
	cd $(FFTC_PATH)/syn/dv; rm -r -f *
	cd $(FFTC_PATH)/syn_tcl; rm -f *
	cd $(FFTC_PATH)/syn/lib; rm -f *.lib
	cd $(FFTC_PATH)/syn/Mem_lib; rm -f *.db
	cd $(FFTC_PATH)/syn/vlog; rm -r -f *
	cd $(FFTC_PATH)/syn/gate_netlist; rm -f  *



	
