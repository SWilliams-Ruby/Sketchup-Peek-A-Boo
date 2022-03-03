# Sketchup-Peek-A-Boo
sw_peekaboo.rb a set of non-blocking methods to read windows keyboard input with embedded Ruby scripts

In which are defined: 
  SW::Util.raise_exception_on_escape()
  SW::Util.test_for_escape()
  SW::Util.getkeys_nonblocking()
  and the module SW::User32   (User32.dll)

Also a new threaded timer class: 
  SW::Timers::SingleShotTimer

And a smattering of memory dump routines
  SW::Util.memory_dump_ruby_object()
  SW::Util.memory_dump_address()
  SW::Util.memory_dump_fiddle_ptr()
  SW::Util.dump_string_as_hex()

S. Williams, January 14, 2022

