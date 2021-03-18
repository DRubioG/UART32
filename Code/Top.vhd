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



begin


end Behavioral;