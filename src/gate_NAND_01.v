/*
 Gate NAND 2 Input
 based on transistor level modeling
*/

`default_nettype none

module gate_NAND_01 (
    input A,
    input B, 
    output Y     
);

 supply1 VDD;
 supply0 VSS;
 wire between;
 pmos(Y,VDD,A),(Y,VDD,B);
 nmos(Y,between,A),(between,VSS,B);


 endmodule // 


 `default_nettype wire 
