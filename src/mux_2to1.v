/*
 2 to 1 mux
 Discrete Build with nmos und pmos
*/

/*
 TODOs
 (a) Ausschalten automatische Optimierung
*/

`default_nettype none

    module mux_2to1(
        input I0,
        input I1,
        input Select, //0 selects I0, 1 selects I1
        output Y
);

/*
always @* begin
    if (Select == 0)
        Y = I0;
    else
        Y = I1;
end
*/
/*
wire Select_n;
assign Select_n = ~ Select;

// PMOS and NMOS transistor network
nmos n0(Y, Select_n, I0);
nmos n1(Y, Select, I1);
*/


supply1 VDD;
supply0 VSS;
wire Select_n;

pmos (Select_n,VDD,Select), (Y, I1, Select), (Y, I0, Select_n);
nmos (Select_n,VSS,Select), (Y, I1, Select_n), (Y, I0, Select);



endmodule


`default_nettype wire 
