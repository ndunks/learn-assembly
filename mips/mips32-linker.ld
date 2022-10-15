SECTIONS
{
    . = 0xbfc00000;
    .text :
    {
        *(.*)
        . = 0x3FFFFE;
        SHORT(0xAA55)
    }
    . = ALIGN(4);
	.data : {
		*(.data*)
	}
}