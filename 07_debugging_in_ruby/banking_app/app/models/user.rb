class User < ActiveRecord::Base
  has_many :accounts
  has_many :banks, through: :accounts

  def self.number_one
    # More naive solution with multiple sql queries & iteration in ruby
    # number_one_user = nil
    # largest_total_balance_seen = 0
    # users = User.all.each.map do |user|
    #   if user.total_balance >=  largest_total_balance_seen 
    #     number_one_user = user
    #     largest_total_balance_seen = user.total_balance
    #   end
    # end
    # number_one_user

    # AR query based Solution
    user_id, total_balance = Account.group(:user_id).sum(:balance).max
    User.find_by_id(user_id)
  end

  def total_balance
    self.accounts.sum(:balance)
  end

  def balance_by_account_type(account_type)
    self.accounts.where(account_type: account_type).sum(:balance)
  end

  def main_banks
    # naive solution without full AR support
    # amounts_by_balance = {}
    # self.accounts.each do |account|
    #   if amounts_by_balance[account.bank_id]
    #     amounts_by_balance[account.bank_id] += account.balance
    #   else
    #     amounts_by_balance[account.bank_id] = account.balance
    #   end
    # end

    # AR Query based solution
    accounts_by_balance = self.accounts.group(:bank_id).sum(:balance)

    # either way, we end up with a hash containing
    # bank ids as keys and the total balance 
    # deposited in that bank as values
    # so we filter only those whose balance is 
    # greater than 30000 and the keys are the
    # corresponding bank ids
    main_bank_ids = accounts_by_balance.filter do |bank_id, balance|
      balance > 30000
    end.keys
    # Return all banks where the id is one of the ids above
    Bank.where(id: main_bank_ids)
  end

  def international_funds
    # We want to get accounts back, but we 
    # need inforation about the bank the 
    # account belongs to. To get it, we can
    # use the includes method and pass in bank.
    # From there, we can add a where clause.
    # In this case, we want accounts at banks
    # not in the USA. Once we have those, we 
    # can calculate the sum of their balances
    self.accounts.includes(:bank).where.not(bank: {country: "USA"}).sum(:balance)
  end

end