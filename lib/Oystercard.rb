require './lib/journey'

class Oystercard
  attr_reader :balance, :limit, :journeys
  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @limit = MAXIMUM_LIMIT
    @journeys = []  
  end

  def top_up(amount)
    @balance += amount
    fail "#{amount} is over limit!" if over_limit?(amount)
  end

  def touch_in(entry_station)
    fail 'Not enough money' if low_balance?
    @journey = Journey.new(entry_station: entry_station)
  end

  def touch_out(exit_station)
    @journeys << @journey.finish(exit_station)
    deduct(@journey.fare)
    @journey.complete? 
  end

  private

  def over_limit?(amount)
    amount + balance > limit
  end

  def low_balance?
    balance < MINIMUM_FARE
  end

  def deduct(amount)
    @balance -= amount
  end
 
end
