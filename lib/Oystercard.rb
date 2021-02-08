class Oystercard
  attr_reader :balance, :limit

  DEFAULT_LIMIT = 90

  def initialize
    @balance = 0
    @limit = DEFAULT_LIMIT
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
end
