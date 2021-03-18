library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Top is
    generic(
        tiempo : interger:=1000;
        N : integer := 32;
        rst_en : std_logic := '1'
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        --RX
        data_in : out std_logic_vector(N-1 downto 0);
        data_rx_ok : out std_logic;
        rx_in : in std_logic;
        --TX
        data_out : in std_logic_vector(N-1 downto 0);
        data_tx_ok : in std_logic;
        tx_out : out std_logic
    );
entity Top;

architecture Behavioral of Top is
component RX is
generic(
    tiempo: integer:=1000;
    N: integer:=32;
    rst_en: std_logic :='1'
);
port (
    clk: in std_logic;
    rst: in std_logic;
    rx_in: in std_logic;
    data_in: out std_logic_vector(N-1 downto 0);
    data_rx_ok : out std_logic
    );
end component;

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

begin
RX_ent: entity work.RX
    generic map(
        tiempo, N, rst_en
    )
    port map(
        clk => clk,
        rst => rst,
        rx_in => rx_in,
        data_in => data_in,
        data_rx_ok => data_rx_ok
    );

TX_ent: entity work.TX
    generic map(
        N, tiempo, rst_en
    )
    port map(
        clk => clk,
        rst => rst,
        data_out => data_out,
        data_tx_ok => data_tx_ok,
        tx_out => tx_out
    );
end Behavioral;