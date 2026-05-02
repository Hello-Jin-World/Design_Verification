Version 0

======== DUT ========

[ AXI2APB Bridge ]
- Supports only single transactions. (len = 1)
- The slave cannot return a response.

---- TODO ----
- Support multiple transactions.
- Support interleaving (MO, OoO).

[ GPIO (APB Slave) ]
- There are only 4 SFRs: CON, DAT, PUD, and DRV.
- There are 8 PADs.

======== Verification ========

[ AXI VIP ]
- Supports only WRITE transactions.
- Does not receive responses from the APB slave.
- No checker implemented.

---- TODO ----
- Add a checker to verify AXI-to-APB conversion.
- Modify the VIP to receive responses from the APB slave (similar to a real AXI master).
