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

    

