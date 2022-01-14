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
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOP_ASCENSOR1 is
PORT(
sensor_presencia:in std_logic;
sensor_abrir: in std_logic;
boton_piso: in std_logic_vector(6 downto 0);
reset_n: in std_logic;
clock: in std_logic;
leds_puerta: out std_logic_vector(1 downto 0);
leds_motor: out std_logic_vector(1 downto 0);
display7s: out std_logic_vector(6 downto 0)
);
end TOP_ASCENSOR1;

architecture Structural of TOP_ASCENSOR1 is

    --los tres tipos de relojes
    signal Hz60: std_logic;
    signal Hz1: std_logic;
    signal Hz2: std_logic; 
    
    --FSM_ascensor
    signal sensor_abrir_cerrar1 : std_logic_vector (1 downto 0);
    signal piso_actual1 : std_logic_vector (2 downto 0);
    signal piso_decod1: std_logic_vector (2 downto 0);
    signal puerta1 : std_logic_vector (1 downto 0);  --Fsm manda accion sobre los motores de la puerta.
    signal motor1: std_logic_vector (1 downto 0);   --Fsm manda accion sobre los motroes del ascensor.
    signal piso_destino1 : std_logic_vector (2 downto 0);
     signal accion_subebaja1 : std_logic_vector(1 downto 0);
     signal accion_abre_cierra1 : std_logic_vector(1 downto 0);
   
    --Simulaciones de motores
    --Inputs
    signal motor_puerta1 : std_logic_vector (1 downto 0);
    signal motor_ascensor1: std_logic_vector (1 downto 0);
    --Outputs
    signal piso_sim1 : std_logic_vector (6 downto 0);
        
    COMPONENT display
    PORT (
        reset_n : in std_logic;
        clk : in std_logic;
        --destino_piso : IN STD_LOGIC_VECTOR (2 downto 0);    
        piso_actual : in std_logic_vector (2 downto 0);
        led : OUT STD_LOGIC_VECTOR (6 downto 0)
        --ctrl : out std_logic_vector (7 downto 0);          
       -- motor: in std_logic_vector (1 downto 0);  
        --puerta : in std_logic_vector (1 downto 0)
        );
    END COMPONENT;        
    
    COMPONENT clk_divider
    GENERIC (frecuencia: integer := 50000000 );
    PORT ( 
        clock     : in std_logic;
        reset_n   : in std_logic;
        clk : out std_logic
        );
    END COMPONENT;
    
    COMPONENT fsm_ascensor
    PORT (
        clk, reset_n : in std_logic; 
        sensor_abrir_cerrar : in std_logic_vector (1 downto 0);
        sensor_abrir : in std_logic; 
        sensor_entrapersona : in std_logic;
        piso: in std_logic_vector (2 downto 0);
        piso_actual : in std_logic_vector (2 downto 0);
        destino_piso : out std_logic_vector (2 downto 0);
        motor: out std_logic_vector (1 downto 0);
        puerta: out std_logic_vector (1 downto 0)
       );
    END COMPONENT;
    
    COMPONENT control_puerta
    PORT (
        clk : in std_logic;
        accion_abre_cierra: in std_logic_vector (1 downto 0);
        puerta: out std_logic_vector (1 downto 0)
        );
    END COMPONENT;
    
    COMPONENT control_ascensor
    PORT (
        clk, reset_n : in std_logic;
        accion_subebaja : in std_logic_vector (1 downto 0);
        motor : out std_logic_vector (1 downto 0)
        );
    END COMPONENT;

    COMPONENT estado_puerta 
    PORT (
        abrir_o_cerrar : in std_logic_vector (1 downto 0);
        --estado : out std_logic_vector (1 downto 0);
        clk : in std_logic;
        reset_n : in std_logic;
        sensor_abrir_cerrar: out std_logic_vector (1 downto 0)
        );
    END COMPONENT;

    COMPONENT estado_piso
    PORT (
        destino_piso: in std_logic_vector(2 downto 0);--piso destino que le llega de la fsm
        direccion : in std_logic_vector (1 downto 0);
        clk : in std_logic;        
        reset_n : in std_logic;
        piso : out std_logic_vector (6 downto 0)
        );
    END COMPONENT;

    COMPONENT decodificador_piso
    PORT (
        boton_piso: in std_logic_vector (6 downto 0);
        piso : out std_logic_vector (2 downto 0);
        clk : in std_logic
        );
    END COMPONENT;
begin
    
    clk_divider0: clk_divider
    GENERIC MAP ( frecuencia => 100000000 )
    PORT MAP (
        clock => clock,
        clk => Hz1,     
        reset_n => reset_n
        );
        
    clk_divider1:     clk_divider
    GENERIC MAP ( frecuencia => 62500 )
    PORT MAP (
        clock => clock,
        clk => Hz60,     
        reset_n => reset_n
        );

    clk_divider2:     clk_divider
    GENERIC MAP ( frecuencia => 200000000 )
    PORT MAP (
        clock => clock,
        clk => Hz2,     
        reset_n => reset_n
        );
                
    display1:   display 
    PORT MAP (
        clk => Hz60,
        reset_n => reset_n,
        piso_actual=>piso_actual1,--señal
        led => display7s
        );                       
                
    fsm_ascensor1:     fsm_ascensor
    PORT MAP (
        clk => Hz60,
        reset_n => reset_n,
        piso => piso_decod1,--señal hacia decodificador
        destino_piso => piso_destino1,
        sensor_abrir_cerrar =>sensor_abrir_cerrar1,--señal hacia estado puerta
        piso_actual =>piso_actual1,
        sensor_abrir => sensor_abrir,
        sensor_entrapersona => sensor_presencia,
        motor => accion_subebaja1,
        puerta => accion_abre_cierra1
        );
        
    control_puerta1:  control_puerta
    PORT MAP ( 
        clk => Hz60,
        accion_abre_cierra => accion_abre_cierra1,
        puerta => puerta1
        );
        
    control_ascensor1 : control_ascensor
    PORT MAP (
        clk=> Hz60,
        reset_n => reset_n,
        accion_subebaja => accion_subebaja1,
        motor => motor_ascensor1
        );            

    estado_piso1 : estado_piso
    PORT MAP (
        clk => Hz1,
        reset_n => reset_n,
        direccion => motor_ascensor1,
        piso => piso_sim1,
        destino_piso=>piso_destino1
        );

    estado_puerta1 : estado_puerta 
    PORT MAP (
        clk => Hz2,
        reset_n => reset_n,
        abrir_o_cerrar => puerta1,
       -- estado => ,
         sensor_abrir_cerrar=> sensor_abrir_cerrar1
        );

    decodificador_piso_boton : decodificador_piso
    PORT MAP (
        boton_piso => boton_piso,
        clk => Hz60,
        piso => piso_decod1
        );

    decodificador_piso0 :decodificador_piso
    PORT MAP (
        clk => Hz60,
        boton_piso => piso_sim1,
        piso => piso_actual1
        );

leds_puerta<=puerta1;
leds_motor<=motor_ascensor1;


end Structural;

