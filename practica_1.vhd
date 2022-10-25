library ieee;
use ieee.std_logic_1164.all;

entity practica_1 is

port (y: in std_logic_vector(3 downto 0);
 z: out std_logic_vector(3 downto 0));

end practica_1;

architecture concurrente_sdp of practica_1 is
begin

  z(2) <= (y(3) and y(2)) or ((not y(2)) and y(0)) or ((not y (2)) and y(1));

end concurrente_sdp;

---------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity practica_1 is

port (y: in std_logic_vector(3 downto 0);
 z: out std_logic_vector(3 downto 0));

end practica_1;

architecture concurrente_pds of practica_1 is
begin

  z(1) <= (y(3) or y(1)) and (y(2) or y(1) or (not y(0))) and ((not y(3)) or y(2) or (not y(1)));

end concurrente_pds;

-----------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity practica_1 is

port (y: in std_logic_vector(3 downto 0);
 z: out std_logic_vector(3 downto 0));

end practica_1;

architecture estructural_nor of practica_1 is
	
signal notY0, notY1, notY2, notY3, s1, s2, s3, s4, S5: std_logic;
	
begin

	Pnot0: entity work.not1 port map(y(0), notY0);
	Pnot1: entity work.not1 port map(y(1), notY1);
	Pnot2: entity work.not1 port map(y(2), notY2);
	Pnot3: entity work.not1 port map(y(3), notY3);

	Pnor1: entity work.nor3 port map(notY3, y(2), y(0), s1);
	Pnor2: entity work.nor3 port map(y(3), notY0, notY2, s2);
	Pnor3: entity work.nor2 port map(notY1, notY0, s3);
	Pnor4: entity work.nor2 port map(notY3, notY1, s4);

	PnorFIN: entity work.nor4 port map(s1, s2, s3, s4, S5);
	PnotFIN: entity work.not1 port map(S5, z(0));
	
end estructural_nor;

--------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity practica_1 is

port (y: in std_logic_vector(3 downto 0);
 z: out std_logic_vector(3 downto 0));

end practica_1;

architecture estructural_deco of practica_1 is
	
	signal enable: std_logic;
	signal r: std_logic_vector(2 downto 0);
	signal x: std_logic_vector(7 downto 0);
	signal t0, t1, t2, t3: std_logic;

	
begin
	
	r(0) <= y(0);
	r(1) <= y(1);
	r(2) <= y(2);

	DECO: entity work.deco3a8 port map(enable, r, x);

	Pand1: entity work.and2 port map(x(4),y(3), t0); 
	Pand2: entity work.and2 port map(x(5),y(3), t1); 
	Pand3: entity work.and2 port map(x(6),y(3), t2); 
	Pand4: entity work.and2 port map(x(7),y(3), t3); 

	Por: entity work.or7 port map(x(1), x(2), x(3), t0, t1, t2, t3, z(2));

end estructural_deco;

--------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity practica_1 is

port (y: in std_logic_vector(3 downto 0);
 z: out std_logic_vector(3 downto 0));

end practica_1;

architecture estructural_mux of practica_1 is
	
	signal enable: std_logic;
	signal r: std_logic_vector(7 downto 0);
	signal sel: std_logic_vector(2 downto 0);

begin
	r(4) <= not y(0);

	r(0) <= '0';
	r(2) <= '0';
	r(5) <= '0';

	r(1) <= '1';
	r(3) <= '1';
	r(6) <= '1';
	r(7) <= '1';
	

	sel(0) <= y(1);
	sel(1) <= y(2);
	sel(2) <= y(3);

	MUX: entity work.mux8a1 port map (enable, r, sel, z(1)); 
	

end estructural_mux;

