library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity TX is
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
end TX;

architecture Behavioral of TX is
type fsm is (S0, S1, S2, S3, S4);
signal estado : fsm;
signal cont_fin : std_logic;
signal contador : unsigned(5 downto 0);
signal en_cont: std_logic;
begin

process (clk, rst)

begin
    if rst=rst_en then
        estado<=S0;
    elsif rising_edge(clk) then
        case estado is
            when S0 =>
                if data_tx_ok ='1' then
                    estado<=S1;
                 end  if;
             when S1=>
                if cont_fin='1' then
                    estado<=S2;
                end if;
             when S2 =>
                if cont_fin='1' then
                    estado<=S3;
                end if;
             when S3=>
                 if cont_fin='1' then
                    estado<=S2;
                 end if;
                 if contador=N then
                     estado<=S4;
                 end if;
             when S4=>
                if cont_fin='1' then
                    estado<=S0;
                end if;      
             when others=>null;
         end case;
    end if;

end process;

process (rst,estado)

begin
    if rst=rst_en then
        tx_out<='1';
        en_cont<='0';
    else
        case estado is
            when S0=>  
                contador<=(others=>'0');
                en_cont<='0';
                tx_out<='1';
            when S1 =>
                tx_out<='0';
                en_cont<='1';
            when S2=>
                contador<=contador+1;
                tx_out<=data_out(to_integer(contador));
            when S3=>    
                contador<=contador+1;
                tx_out<=data_out(to_integer(contador));
            when S4=>
                null;
             when others=> null;
        end case;
     end if;
end process;

cronometro_de_pulsos: process(clk, rst)
variable cont: unsigned(9 downto 0);
begin
    if rst=rst_en then
        cont:=(others=>'0');
        cont_fin<='0';
    elsif rising_edge(clk) then
        if en_cont='1' then
            cont:=cont+1;
            cont_fin<='0';
            if cont=frec then
                cont_fin<='1';
                cont:=(others=>'0');
            end if;
        elsif en_cont='0' then
            cont:=(others=>'0');
            cont_fin<='0';
        end if;   
     end if;
end process;
end Behavioral;
