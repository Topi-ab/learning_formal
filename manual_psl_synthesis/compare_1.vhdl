library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compare_1 is
	port(
		clk_in: in std_logic;
		sreset_in: in std_logic;
		a_in: in std_logic_vector(7 downto 0)
	);
end;

architecture tester of compare_1 is
	component ex_1 is
		port(
			clk_in: in std_logic;
			sreset_in: in std_logic;
			
			a_in: in std_logic_vector(7 downto 0);
			
			vhdl_assert_out: out std_logic;
			\psl_assert.A\: out std_logic;
			\psl_assert.EN\: out std_logic
		);
	end component;
	
	component ex_2 is
		port(
			clk_in: in std_logic;
			sreset_in: in std_logic;
			
			a_in: in std_logic_vector(7 downto 0);
			
			vhdl_assert_out: out std_logic;
			\psl_assert.A\: out std_logic;
			\psl_assert.EN\: out std_logic
		);
	end component;
	
	type ex_t is record
		vhdl_assert: std_logic;
		psl_assert_en: std_logic;
		psl_assert_a: std_logic;
	end record;
	
	type check_t is record
		vhdl_ok: std_logic;
		psl_ok: std_logic;
		equal: std_logic;
	end record;
	
	constant check_0: check_t := (
		vhdl_ok => '1',
		psl_ok => '1',
		equal => '1'
	);
	
	signal a_ex_1: ex_t;
	signal ok_ex_1: check_t := check_0;
	
	signal a_ex_2: ex_t;
	signal ok_ex_2: check_t := check_0;
	
	function hold(a: check_t; b: ex_t) return check_t is
		variable r: check_t;
	begin
		r := a;
		if b.vhdl_assert = '0' then
			r.vhdl_ok := '0';
		end if;
		if b.psl_assert_en = '1' and b.psl_assert_a = '0' then
			r.psl_ok := '0';
		end if;
		r.equal := '1';
		if r.vhdl_ok /= r.psl_ok then
			r.equal := '0';
		end if;
		
		return r;	
	end;
begin
	ex_1_i: ex_1
		port map(
			clk_in => clk_in,
			sreset_in => sreset_in,
			a_in => a_in,
			vhdl_assert_out => a_ex_1.vhdl_assert,
			\psl_assert.EN\ => a_ex_1.psl_assert_en,
			\psl_assert.A\ => a_ex_1.psl_assert_a
		);
	
	ex_2_i: ex_2
		port map(
			clk_in => clk_in,
			sreset_in => sreset_in,
			a_in => a_in,
			vhdl_assert_out => a_ex_2.vhdl_assert,
			\psl_assert.EN\ => a_ex_2.psl_assert_en,
			\psl_assert.A\ => a_ex_2.psl_assert_a
		);
	
	process(clk_in)
	begin
		if rising_edge(clk_in) then
			ok_ex_1 <= hold(ok_ex_1, a_ex_1);
			ok_ex_2 <= hold(ok_ex_2, a_ex_2);
		end if;
	end process;
	
	default clock is rising_edge(clk_in);
	
	test_ex_1: assert always ok_ex_1.equal = '1';
	test_ex_2: assert always ok_ex_2.equal = '1';
end;
