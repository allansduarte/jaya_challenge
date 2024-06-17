defmodule JayaChallengeWeb.TransactionsView do
  @moduledoc false
  use JayaChallengeWeb, :view

  def render("index.json", %{transactions: user}) do
    render_many(user.transactions, __MODULE__, "transaction.json")
  end

  def render("show.json", %{transaction: transaction}) do
    render_one(transaction, __MODULE__, "transaction.json")
  end

  def render("transaction.json", %{transactions: transaction}) do
    %{
      id: transaction.id,
      currency_from: transaction.currency_from,
      currency_to: transaction.currency_to,
      amount: transaction.amount,
      rate: transaction.rate,
      user_id: transaction.account_id,
      amount_to: transaction.amount_to,
      created_at: transaction.inserted_at
    }
  end
end
