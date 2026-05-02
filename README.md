Version 0

======== DUT ========

[ AXI2APB Bridge ]
- Only support single transaction !! (len = 1)
- Slave can't transfer the response.

---- TODO ----
- Support Multiple transaction.
- Support Interleaving. (MO, OoO...)

[ GPIO (APB Slave) ]
- There are only 4 SFRs. (CON, DAT, PUD, DRV)
- There are 8 PADs.

======== Verification ========

[ AXI VIP ]
- Can transfer only WRITE Transaction.
- Doesn't receive response from APB slave.
- No Checker.

---- TODO ----
- Add Checker to verify AXI → APB conversion.
- Modify to receive response from APB slave (similar to a real AXI Master).
