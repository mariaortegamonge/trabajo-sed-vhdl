library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

entity control_puerta is
Port ( 
    clk: in std_logic;
    accion_abre_cierra: in std_logic_vector (1 downto 0); --entrada de la fsm que le manda abrir o cerra.
    puerta: out std_logic_vector (1 downto 0)--si el motor de la puerta se activa o no.
);
end control_puerta;

architecture Behavioral of control_puerta is

begin
    process (clk)
    begin 
        if rising_edge (clk) then
            if accion_abre_cierra = "10" then --abrir
                puerta <= "10"; --abre
            elsif accion_abre_cierra ="01" then --cerrar
                 puerta <= "01"; --cierra
            elsif accion_abre_cierra = "00" then 
                puerta <="00";
                
            end if;
         end if;
     end process;
end Behavioral;