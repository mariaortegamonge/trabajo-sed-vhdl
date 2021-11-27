----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2021 16:23:36
-- Design Name: 
-- Module Name: TOP-ASCENSOR - Behavioral
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

entity TOP_ASCENSOR is
PORT(
sensor_presencia:in std_logic;
boton_piso: in std_logic_vector(3 downto 0);
reset: in std_logic;
clock: in std_logic;
display: out std_logic_vector(6 downto 0);
clck:out std_logic
);
end TOP_ASCENSOR;

architecture Behavioral of TOP_ASCENSOR is

begin


end Behavioral;
