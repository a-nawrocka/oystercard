class Oystercard
  attr_reader :balance, :limit
  attr_reader :entry_station, :exit_station, :journeys
  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @limit = MAXIMUM_LIMIT
    @in_journey = false
    @entry_station = entry_station     
    @journeys = []  
  end

  def top_up(amount)
    self.balance += amount
    fail "#{amount} is over limit!" if over_limit?(amount)
  end

  def touch_in(entry_station)
    fail 'Not enough money' if low_balance?
    update_journey_status
    self.entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(1)
    @exit_station = exit_station
    journey = { entry_station: @entry_station, exit_station: @exit_station }
    @journeys << journey
    self.entry_station = nil
    update_journey_status    
  end

  private

  attr_writer :balance, :entry_station
  attr_accessor :in_journey
  
  alias :in_journey? :in_journey
  undef :in_journey

  def over_limit?(amount)
    amount + balance > limit
  end

  def low_balance?
    balance < MINIMUM_FARE
  end

  def deduct(amount)
    self.balance -= amount
  end

  def update_journey_status
    if in_journey?
      self.in_journey = false
    else
      self.in_journey = true
    end
  end
end
