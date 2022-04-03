; **************************************************************
; * pt3 v2 driver for nextzxos 
; **************************************************************
; PT3Driver v2 for NextZXOS written by em00k 2/4/2022
; based on driver template by Garry Lancaster
; some snippets from Remy Sharps AYFX driver  https://github.com/remy/next-ayfx
; uses Sergy Bulba's vt2 replayer
;
; Lost v1 sources so had to rewrite, this time adding user banks
; you cannot specifiy which AY to use, as this is baked into the replayer

; Example usage : 
;   10 .install "pt3driver.drv"
;   15 ; load the player a bank
;   20 LOAD "vortex.bin" BANK 20
;   25 ; load the tune into a bank
;   30 LOAD "tune.pt3" BANK 21
;   35 ; tell the driver which banks
;   40 DRIVER 127,1,20,21
;   45 ; cmd 127,2,<0 stop|1 init|2 play|3 mute>
;   50 DRIVER 127,2,1 :; start tune
; 
; ***************************************************************************
; * Definitions                                                             *
; ***************************************************************************
; Pull in the symbol file for the driver itself and calculate the number of
; relocations used.

        include "../pt3driver.sym"
start:
relocs  equ     (reloc_end-reloc_start)/2


; ***************************************************************************
; * .DRV file header                                                        *
; ***************************************************************************
; The driver id must be unique, so current documentation on other drivers
; should be sought before deciding upon an id. This example uses $7f as a
; fairly meaningless value. A network driver might want to identify as 'N'
; for example.
	device ZXSPECTRUMNEXT

        org     $0000

        defm    "NDRV"          ; .DRV file signature

        defb    $7f+$80         ; DRIVER ID 0x7f assigned by Garry Lancaster
				; 7-bit unique driver id in bits 0..6
                                ; bit 7=1 if to be called on IM1 interrupts

        defb    relocs          ; number of relocation entries (0..255)

        defb    0               ; number of additional 8K DivMMC RAM banks
                                ; required (0..8); call init/shutdown
        ; NOTE: If bit 7 of the "mmcbanks" value above is set, .INSTALL and
        ;       .UNINSTALL will call your driver's $80 and $81 functions
        ;       to allow you to perform initialisation/shutdown tasks
        ;       (see border.asm for more details)

        defb    0               ; number of additional 8K Spectrum RAM banks
                                ; required (0..200)


; ***************************************************************************
; * Driver binary                                                           *
; ***************************************************************************
; The driver + relocation table should now be included.

        incbin  "pt3.bin"

driverend

        savebin "pt3driver.drv",start,driverend-start
        savebin "h:/pt3driver/pt3driver.drv",start,driverend-start
