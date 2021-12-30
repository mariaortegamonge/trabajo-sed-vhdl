library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity clk_divider_tb_tb is
end clk_divider_tb_tb;

architecture Behavioral of clk_divider_tb_tb is

    --Declaración de componentes
    COMPONENT clk_divider 
    PORT(
        clock: IN STD_LOGIC;
        reset_n: IN STD_LOGIC;
        clk: out STD_LOGIC
    );
    end COMPONENT;
    
    --Inputs
    signal clock: STD_LOGIC := '0';
    signal reset_n: STD_LOGIC := '0';
    signal clk: STD_LOGIC := '0';
    
    --Definicion de periodos de reloj
    constant clk_period : time := 10 ns;
    
    begin
        --instanciacion test
        uut : clk_divider PORT MAP (
            clock  => clock,
            reset_n => reset_n,
            clk => clk
        );
        
        --Definicion del proceso Clock
        clk_process : process 
        begin
        for i in 0 to 1000000000 loop
        
            clock <= '0';
            wait for clk_period/4;
            clock <= '1';
            wait for clk_period/4;
          
          end loop;
        end process;
        
        --Stimulus process
        stim_process : process 
        begin
            --Mantener estado de inicio
            wait for 100 ns;
            
            --Estimulo
            reset_n <= '1';
            wait for 1 us;
            
            assert false;
                        report "Simulacion finalizada"
                        severity failure;
        end process;
        
end Behavioral;