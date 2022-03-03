module SW
  def self.user_escape_example_1()
    a = 0
    count = 100000000
    result = count.times { |i|
      a += 1
      if i.modulo(10000000) == 0
        puts 'Operation 1 - checking for keyboard input'
        break :cancelled if SW::Util.test_for_escape()
      end
    }
    
    if result == :cancelled
      puts 'Operation 1 Cancelled by User Escape'
    else
      puts "Operation 1 Completed"
    end
  end


  def self.user_escape_example_2()
    begin
      # Create a one-shot timer that will 'time out' in one second 
      check_interval = 1.0
      timer = SW::Timers::SingleShotTimer.new
      timer.run(check_interval)

      # Execute a long loop while checking the timer time_out.
      a = []
      b = [1]
      100000.times {
        a += b
        
        if timer.timed_out?
          puts 'Operation 2 - checking for keyboard input'
          SW::Util.raise_exception_on_escape
          timer.run(check_interval) # restart the timer
        end
        
      } # The end of times
      
      puts "Operation 2 Completed"

    rescue => e
      if e.is_a?(SW::Util::UserEscapeException)
        puts 'Operation 2 Cancelled by User Escape'
      else
        raise e
      end
    end
  end
end

SW.user_escape_example_1()
SW.user_escape_example_2()

nil


