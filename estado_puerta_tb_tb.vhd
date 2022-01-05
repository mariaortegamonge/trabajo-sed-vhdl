----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.12.2021 20:01:35
-- Design Name: 
-- Module Name: estado_puerta_tb_tb - Behavioral
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

entity estado_puerta_tb_tb is
--  Port ( );
end estado_puerta_tb_tb;

architecture Behavioral of estado_puerta_tb_tb is
component estado_puerta 
Port ( 
    abrir_o_cerrar : in std_logic_vector (1 downto 0); --llega del control de la puerta y dice si se abre o cierra.00cerrado. 01 cerrandose. 10 abriendose. 11 abierto.
    clk: in std_logic;
    reset_n: in std_logic;
    sensor_abrir_cerrar: out std_logic_vector (1 downto 0) --sensor de fin de carrera. 10 abierto. 01 cerrado.
);
end component;

    signal abrir_o_cerrar :  std_logic_vector (1 downto 0); --llega del control de la puerta y dice si se abre o cierra.00cerrado. 01 cerrandose. 10 abriendose. 11 abierto.
    signal clk:  std_logic;
    signal reset_n:  std_logic:='0';
    signal sensor_abrir_cerrar:  std_logic_vector (1 downto 0); --sen
    
    constant clk_period:time:=10ns;
begin
uut:estado_puerta
port map(
    abrir_o_cerrar=>abrir_o_cerrar,
    clk=>clk,
    reset_n=>reset_n,
    sensor_abrir_cerrar=>sensor_abrir_cerrar
);
 reset_n<='1' after 10ns;
 
 clk_gen:process
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
 abrir_o_cerrar<="00";
 wait for 10ns;
  abrir_o_cerrar<="01";
 wait for 10ns;
  abrir_o_cerrar<="10";
 wait for 10ns;
 assert false 
  report "bien la simulacion"
  severity failure;


end process;
 
 
 
 
 
 
end Behavioral;
