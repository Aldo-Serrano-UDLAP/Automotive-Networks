library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;

entity CRC15 is 
port( 
	CLK: in std_logic;						-- Reloj de la simulacion 
	RST: in std_logic;						-- Reset para poder reiniciar las variables
	BitIN: in std_logic; 					-- Variable que guarda el bit que entrda al sistema
	CRC_Residuo: out unsigned(14 downto 0); -- Cadena de bits que representa el residuo
	CRC_Completado: out std_logic 			-- Variable que determina cuando se termina el calculo (High - 1)
	); 
end CRC15; 

architecture Behavioral of CRC15 is

signal CRC_FlipFlops: unsigned(14 downto 0) := (others => '0');

begin

	process(CLK,RST)
	
	variable count : integer := 0;
	variable dataSize : integer := 20; 
	variable crcSize : integer := 15;
	variable finalSize : integer := crcSize + dataSize;
	
	begin
		
		
		-- Limpieza inicial del sistema
	    if(RST = '1') then
	        CRC_FlipFlops <= (others => '0');
	        count := 0;
	        CRC_Completado <= '0';
		-- El calculo inicia una vez haya un flanco de subida del reloj
	    elsif(rising_edge(CLK)) then
	    	-- Calculo para obtener el residuo del CRC-15
	        CRC_FlipFlops(0) <= BitIN xor CRC_FlipFlops(14);
	        CRC_FlipFlops(1) <= CRC_FlipFlops(0);
	        CRC_FlipFlops(2) <= CRC_FlipFlops(1);	  
			CRC_FlipFlops(3) <= CRC_FlipFlops(2) xor CRC_FlipFlops(14);
			CRC_FlipFlops(4) <= CRC_FlipFlops(3) xor CRC_FlipFlops(14);
			CRC_FlipFlops(5) <= CRC_FlipFlops(4);
	        CRC_FlipFlops(6) <= CRC_FlipFlops(5);
	        CRC_FlipFlops(7) <= CRC_FlipFlops(6) xor CRC_FlipFlops(14);
			CRC_FlipFlops(8) <= CRC_FlipFlops(7) xor CRC_FlipFlops(14);  
			CRC_FlipFlops(9) <= CRC_FlipFlops(8);
			CRC_FlipFlops(10) <= CRC_FlipFlops(9) xor CRC_FlipFlops(14);
			CRC_FlipFlops(11) <= CRC_FlipFlops(10); 
			CRC_FlipFlops(12) <= CRC_FlipFlops(11);
			CRC_FlipFlops(13) <= CRC_FlipFlops(12);
			CRC_FlipFlops(14) <= CRC_FlipFlops(13) xor CRC_FlipFlops(14);
			-- Se realiza un conteo de las operaciones realizadas, terminara una vez se alcance el final de la trama de datos
	        count := count + 1; 
			-- Cuando se termina el calculo general, se envia una signal de que el resultado esta listo
	        if(count = finalSize) then
	            count := 0;
	            CRC_Completado <= '1';
	        end if; 
	    end if; 
	end process;    

CRC_Residuo <= CRC_FlipFlops;

end Behavioral;