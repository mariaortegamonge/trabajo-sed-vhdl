----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.12.2021 18:07:32
-- Design Name: 
-- Module Name: control_puerta_tb_tb - Behavioral
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

entity control_puerta_tb_tb is
--  Port ( );
end control_puerta_tb_tb;

architecture Behavioral of control_puerta_tb_tb is

component control_puerta 
Port ( 
    clk: in std_logic;
    accion_abre_cierra: in std_logic_vector (1 downto 0); --entrada de la fsm que le manda abrir o cerra.
    puerta: out std_logic_vector (1 downto 0)--si el motor de la puerta se activa o no.
);
end component;

    signal clk:  std_logic;
    signal accion_abre_cierra:  std_logic_vector (1 downto 0); --entrada de la fsm que le manda abrir o cerra.
    signal puerta:  std_logic_vector (1 downto 0);--si el motor de la puerta se activa o no.
    constant clk_period:time:=10ns;
    
begin

 uut: control_puerta
 port map(
 clk=>clk,
 accion_abre_cierra=>accion_abre_cierra,
 puerta=>puerta
 );
 
 clk_process:process
 begin 
for i in 0 to 4 loop
clk<='0';
wait for clk_period*0.5;
clk<='1';
wait for clk_period*0.5;
end loop;
 end process;
 
 stim_gen:process
 begin
 accion_abre_cierra<="00";
 wait for 10ns;
  accion_abre_cierra<="01";
 wait for 10ns;
  accion_abre_cierra<="10";
 wait for 10ns;
  accion_abre_cierra<="11";
 wait for 10ns;
 assert false
 report"terminado bien"
 severity failure;
 
 
 end process;
end Behavioral;
