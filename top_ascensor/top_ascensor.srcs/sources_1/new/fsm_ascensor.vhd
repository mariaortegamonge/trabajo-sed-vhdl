
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 use ieee.std_logic_arith.ALL;
 use ieee.std_logic_unsigned.ALL;

entity fsm_ascensor is
PORT (
   RESET_N : in std_logic;
   CLK : in std_logic; --de 60 hz llega del clock
   piso: in std_logic_vector(2 downto 0); --piso queremos ir llega del decoder
   piso_actual:in std_logic_vector(2 downto 0);--viene del estado_piso
   sensor_entrapersona: in std_logic;
   sensor_abrir:in std_logic;--para brir puertas, estamos listos para abrir
   sensor_abrir_cerrar: in std_logic_vector(1 downto 0); --10 abiero, 01 cerrado, 00 others
   motor: out std_logic_vector(1 downto 0);--10 subir, 01 bajando,00 off
   puerta: out std_logic_vector(1 downto 0);--10 abrir,01 bajar
   destino_piso: out std_logic_vector(2 downto 0)
   );
end fsm_ascensor;

architecture Behavioral of fsm_ascensor is
type STATES is (inicio,marcha,espera,abrir,cerrar);
signal current_state : STATES:=inicio;
signal next_state : STATES;
signal destino_i: std_logic_vector(2 downto 0);-- variable donde se queda el valor del piso al que queremos ir

begin
--empezamos con el current state
decoder_state: process(CLK,RESET_N)--cambiar el estado en el que estamos
begin
 if RESET_N ='0' then 
  current_state<=inicio;
 elsif rising_edge(CLK) then 
  current_state<=next_state;
 end if;
end process;

decoder_next_state: process(current_state,piso,piso_actual,sensor_abrir,sensor_abrir_cerrar)--cambiamos el proximo estado en funcion de las entradas

begin
next_state <= current_state; --asignamos a la saliuda un valor para evitar latches
 
 case current_state is
      when inicio=>
        if piso_actual="001" and sensor_abrir_cerrar="01" then  -- si estamos en el piso nulo y la pueta esta cerrada
            next_state<=abrir;
        end if;
       when abrir=>
        if sensor_abrir_cerrar="10" then --esta abierta las puertas 
            destino_i<=(others=>'0'); --si ya hemos llegado al piso y hemos abierto las puertas
            next_state<=espera;
        end if;
        when espera=>
            if piso /= "000" and piso_actual/=piso then --si pulsas un boton y no es en el que estas
               destino_i<=piso;--guardamos el piso pulsado
                next_state<=cerrar;
            end if;
        when cerrar=>
            if sensor_entrapersona='1' then --mientras que cirra entra alguien
                next_state<=abrir; --si viene alguien volvemos a abrir
                elsif sensor_abrir_cerrar ="01" then --la puerta haya terminado de cerrarse
                next_state<=marcha;
            end if;
         when marcha=>
            if destino_i=piso_actual and sensor_abrir='1' then --si estamos en el piso al que queremos ir 
                next_state<=abrir;
            end if;
         when others=>
            next_state<=inicio;
      end case;
end process;

movimiento_motor :process(current_state,sensor_abrir_cerrar)
begin
case current_state is
    when inicio =>
        destino_i<="001";--inicializamos en ascebsor en el piso 1
        if sensor_abrir_cerrar/="01" then --las puertas no estan abiertas
            puerta<="01";--accionamos apertura de puertas
        end if;
        if piso_actual /= "001" and sensor_abrir_cerrar="01" then --si no estamos en el bajo y las puertas estan cerradas 
            motor<="01"; --bajamos hasta estar en el 001
            puerta<="00";-- las puertas no se mueven, el ascensor esta en marcha
         else --si estamos en el piso bajo y las puertas abiertas
            motor<="00";
            puerta<="00"; --no movemos puertas ni motor
         end if;
     when marcha =>
     		puerta <= "00";	--Puerta cerrada
				if (destino_i > piso_actual) then--queremos subir
					motor <= "10";	--Subir
				elsif (destino_i < piso_actual ) then --queremos bajar
					motor <= "01"; 	--Bajar
				else
					motor <= "00"; 	--Parado por seguridad... no llegaremos a este estado en principio. No estaríamos en marcha, a no ser que no se de al utilísimo boton de sensor_apertura.
				end if;		

			when abrir => 
				puerta <= "10"; 		--Abrir puerta
				motor <=  "00"; 		       --Parado mientras abre

			when cerrar => 
				puerta <= "01";	     --Cerrar puerta;
				motor <= "00";		     --Parado mientrs cierra

			when espera => 
				puerta <= "00"; 	--Puerta quieta
				motor <= "00";  --motor quieto

			when others => 	--Por defecto  todo parado
				motor <= "00";
				puerta <= "00";
		end case;
end process;
destino_piso<=destino_i;
      
end Behavioral;