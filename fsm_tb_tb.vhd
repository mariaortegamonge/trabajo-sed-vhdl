library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity fsm_tb_tb is
end;

architecture behavioral of fsm_tb_tb is

component fsm_ascensor is
port (
	clk, reset_n : in std_logic; 
	sensor_abrir_cerrar : in std_logic_vector (1 downto 0);
	sensor_abrir : in std_logic;	--Nos indica que se encuentra en un piso adecuado para parar ( nosotros lo paramos como sensor externo)
	sensor_entrapersona : in std_logic;
	piso: in std_logic_vector (2 downto 0);
	piso_actual : in std_logic_vector (2 downto 0);
	--El boton tiene un estado de reposo que es el 000 (no hay nada pulsandolo)
	destino_piso : out std_logic_vector (2 downto 0);
	motor: out std_logic_vector (1 downto 0);
	puerta: out std_logic_vector (1 downto 0)
	);
end component;

--Inputs
signal clk, reset_n,  sensor_abrir, sensor_entrapersona : std_logic;
signal piso_actual, piso : std_logic_vector (2 downto 0);
signal sensor_abrir_cerrar : std_logic_vector (1 downto 0);


--Outputs
signal destino_piso : std_logic_vector ( 2 downto 0);
signal motor,puerta : std_logic_vector (1 downto 0);

--Constantes
constant clk_period : time := 10 ns;

begin
	uut : fsm_ascensor 	port map (
		clk => clk,
		reset_n => reset_n,
		sensor_abrir_cerrar => sensor_abrir_cerrar,
		sensor_abrir => sensor_abrir,
		piso_actual => piso_actual,
		piso => piso,
		destino_piso => destino_piso,
		motor => motor,
		puerta => puerta,
		sensor_entrapersona=>sensor_entrapersona
		);

	--Clock Process definition
	clk_process : process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;

	--Stimulus process
	stim_process: process
	begin
		reset_n <= '1';--funciona bien 
		piso_actual <= "001";
		piso <= "011";
		sensor_entrapersona <= '0';--no entra nadie
		sensor_abrir_cerrar <= "01"; --puertas cerrada
		wait for 30 ns;
	    sensor_abrir_cerrar <= "10"; --puertas abrir
	    wait for 30 ns;
        sensor_abrir_cerrar <= "01"; --puertas cerrada empieza a subir 
		wait for 10 ns;
		piso_actual <= "010";
	    wait for 10 ns;
		piso_actual <= "011";
		wait for 30 ns; --se deberia parar el motor

		sensor_abrir_cerrar <= "10"; --puertas abrir
		--segundo ciclo del 3 al 6
		piso <= "110";
	    wait for 30 ns;
	    sensor_abrir_cerrar <= "01"; --puertas cerrada
		wait for 30 ns;
	    sensor_abrir_cerrar <= "10"; --puertas abrir
	    wait for 30 ns;
        sensor_abrir_cerrar <= "01"; --puertas cerrada empieza a subir  al 6
		wait for 10 ns;
		piso_actual <= "100";
	    wait for 10 ns;
		piso_actual <= "101";
	    wait for 10 ns;
		piso_actual <= "110";
		wait for 30 ns; --se deberia parar el motor

		sensor_abrir_cerrar <= "10"; --puertas abrir
	    wait for 30 ns;

		

		assert false
			report "Todo correcto en FSM"
			severity failure;
	end process;
	end;