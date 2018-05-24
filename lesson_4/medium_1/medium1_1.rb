# Ben asked Alyssa to code review the following code:

class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

=begin
Alyssa glanced over the code quickly and said - "It looks fine, except that you
forgot to put the @ before balance when you refer to the balance instance variable
in the body of the positive_balance? method."

"Not so fast", Ben replied. "What I'm doing here is valid - I'm not missing an @!"

Who is right, Ben or Alyssa, and why?
=end

# A: Ben is correct. The `#positive_balance` method is reading/getting the value
# of the `@balance` instance variable. Because we have created an attr_reader
# for this variable, the method is getting the value from the `#balance` method
# and comparing that value to `0`.
