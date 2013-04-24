-------------------------------------------------------------------------------
-- arm_stub.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity arm_stub is
  port (
    processing_system7_0_MIO : inout std_logic_vector(53 downto 0);
    processing_system7_0_PS_SRSTB_pin : in std_logic;
    processing_system7_0_PS_CLK_pin : in std_logic;
    processing_system7_0_PS_PORB_pin : in std_logic;
    processing_system7_0_DDR_Clk : inout std_logic;
    processing_system7_0_DDR_Clk_n : inout std_logic;
    processing_system7_0_DDR_CKE : inout std_logic;
    processing_system7_0_DDR_CS_n : inout std_logic;
    processing_system7_0_DDR_RAS_n : inout std_logic;
    processing_system7_0_DDR_CAS_n : inout std_logic;
    processing_system7_0_DDR_WEB_pin : out std_logic;
    processing_system7_0_DDR_BankAddr : inout std_logic_vector(2 downto 0);
    processing_system7_0_DDR_Addr : inout std_logic_vector(14 downto 0);
    processing_system7_0_DDR_ODT : inout std_logic;
    processing_system7_0_DDR_DRSTB : inout std_logic;
    processing_system7_0_DDR_DQ : inout std_logic_vector(31 downto 0);
    processing_system7_0_DDR_DM : inout std_logic_vector(3 downto 0);
    processing_system7_0_DDR_DQS : inout std_logic_vector(3 downto 0);
    processing_system7_0_DDR_DQS_n : inout std_logic_vector(3 downto 0);
    processing_system7_0_DDR_VRN : inout std_logic;
    processing_system7_0_DDR_VRP : inout std_logic;
    processing_system7_0_SPI0_SS1_O_pin : out std_logic;
    processing_system7_0_SPI0_SS2_O_pin : out std_logic;
    processing_system7_0_SPI0_SCLK_pin : inout std_logic;
    processing_system7_0_SPI0_MOSI_pin : inout std_logic;
    processing_system7_0_SPI0_MISO_pin : inout std_logic;
    processing_system7_0_SPI0_SS_pin : inout std_logic;
    processing_system7_0_SPI1_SS1_O_pin : out std_logic;
    processing_system7_0_SPI1_SS2_O_pin : out std_logic;
    processing_system7_0_SPI1_SCLK_pin : inout std_logic;
    processing_system7_0_SPI1_MOSI_pin : inout std_logic;
    processing_system7_0_SPI1_MISO_pin : inout std_logic;
    processing_system7_0_SPI1_SS_pin : inout std_logic;
    axi_gpio_0_GPIO_IO_I_pin : in std_logic_vector(0 to 0);
    axi_gpio_0_GPIO2_IO_O_pin : out std_logic_vector(0 to 0)
  );
end arm_stub;

architecture STRUCTURE of arm_stub is

  component arm is
    port (
      processing_system7_0_MIO : inout std_logic_vector(53 downto 0);
      processing_system7_0_PS_SRSTB_pin : in std_logic;
      processing_system7_0_PS_CLK_pin : in std_logic;
      processing_system7_0_PS_PORB_pin : in std_logic;
      processing_system7_0_DDR_Clk : inout std_logic;
      processing_system7_0_DDR_Clk_n : inout std_logic;
      processing_system7_0_DDR_CKE : inout std_logic;
      processing_system7_0_DDR_CS_n : inout std_logic;
      processing_system7_0_DDR_RAS_n : inout std_logic;
      processing_system7_0_DDR_CAS_n : inout std_logic;
      processing_system7_0_DDR_WEB_pin : out std_logic;
      processing_system7_0_DDR_BankAddr : inout std_logic_vector(2 downto 0);
      processing_system7_0_DDR_Addr : inout std_logic_vector(14 downto 0);
      processing_system7_0_DDR_ODT : inout std_logic;
      processing_system7_0_DDR_DRSTB : inout std_logic;
      processing_system7_0_DDR_DQ : inout std_logic_vector(31 downto 0);
      processing_system7_0_DDR_DM : inout std_logic_vector(3 downto 0);
      processing_system7_0_DDR_DQS : inout std_logic_vector(3 downto 0);
      processing_system7_0_DDR_DQS_n : inout std_logic_vector(3 downto 0);
      processing_system7_0_DDR_VRN : inout std_logic;
      processing_system7_0_DDR_VRP : inout std_logic;
      processing_system7_0_SPI0_SS1_O_pin : out std_logic;
      processing_system7_0_SPI0_SS2_O_pin : out std_logic;
      processing_system7_0_SPI0_SCLK_pin : inout std_logic;
      processing_system7_0_SPI0_MOSI_pin : inout std_logic;
      processing_system7_0_SPI0_MISO_pin : inout std_logic;
      processing_system7_0_SPI0_SS_pin : inout std_logic;
      processing_system7_0_SPI1_SS1_O_pin : out std_logic;
      processing_system7_0_SPI1_SS2_O_pin : out std_logic;
      processing_system7_0_SPI1_SCLK_pin : inout std_logic;
      processing_system7_0_SPI1_MOSI_pin : inout std_logic;
      processing_system7_0_SPI1_MISO_pin : inout std_logic;
      processing_system7_0_SPI1_SS_pin : inout std_logic;
      axi_gpio_0_GPIO_IO_I_pin : in std_logic_vector(0 to 0);
      axi_gpio_0_GPIO2_IO_O_pin : out std_logic_vector(0 to 0)
    );
  end component;

  attribute BOX_TYPE : STRING;
  attribute BOX_TYPE of arm : component is "user_black_box";

