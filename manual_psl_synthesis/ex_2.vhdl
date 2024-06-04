library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ex_2 is
	port(
		clk_in: in std_logic;
		sreset_in: in std_logic;
		a_in: in std_logic_vector(7 downto 0);
		vhdl_assert_out: out std_logic
	);
end;

architecture tester of ex_2 is
	signal start: std_logic := '1';
	signal start_d1: std_logic := '0';
	signal a_d1: std_logic_vector(7 downto 0);
begin
	default clock is rising_edge(clk_in);
	
	psl_assert: assert always {a_in(0) = '1'} |=> {a_in(0) = '0'};
	
	process(clk_in)
	begin
		if rising_edge(clk_in) then
			a_d1 <= a_in;
			
			start_d1 <= start;
			-- start <= '0';
		end if;
	end process;
	
	process(all)
	begin
		vhdl_assert_out <= '1';
		
		if start_d1 = '1' then
			if a_d1(0) = '1' then
				if a_in(0) /= '0' then
					vhdl_assert_out <= '0';
				end if;
			end if;
		end if;
	end process;
end;
