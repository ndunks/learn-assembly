SECTIONS
{
    . = 0x80669780;
    .text :
    {
        *(.*)
    }
    . = ALIGN(4);
	.data : {
		*(.data*)
	}
}