begin

  arm_i : arm
    port map (
      processing_system7_0_MIO => processing_system7_0_MIO,
      processing_system7_0_PS_SRSTB_pin => processing_system7_0_PS_SRSTB_pin,
      processing_system7_0_PS_CLK_pin => processing_system7_0_PS_CLK_pin,
      processing_system7_0_PS_PORB_pin => processing_system7_0_PS_PORB_pin,
      processing_system7_0_DDR_Clk => processing_system7_0_DDR_Clk,
      processing_system7_0_DDR_Clk_n => processing_system7_0_DDR_Clk_n,
      processing_system7_0_DDR_CKE => processing_system7_0_DDR_CKE,
      processing_system7_0_DDR_CS_n => processing_system7_0_DDR_CS_n,
      processing_system7_0_DDR_RAS_n => processing_system7_0_DDR_RAS_n,
      processing_system7_0_DDR_CAS_n => processing_system7_0_DDR_CAS_n,
      processing_system7_0_DDR_WEB_pin => processing_system7_0_DDR_WEB_pin,
      processing_system7_0_DDR_BankAddr => processing_system7_0_DDR_BankAddr,
      processing_system7_0_DDR_Addr => processing_system7_0_DDR_Addr,
      processing_system7_0_DDR_ODT => processing_system7_0_DDR_ODT,
      processing_system7_0_DDR_DRSTB => processing_system7_0_DDR_DRSTB,
      processing_system7_0_DDR_DQ => processing_system7_0_DDR_DQ,
      processing_system7_0_DDR_DM => processing_system7_0_DDR_DM,
      processing_system7_0_DDR_DQS => processing_system7_0_DDR_DQS,
      processing_system7_0_DDR_DQS_n => processing_system7_0_DDR_DQS_n,
      processing_system7_0_DDR_VRN => processing_system7_0_DDR_VRN,
      processing_system7_0_DDR_VRP => processing_system7_0_DDR_VRP,
      processing_system7_0_SPI0_SS1_O_pin => processing_system7_0_SPI0_SS1_O_pin,
      processing_system7_0_SPI0_SS2_O_pin => processing_system7_0_SPI0_SS2_O_pin,
      processing_system7_0_SPI0_SCLK_pin => processing_system7_0_SPI0_SCLK_pin,
      processing_system7_0_SPI0_MOSI_pin => processing_system7_0_SPI0_MOSI_pin,
      processing_system7_0_SPI0_MISO_pin => processing_system7_0_SPI0_MISO_pin,
      processing_system7_0_SPI0_SS_pin => processing_system7_0_SPI0_SS_pin,
      processing_system7_0_SPI1_SS1_O_pin => processing_system7_0_SPI1_SS1_O_pin,
      processing_system7_0_SPI1_SS2_O_pin => processing_system7_0_SPI1_SS2_O_pin,
      processing_system7_0_SPI1_SCLK_pin => processing_system7_0_SPI1_SCLK_pin,
      processing_system7_0_SPI1_MOSI_pin => processing_system7_0_SPI1_MOSI_pin,
      processing_system7_0_SPI1_MISO_pin => processing_system7_0_SPI1_MISO_pin,
      processing_system7_0_SPI1_SS_pin => processing_system7_0_SPI1_SS_pin,
      axi_gpio_0_GPIO_IO_I_pin => axi_gpio_0_GPIO_IO_I_pin(0 to 0),
      axi_gpio_0_GPIO2_IO_O_pin => axi_gpio_0_GPIO2_IO_O_pin(0 to 0)
    );

end architecture STRUCTURE;

