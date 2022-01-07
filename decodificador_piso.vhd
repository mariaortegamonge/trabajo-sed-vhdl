
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2021 16:38:43
-- Design Name: 
-- Module Name: decodificador_piso - Behavioral
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

entity decodificador_piso is
port(
boton_piso: in std_logic_vector(6 downto 0);
clk: in std_logic;
piso: out std_logic_vector(2 downto 0)
);
end decodificador_piso;

architecture Behavioral of decodificador_piso is

begin

process(clk)
begin 
    if rising_edge(clk) then --flanco de subida del reloj
        case boton_piso is
                when "0000001" => piso <= "001"; 
                when "0000010" => piso <= "010"; 
                when "0000100" => piso <= "011"; 
                when "0001000" => piso <= "100";
                when "0010000" => piso <= "101";
                when "0100000" => piso <= "110";   
                when "1000000" => piso <= "111";
                when others =>  piso <= "000";--por defecto esta en el bajo
         end case;
      end if;
end process;
end Behavioral;
