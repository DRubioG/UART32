library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity RX is
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
end RX;

architecture Behavioral of RX is
type fsm is (S0, S1, S2, S3);
signal estado: fsm;
signal cont2: unsigned(9 downto 0);
signal cont_fin, cont_med: std_logic;
signal en_cont: std_logic;
signal contador: unsigned(5 downto 0);
signal rx_ant: std_logic;
begin
process(clk, rx_in)
begin
    if rising_edge(clk) then
        rx_ant<=rx_in;
    end if;
end process;
process(clk, rst)

begin
    if rst=rst_en then
        estado<=S0;
    elsif rising_edge(clk) then
        case estado is
            when S0=>
                if rx_in='0' and rx_ant='1' then 
                    estado<=S1;
                end if;
            when S1=>
                if cont_fin='1' then
                    estado<=S2;
                end if;
            when S2=>
                if cont_med='1' then
                    estado<=S3;
                end if;
            when S3=>
                if cont_fin='1' then
                    estado<=S2;
                end if;
                if(contador=N) then
                    estado<=S0;
                end if;
        end case;
    
    end if;
end process;

process(rst, estado) is
variable data_aux: std_logic_vector(N-1 downto 0);
variable N1: std_logic_vector(9 downto 0);
begin
    if rst=rst_en then
        data_aux:=(others=>'0');
    else
        case estado is
            when S0=> 
                en_cont<='0';
                contador<=(others=>'0');
                data_in<=data_aux;
                data_rx_ok<='0';
            when S1=> --null;
                en_cont<='1';
            when S2=> null;
             
            when S3=>
                data_aux((N-1)-to_integer(contador)):=rx_in;
                contador<= contador+1;
                data_rx_ok <='1';
        end case;
    end if;
end process;

cronometro_de_pulsos: process(clk, rst, en_cont)
variable cont: unsigned(9 downto 0);
begin
    if rst=rst_en then
        cont:=(others=>'0');
        cont_fin<='0';
        cont_med<='0';
        cont2<=(others=>'0');
    elsif rising_edge(clk) then
        if en_cont = '1' then
            cont:=cont+1;
            cont2<=cont;
            cont_fin<='0';
            cont_med<='0';
            if cont=tiempo/2 then
                cont_med<='1';
            end if;
            if(cont=tiempo)then
                cont:=(others=>'0');
                cont_fin<='1';
            end if;
        elsif en_cont='0' then
            cont:=(others=>'0');
            cont_med<='0';
        end if;
    end if;
end process;

end Behavioral;