library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;
ENTITY decoder_tb_tb IS
END decoder_tb_tb;
ARCHITECTURE BEHAVIORAL OF decoder_tb_tb IS
 COMPONENT decodificador_piso
PORT(
piso: out std_logic_vector(2 DOWNTO 0);
boton_piso : in std_logic_vector(6 DOWNTO 0);
clk: in std_logic

);
END COMPONENT;
SIGNAL piso : std_logic_vector(2 DOWNTO 0);
SIGNAL boton_piso : std_logic_vector(6 DOWNTO 0);
SIGNAL clk : std_logic;
constant clk_period:time:=10 ns;
BEGIN
uut: decodificador_piso PORT MAP(
piso => piso,
boton_piso => boton_piso,
clk=>clk
);

clk_process: process
begin
for i in 0 to 4 loop
clk<='0';
wait for clk_period/2;
clk<='1';
wait for clk_period/2;
end loop;
end process;
tb: PROCESS
BEGIN
           boton_piso <= "0000001";
            wait for 20 ns;
            boton_piso <= "0000010";
            wait for 20 ns;
            boton_piso <= "0000100";
            wait for 20 ns;
            boton_piso <= "0001000";
            wait for 20 ns;
            
            assert false
                report "Simulación finalizada. Test superado"
                severity failure;
END PROCESS;
END BEHAVIORAL;
