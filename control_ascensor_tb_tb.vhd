----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.12.2021 18:18:09
-- Design Name: 
-- Module Name: control_ascensor_tb_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_ascensor_tb_tb is
--  Port ( );
end control_ascensor_tb_tb;

architecture Behavioral of control_ascensor_tb_tb is
component control_ascensor 
Port
 (
        clk, reset_n : in std_logic;
        accion_subebaja : in std_logic_vector (1 downto 0);--señal de la fsm subir o bajar
        motor : out std_logic_vector (1 downto 0)--motor funcionando o no
  );
end component;
        signal  reset_n :  std_logic:='0';
        signal  clk :  std_logic;
        signal accion_subebaja :  std_logic_vector (1 downto 0);--señal de la fsm subir o bajar
        signal motor :  std_logic_vector (1 downto 0);--motor funcionando o no
        constant clk_period:time:=10ns;
begin
uut:control_ascensor
port map(
    clk=>clk,
    reset_n=>reset_n,
    accion_subebaja=>accion_subebaja,
    motor=>motor
);
reset_n<='1' after 5 ns;
clk_gen:process
begin
for i in 0 to 4 loop
clk<='0';
wait for clk_period*0.5;
clk<='1';
wait for clk_period*0.5;
end loop;
end process;
stim_gen: process
begin
     accion_subebaja<="01";
   wait for 10ns;
     accion_subebaja<="10";
   wait for 10ns;
     accion_subebaja<="11";
   wait for 10ns;
assert false
report "bien finalizado"
severity failure;

end process;

end Behavioral;
