----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.12.2021 19:45:31
-- Design Name: 
-- Module Name: estado_piso_tb_tb - Behavioral
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

entity estado_piso_tb_tb is
--  Port ( );
end estado_piso_tb_tb;

architecture Behavioral of estado_piso_tb_tb is
component estado_piso  --para saber el piso en el que estamos(simulando)
Port
(
    destino_piso: in std_logic_vector(2 downto 0);--piso destino que le llega de la fsm
    direccion : in std_logic_vector (1 downto 0); --arriba o abajo
	reset_n : in std_logic;
	piso : out std_logic_vector (6 downto 0);--opciones de piso
	clk : in std_logic
	);

end component;

    signal destino_piso:  std_logic_vector(2 downto 0);--piso destino que le llega de la fsm
    signal direccion :  std_logic_vector (1 downto 0); --arriba o abajo
	signal reset_n :  std_logic:='0';
	signal piso :  std_logic_vector (6 downto 0);--opciones de piso
	signal clk :  std_logic;
	
	constant clk_period:time:=10ns;
begin
uut:estado_piso
port map(
    destino_piso=>destino_piso,
    direccion=>direccion,
    reset_n=>reset_n,
    piso=>piso,
    clk=>clk
);


clk_gen:process
begin
for i in 0 to 4 loop
clk<='0';
wait for clk_period*0.5;
clk<='1';
wait for clk_period*0.5;
end loop;
end process;
 reset_n<='1';
stim:process
begin
 destino_piso<="111";--subimos al piso mas alto 
 direccion<="10";
 wait for 100ns;--dejamos que suba
 
  destino_piso<="001";--subimos al piso mas bajo 
 direccion<="01";
 wait for 100ns;--dejamos que baje
  assert false 
  report "bien la simulacion"
  severity failure;

end process;
end Behavioral;
