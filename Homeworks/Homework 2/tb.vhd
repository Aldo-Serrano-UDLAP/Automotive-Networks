LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb IS
END tb;

ARCHITECTURE behavior OF tb IS 

    -- Se declara el componente para poder simular
    COMPONENT CRC15
    port( 
	CLK: in std_logic;						-- Reloj de la simulacion 
	RST: in std_logic;						-- Reset para poder reiniciar las variables
	BitIN: in std_logic; 					-- Variable que guarda el bit que entrda al sistema
	CRC_Residuo: out unsigned(14 downto 0); -- Cadena de bits que representa el residuo
	CRC_Completado: out std_logic 			-- Variable que determina cuando se termina el calculo (High - 1)
        );
    END COMPONENT;    

   -- Input Signals
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal BitIN: std_logic := '0';
   -- Output Signals
   signal CRC_Residuo: unsigned(14 downto 0);
   signal CRC_Completado: std_logic;
   -- Definicion del periodo de reloj
   constant periodoDeReloj: time := 10 ns;

BEGIN

   -- Instanciamos la Unidad Bajo Prueba (Unit Under Test)
   uut: CRC15 PORT MAP ( 
   		  -- Trasladamos las Input Signals hacia la prueba
          CLK => CLK,
          RST => RST,
          BitIN => BitIN,
          CRC_Residuo => CRC_Residuo,
          CRC_Completado => CRC_Completado
        );

   -- Definimos el comportamiento del reloj
   procesoReloj:process
   begin
        CLK <= '0';
        wait for periodoDeReloj/2;
        CLK <= '1';
        wait for periodoDeReloj/2;
   end process;

   -- Proceso de estimulacion, se generan las Input Signals empleadas en el proceso
   -- En este caso se utilizan los bits de entrada para calcular el CRC-15
   procesoSimulacionCRC: process
   begin
	   
	   -- Primer calculo
      	RST <= '1'; 
        wait for 100 ns;
        wait until falling_edge(CLK);
        RST <= '0';	
		-- Valor de la trama de datos representada en hexadecimal 0xD42E1
        BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '0'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj;
		
        BitIN <= '0'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj; 
		BitIN <= '0'; wait for periodoDeReloj;
        BitIN <= '0'; wait for periodoDeReloj;
		
		BitIN <= '0'; wait for periodoDeReloj;
        BitIN <= '0'; wait for periodoDeReloj;  
		BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '0'; wait for periodoDeReloj;
		
		BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj;
		BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '0'; wait for periodoDeReloj;
		
		BitIN <= '0'; wait for periodoDeReloj;
        BitIN <= '0'; wait for periodoDeReloj;	 
		BitIN <= '0'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj;
		
		BitIN <= '0'; wait for periodoDeReloj;
        wait until CRC_Completado = '1'; wait for periodoDeReloj;
		
		--Segundo Calculo
        RST <= '1';
		wait for 100 ns;
        wait until falling_edge(CLK);
        RST <= '0';	
		-- Valor de la trama de datos representada en hexadecimal 0x
        BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj;
		
        BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj; 
		BitIN <= '0'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj;
		
		BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '0'; wait for periodoDeReloj;  
		BitIN <= '0'; wait for periodoDeReloj;
        BitIN <= '0'; wait for periodoDeReloj;
		
		BitIN <= '0'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj;
		BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj; 
		
		BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '0'; wait for periodoDeReloj;	 
		BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '0'; wait for periodoDeReloj;
		
		BitIN <= '0'; wait for periodoDeReloj;
        wait until CRC_Completado = '1'; wait for periodoDeReloj; 
		
		--Tercer Calculo
        RST <= '1';
		wait for 100 ns;
        wait until falling_edge(CLK);
        RST <= '0';	
		--Valor de la trama de datos representada en hexadecimal 0xAA3B1
		
		BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '0'; wait for periodoDeReloj;
		
        BitIN <= '0'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj; 
		BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '0'; wait for periodoDeReloj;
		
		BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '0'; wait for periodoDeReloj;  
		BitIN <= '0'; wait for periodoDeReloj;
        BitIN <= '0'; wait for periodoDeReloj;
		
		BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '0'; wait for periodoDeReloj;
		BitIN <= '1'; wait for periodoDeReloj;
        BitIN <= '0'; wait for periodoDeReloj; 
		
		BitIN <= '0'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj;	 
		BitIN <= '0'; wait for periodoDeReloj;
        BitIN <= '1'; wait for periodoDeReloj;
		
		BitIN <= '0'; wait for periodoDeReloj;
		wait until CRC_Completado = '1'; wait for periodoDeReloj; 
		
		RST <= '1';
      wait;
   end process;
END;