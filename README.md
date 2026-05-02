Version 0
######## DUT ########
# AXI2APB Bridge
## Only support single transaction !! (len = 1)
## Slave can't transfer the response.

---- TODO ----
## Supoort to Multiple transaction.
## Support to Interleaving. (MO, OoO...)


# GPIO (APB Slave)
## There are only 4 SFRs. (CON, DAT, PUD, DRV)
## There are 8 PADs.


######## Verification ########
# AXI VIP can transfer only WRITE Transaction.
# AXI VIP doesn't receive reponse from APB slave.
# NO Checker.

---- TODO ----
# Add Checker to check the conversion between AXI to APB.
# Modify to receive response from APB slave. (Like to real AXI Master.)
