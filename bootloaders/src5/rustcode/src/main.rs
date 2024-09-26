#![no_std]
#![no_main]
#![feature(naked_functions)]
#![cfg_attr(debug_assertions, allow(dead_code, unused_imports))]
#[allow(unused_variables)]
#[allow(non_snake_case)]
#[allow(dead_code)]

//#![feature(core_panic)]
#[allow(unused_imports)]
use core::panic::PanicInfo;
use core::arch::asm;
use core::slice;
use core::iter;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {


    loop {}
}

#[repr(u8)]
pub enum Color {
    Black = 0x0,
    Blue = 0x1,
    Green = 0x2,
    Cyan = 0x3,
    Red = 0x4,
    Purple = 0x5,
    Brown = 0x6,
    Gray = 0x7,
    DarkGray = 0x8,
    LightBlue = 0x9,
    LightGreen = 0xa,
    LightCyan = 0xb,
    LightRed = 0xc,
    Pink = 0xd,
    Yellow = 0xe,
    White = 0xf,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
#[repr(transparent)]
struct ColorCode(u8);

/*impl ColorCode {
    fn new(foreground: Color, background: Color) -> ColorCode {
        return ColorCode((background as u8) << 4 | (foreground as u8))
    }
}*/

// Input Output
//const VGA_MEMORY: *const u8 = 0xb8000 as *const u8;

//#[no_mangle]
//#[inline(always)]


#[no_mangle]
#[inline(always)]
pub unsafe fn outb(port: u16, value: u8){
    asm!(  "mov dx, [{0}]
            out dx, al",
            in(reg) &port,
            in("al") value,
    );
}

#[no_mangle]
#[inline(always)]
pub unsafe fn inb(port: u16) -> u8 {
    let mut return_value: u8;
    asm!(  "mov dx, [{0}]
            in al, dx",
            in(reg) &port,
            out("al") return_value,
        
    );
    return_value
}


#[no_mangle]
unsafe fn set_cursor(position: u16) {
    outb(0x3D4, 0x0F);
    outb(0x3D5, (position & 0xff) as u8);
    outb(0x3D4, 0x0E);
    outb(0x3D5, (position >> 8) as u8 & 0xff as u8);
}
/*#[no_mangle]
unsafe fn print_string(position:u16, str: &[u8]){

    let mut index: u32 = position as u32;
    let strlen = str.len();
    let mut fasz = 0;

    while fasz != strlen{
        *((0xb8000 +index*2) as *const u8) = *str;
        index+=1;
        fasz+=1;
    }
    set_cursor(index as u16+257)
}*/

/*fn poscalc(x: u8, y: u8) -> u16{
    return ((80 * y)+x) as u16;

}*/

static HELLO: &[u8] = b"Hello World!";
//#[naked]
#[no_mangle]
pub extern "C" fn _start() -> !{
    /*let teststring: &[u8] = b"gugi";
    //let mut stringsize = teststring.len();
    //let mut stringpointer = teststring;
    //let mut the_pointer_of_it = &stringpointer;
    //let startofthestring: *mut u8 = &teststring as u8;

    unsafe {
        let mut cursorpos:u16 = 80;
        cursorpos+=257;
        //let cursorpointer: *mut u16 = &mut cursorpos;
        
        //set_cursor(cursorpos);
        /*asm!("mov bx, [{0}]",
             "call set_cursor",
             in(reg_abcd) cursorpointer,
        );*/
        set_cursor(cursorpos);
        print_string(cursorpos-257, teststring);
    }*/
    unsafe{set_cursor(257)}
    loop{};
}
