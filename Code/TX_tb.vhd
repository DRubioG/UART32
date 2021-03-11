library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity TX_tb is
end TX_tb;

architecture Behavioral of TX_tb is
component TX is
generic(
        N : integer :=32;
        frec : integer := 1000;
        rst_en : std_logic := '1'
        );
  Port ( 
      clk,rst : in std_logic;
      data_out : in std_logic_vector(N-1 downto 0);
      data_tx_ok : in std_logic;
      tx_out : out std_logic
  );
end component;
signal rst, data_tx_ok : std_logic;
signal clk : std_logic :='0';
constant N : integer := 32;
constant frec : integer :=1000;
signal data_out : std_logic_vector(N-1 downto 0);
signal tx_out : std_logic;

begin

DUT:  TX
generic map(
N, frec)
port map(
clk=>clk,
 rst=>rst,
 data_out => data_out,
 data_tx_ok => data_tx_ok, 
 tx_out => tx_out);

rst<='1', '0' after 30ns;
clk<=not(clk) after 10ns;
data_out<=x"AAAAAAAA";

process
begin
    data_tx_ok<='0';
    wait for 30ns;
    data_tx_ok<='1';
    wait until clk='1';
    data_tx_ok<='0';
    wait for 2ms;
end process;
end Behavioral;
