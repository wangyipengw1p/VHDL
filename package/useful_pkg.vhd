------
package name_pkg is
constant bit_w:             integer     := 9;
constant bit_range:         integer     := 255;
constant FIFO_depth:        integer     := 512;
constant pointer_w:         integer     := 9;

subtype DATA is std_logic_vector(bit_w - 1 downto 0);
subtype DATA_extend is std_logic_vector(2*bit_w - 1 downto 0);

type DATAV is array (integer range<>) of DATA;
type DATAV_extend is array (integer range<>) of DATA_extend;

subtype KERNAL is DATAV(24 downto 0);
type KERNALV is array (integer range<>) of KERNAL;

function "&" (L:DATAV; R: DATAV) return DATAV;
--function "&" (L:DATA; R: DATA) return DATAV;
function "&" (L:DATA; R: DATAV) return DATAV;
--function "&" (L:DATAV; R: DATA) return DATAV;
end package;

package body name_pkg is
    function "&" (L:DATAV; R: DATAV) return DATAV is
    variable concat: DATAV(L'length + R'length - 1 downto 0);
    begin
         concat(L'length + R'length - 1 downto R'length) := L;
         concat(R'length - 1 downto 0) := R;
         return concat;
    end function;
--    function "&" (L:DATA; R: DATA) return DATAV is
--    variable concat: DATAV(1 downto 0);
--    begin
--        concat(1) := L;
--        concat(0) := R;
--        return(concat);
--    end function;
--    function "&" (L:DATAV; R: DATA) return DATAV is
--    variable concat: DATAV(L'length downto 0);
--    begin
--        concat(L'length downto 1) := L;
--        concat(0) := R;
--        return(concat);
--    end function;
    function "&" (L:DATA; R: DATAV) return DATAV is
    variable concat: DATAV(R'length downto 0);
    begin
        concat(R'length) := L;
        concat(R'length - 1 downto 0) := R;
        return(concat);
    end function;
end package body;
