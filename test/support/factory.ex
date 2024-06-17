defmodule JayaChallenge.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: JayaChallenge.Repo

  alias JayaChallenge.Accounts.Schema.Account
  alias JayaChallenge.Transactions.Schema.Transaction

  def account_factory do
    %Account{name: "Allan Soares Duarte"}
  end

  def transaction_factory do
    %Transaction{
      amount: 12,
      currency_from: "BRL",
      currency_to: "USD",
      rate: "1.13208",
      account: build(:account)
    }
  end
end
