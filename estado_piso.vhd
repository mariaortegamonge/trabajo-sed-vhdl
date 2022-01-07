----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2021 16:51:54
-- Design Name: 
-- Module Name: estado_piso - Behavioral
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
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity estado_piso is --para saber el piso en el que estamos(simulando)
Port
(
    destino_piso: in std_logic_vector(2 downto 0);--piso destino que le llega de la fsm
    direccion : in std_logic_vector (1 downto 0); --arriba o abajo
	reset_n : in std_logic;
	piso : out std_logic_vector (6 downto 0);--opciones de piso
	clk : in std_logic
	);

end estado_piso;



architecture Behavioral of estado_piso is
signal piso_actual : std_logic_vector (2 downto 0):="001";
begin
estado_piso : process (clk, reset_n)
begin
if reset_n = '0' then
			piso_actual <= "001";
		elsif rising_edge (clk) then
			if direccion = "10" and piso_actual /= "111" and piso_actual/=destino_piso then--si esta subiendo...
				piso_actual <= piso_actual +1;--si he subido actualizo la señal piso actual
			elsif direccion = "01" and piso_actual /= "001" and piso_actual/=destino_piso then--si estoy bajando...
				piso_actual <= piso_actual -1 ;--si he bajado actualizo la señal piso actual
			elsif direccion="00" then piso_actual<=piso_actual;
			end if;
		end if;
	end process;
	
	estado_Process : process (piso_actual)
	begin
		case (piso_actual) is--significado de la señal del piso_actual
			when "001" => 
				piso <= "0000001";
			when "010" => 
				piso <= "0000010";
			when "011" => 
				piso <= "0000100";
			when "100" => 
				piso <= "0001000";
			when "101" => 
				piso <= "0010000";
			when "110" => 
				piso <= "0100000";
			when "111" => 
				piso <= "1000000";	
            when others => 
                piso <= "0000000";
                
		end case;
	end process;


end Behavioral;
