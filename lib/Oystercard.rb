class Oystercard
  attr_reader :balance, :limit

  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1
  def initialize
    @balance = 0
    @limit = MAXIMUM_LIMIT
    @in_journey = false
  end

  def top_up(amount)
    self.balance += amount
    fail "#{amount} is over limit!" if over_limit?(amount)
  end

  def deduct(amount)
    self.balance -= amount
  end

  def touch_in
    fail 'Not enough money' if low_balance?
    self.in_journey = true
  end

  def touch_out
    self.in_journey = false
  end

  private

  attr_writer :balance
  attr_accessor :in_journey

  alias :in_journey? :in_journey
  undef :in_journey

  def over_limit?(amount)
    amount + balance > limit
  end

  def low_balance?
    balance < MINIMUM_FARE    
  end
end
