class Journey
  attr_reader :entry_station, :exit_station
  PENALTY_FARE = 6
  MINIMUM_FARE = 1
  
  def initialize(entry_station: nil )
    @is_completed = false
    @entry_station = entry_station
  end 

  def complete?
    @is_completed
  end
  
  def fare
    if @entry_station == nil || @exit_station == nil 
      PENALTY_FARE
    else 
      MINIMUM_FARE 
    end 
  end
  
  def finish(exit_station)
    @exit_station = exit_station
    @is_completed = true
    self
  end

end 


