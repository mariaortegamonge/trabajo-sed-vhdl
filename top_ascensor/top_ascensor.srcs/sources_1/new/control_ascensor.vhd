----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2021 17:10:55
-- Design Name: 
-- Module Name: control_ascensor - Behavioral
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

entity control_ascensor is
Port
 (
        clk, reset_n : in std_logic;
        accion_subebaja : in std_logic_vector (1 downto 0);--señal de la fsm subir o bajar
        motor : out std_logic_vector (1 downto 0)--motor funcionando o no
 
 
  );
end control_ascensor;

architecture Behavioral of control_ascensor is

begin
 proceso_del_motor: process (clk, reset_n)
    begin
        if reset_n = '0' then
            motor <= "00";--motor quieto
        elsif rising_edge (clk ) then --si llega un flanco
            if (accion_subebaja = "10" ) then  --Subir
            	motor <= "10";--motor funciona subiendo
        	elsif (accion_subebaja = "01") then--bajar
        		motor <= "01";--motor funciona bajando
    		else
    			motor <= "00";--motor quieto
		    end if;
        end if;
	end process; 

end Behavioral;
