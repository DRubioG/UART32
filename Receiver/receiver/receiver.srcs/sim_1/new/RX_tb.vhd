
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity RX_tb is
end RX_tb;

architecture Behavioral of RX_tb is
component RX is
    generic(
        tiempo: integer:=1000;
        N: integer:=32
    );
    port (
        clk: in std_logic;
        rst: in std_logic;
        rx_in: in std_logic;
        data_in: out std_logic_vector(N-1 downto 0)
        );
end component;
constant tiempo : integer:=1000;
constant N: integer:=32;
signal clk_i: std_logic:='0';
signal rst_i: std_logic;
signal rx_in_i: std_logic:='0';
signal data_in_i: std_logic_vector(N-1 downto 0);
 
begin
DUT: entity work.RX
    generic map(
        tiempo => tiempo,
        N => N)
    port map(
        clk => clk_i,
        rst => rst_i,
        rx_in => rx_in_i,
        data_in => data_in_i
        );
clk_i <= not(clk_i) after 10 ns;
rst_i <='1', '0' after 50 ns;
--rx_in_i<=not(rx_in_i) after 20 us;

process 
begin
    for I in 0 to 16 loop
        rx_in_i<='0';
        wait for 20 us;
        rx_in_i<='1';
        wait for 20 us;
        rx_in_i<='1';
    end loop;
    rx_in_i<='1';
    wait for 400 us;
end process;
end Behavioral;
