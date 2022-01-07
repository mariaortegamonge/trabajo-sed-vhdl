library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

entity estado_puerta is
Port ( 
    abrir_o_cerrar : in std_logic_vector (1 downto 0); --llega del control de la puerta y dice si se abre o cierra.00cerrado. 01 cerrandose. 10 abriendose. 11 abierto.
    clk: in std_logic;
    reset_n: in std_logic;
    estado: out std_logic_vector (1 downto 0); --salida que indica en que estado está la puerta. 00cerrado. 01 cerrandose. 10 abriendose. 11 abierto.
    sensor_abrir_cerrar: out std_logic_vector (1 downto 0) --sensor de fin de carrera. 10 abierto. 01 cerrado.
);
end estado_puerta;

architecture Behavioral of estado_puerta is

signal estadopuerta : std_logic_vector (1 downto 0) := "01"; --cerrandose
signal sensor: std_logic_vector (1 downto 0) := "00"; --cerrado

begin
    process (clk, reset_n)
    begin 
        if reset_n
         = '0' then 
            estadopuerta <= "11"; --partimos siempre de la puerta abierta.
            sensor <= "10";--abriendo.
        elsif rising_edge (clk) then
            if abrir_o_cerrar = "00" then 
            estadopuerta <= estadopuerta; -- inicializado en 01, cerrandose
			elsif abrir_o_cerrar = "01" and estadopuerta /= "00" then
				estadopuerta <= "00"; 
			elsif abrir_o_cerrar <= "10" and estadopuerta /= "11" then
				estado <= "11";
			end if;
            if estadopuerta = "11" then
                sensor <= "10";
            elsif estadopuerta = "00" then
                sensor <= "01";
            else 
                sensor <= "00";
			end if;
		end if;
	end process;
    
    sensor_abrir_cerrar <= sensor;
    estado <= estadopuerta;

end Behavioral;
