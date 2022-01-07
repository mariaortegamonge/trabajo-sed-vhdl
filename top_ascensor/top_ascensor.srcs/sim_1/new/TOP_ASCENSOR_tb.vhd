library ieee;
use ieee.std_logic_1164.all;

entity tb_TOP_ASCENSOR is
end tb_TOP_ASCENSOR;

architecture tb of tb_TOP_ASCENSOR is

    component TOP_ASCENSOR
        port (sensor_presencia : in std_logic;
              sensor_abrir     : in std_logic_vector (1 downto 0);
              boton_piso       : in std_logic_vector (6 downto 0);
              reset_n          : in std_logic;
              clock            : in std_logic;
              display7s        : out std_logic_vector (6 downto 0));
    end component;

    signal sensor_presencia : std_logic;
    signal sensor_abrir     : std_logic_vector (1 downto 0);
    signal boton_piso       : std_logic_vector (6 downto 0);
    signal reset_n          : std_logic;
    signal clock            : std_logic;
    signal display7s        : std_logic_vector (6 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : TOP_ASCENSOR
    port map (sensor_presencia => sensor_presencia,
              sensor_abrir     => sensor_abrir,
              boton_piso       => boton_piso,
              reset_n          => reset_n,
              clock            => clock,
              display7s        => display7s);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clock is really your main clock signal
    clock <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        sensor_presencia <= '0';
        sensor_abrir <= (others => '0');
        boton_piso <= (others => '0');

        -- Reset generation
        -- EDIT: Check that reset_n is really your reset signal
        reset_n <= '0';
        wait for 100 ns;
        reset_n <= '1';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_TOP_ASCENSOR of tb_TOP_ASCENSOR is
    for tb
    end for;
end cfg_tb_TOP_ASCENSOR;