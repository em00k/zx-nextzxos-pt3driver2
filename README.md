# zx-nextzxos-pt3driver2
pt3 driver v2 for NextZXOS


## pt3 v2 driver for nextzxos 
- PT3Driver v2 for NextZXOS written by em00k 2/4/2022
- based on driver template by Garry Lancaster
- some snippets from Remy Sharps AYFX driver  https://github.com/remy/next-ayfx
- uses Sergy Bulba's vt2 replayer

Lost v1 sources so had to rewrite, this time adding user banks
you cannot specifiy which AY to use, as this is baked into the replayer

 Example usage : 
 ```basic
   10 .install "pt3driver.drv"
   15 ; load the player a bank
   20 LOAD "vortex.bin" BANK 20
   25 ; load the tune into a bank
   30 LOAD "tune.pt3" BANK 21
   35 ; tell the driver which banks
   40 DRIVER 127,1,20,21
   45 ; cmd 127,2,<0 stop|1 init|2 play|3 mute>
   50 DRIVER 127,2,1 :; start tune
```
