class Oystercard
  attr_reader :balance, :limit

  DEFAULT_LIMIT = 90

  def initialize
    @balance = 0
    @limit = DEFAULT_LIMIT
  end

  def top_up(amount)
    self.balance += amount
    fail "#{amount} is over limit!" if over_limit?(amount)
  end

  def deduct(amount)
    self.balance -= amount
  end

  private

  attr_writer :balance

  def over_limit?(amount)
    amount + balance > limit
  end
end
