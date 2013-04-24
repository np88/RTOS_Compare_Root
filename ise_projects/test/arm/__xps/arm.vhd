LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY arm IS
PORT (
	processing_system7_0_MIO : INOUT STD_LOGIC_VECTOR(53 DOWNTO 0);
	processing_system7_0_PS_SRSTB_pin : IN STD_LOGIC;
	processing_system7_0_PS_CLK_pin : IN STD_LOGIC;
	processing_system7_0_PS_PORB_pin : IN STD_LOGIC;
	processing_system7_0_DDR_Clk : INOUT STD_LOGIC;
	processing_system7_0_DDR_Clk_n : INOUT STD_LOGIC;
	processing_system7_0_DDR_CKE : INOUT STD_LOGIC;
	processing_system7_0_DDR_CS_n : INOUT STD_LOGIC;
	processing_system7_0_DDR_RAS_n : INOUT STD_LOGIC;
	processing_system7_0_DDR_CAS_n : INOUT STD_LOGIC;
	processing_system7_0_DDR_WEB_pin : OUT STD_LOGIC;
	processing_system7_0_DDR_BankAddr : INOUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	processing_system7_0_DDR_Addr : INOUT STD_LOGIC_VECTOR(14 DOWNTO 0);
	processing_system7_0_DDR_ODT : INOUT STD_LOGIC;
	processing_system7_0_DDR_DRSTB : INOUT STD_LOGIC;
	processing_system7_0_DDR_DQ : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	processing_system7_0_DDR_DM : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	processing_system7_0_DDR_DQS : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	processing_system7_0_DDR_DQS_n : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	processing_system7_0_DDR_VRN : INOUT STD_LOGIC;
	processing_system7_0_DDR_VRP : INOUT STD_LOGIC;
	processing_system7_0_SPI0_SS1_O_pin : OUT STD_LOGIC;
	processing_system7_0_SPI0_SS2_O_pin : OUT STD_LOGIC;
	processing_system7_0_SPI0_SCLK_pin : INOUT STD_LOGIC;
	processing_system7_0_SPI0_MOSI_pin : INOUT STD_LOGIC;
	processing_system7_0_SPI0_MISO_pin : INOUT STD_LOGIC;
	processing_system7_0_SPI0_SS_pin : INOUT STD_LOGIC;
	processing_system7_0_SPI1_SS1_O_pin : OUT STD_LOGIC;
	processing_system7_0_SPI1_SS2_O_pin : OUT STD_LOGIC;
	processing_system7_0_SPI1_SCLK_pin : INOUT STD_LOGIC;
	processing_system7_0_SPI1_MOSI_pin : INOUT STD_LOGIC;
	processing_system7_0_SPI1_MISO_pin : INOUT STD_LOGIC;
	processing_system7_0_SPI1_SS_pin : INOUT STD_LOGIC;
	gpio_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	gpio_in : IN STD_LOGIC
	);
END arm;

ARCHITECTURE STRUCTURE OF arm IS

BEGIN
END ARCHITECTURE STRUCTURE;
