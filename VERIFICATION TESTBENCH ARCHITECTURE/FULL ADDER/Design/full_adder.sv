module full_adder (add_itf.dut itf );
  assign itf.sum= itf.a ^ itf.b ^ itf.cin;
  assign itf.carry=(itf.cin & (itf.a ^ itf.b)) | itf.a & itf.b;
endmodule
