library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;



entity selector is
    port
    (
        clk : in std_logic;
        valid : in std_logic;
        data_out : out std_logic_vector(7 downto 0); --we should use the first "something" bits to specify a register and then the other ones to perform an operation on it
        data_in : in std_logic_vector(7 downto 0);
        data_in_1 : in std_logic_vector(7 downto 0);
        data_in_2 : in std_logic_vector(7 downto 0);
        data_in_3 : in std_logic_vector(7 downto 0);
        data_in_4 : in std_logic_vector(7 downto 0);
        valid_out : out std_logic := '0'
        
    );
end entity selector;

architecture behavioral of selector is
    type regArray is array(3 downto 0) of std_logic_vector(7 downto 0);
    signal registers : regArray;
    
begin
    registers(0) <= data_in_1;
    registers(1) <= data_in_2;
    registers(2) <= data_in_3;
    registers(3) <= data_in_4;
    selector : process(clk)
    begin
     if(rising_edge(clk)) then
     if(valid = '1') then
     if(to_integer(unsigned(data_in(4 downto 3))) = 2) then
        valid_out <= '1';
        data_out <= registers(to_integer(unsigned(data_in(6 downto 5)))) + registers(to_integer(unsigned(data_in(2 downto 1))));
     else
        valid_out <= '1';
        if to_integer(unsigned(data_in(6 downto 5))) = 0 then
            data_out <= data_in_1;
        elsif to_integer(unsigned(data_in(6 downto 5))) = 1 then
            data_out <= data_in_2;
        elsif to_integer(unsigned(data_in(6 downto 5))) = 2 then
            data_out <= data_in_3;
        elsif to_integer(unsigned(data_in(6 downto 5))) = 3 then
            data_out <= data_in_4;
        end if;
     
     end if;
     else valid_out <= '0';
     end if;
     end if;
end process;

end behavioral;

