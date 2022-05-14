# Sketchup-Peek-A-Boo
sw_peekaboo.rb a set of non-blocking methods to read windows keyboard input with embedded Ruby scripts

 In which are defined: 
  - SW::PeekaBoo.check_for_user_abort # via escape key or a mouse click
  - SW::PeekaBoo.raise_exception_on_escape()
  - SW::PeekaBoo.test_for_escape()
  - SW::PeekaBoo.getkeys_nonblocking()
  - SW::PeekaBoo.raise_exception_on_lbuttondown
  - SW::PeekaBoo.test_for_lbuttondown
  = and the module SW::PeekaBoo::User32 (User32.dll)
  
Also a new threaded timer class: 
  = SW::Timers::SingleShotTimer

And a smattering of memory dump routines
  - SW::Util.memory_dump_ruby_object()
  - SW::Util.memory_dump_address()
  - SW::Util.memory_dump_fiddle_ptr()
  - SW::Util.dump_string_as_hex()
 
S. Williams, January 14, 2022

```ruby
module SW
  module Example
    def self.example1()
      begin
        model = Sketchup.active_model
        a = []
        b = [1]

        # Start a one second single-shot timer
        duration = 1.0
        timer = SW::Timers::SingleShotTimer.new
        timer.run(duration)
        
        # A loop that will manipulate circa 40 gigabytes of memory
        100000.times {
        
          # Check the timer first so that the rescue-retry functions properly
          if timer.timed_out? # this test is very fast
            p 'checking'
            SW::PeekaBoo.check_for_user_abort()
            timer.run(duration) # restart the timer
          end
          
          a += b # Do some heavy lifting
        }
        
      rescue SW::PeekaBoo::UserEscapeException
        result = UI.messagebox("Would you like to abort this operation?", MB_YESNO)
        retry if result == IDNO
      
      rescue SW::PeekaBoo::UserLeftButtonDownException => e
        result = UI.messagebox("Mouse Click at #{e.message}\n\nWould you like to abort this operation?", MB_YESNO)
        retry if result == IDNO

      end
    end # Example1
  end
end

SW::Example.example1()

    

```


