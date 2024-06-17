defmodule JayaChallengeWeb.TransactionsController do
  @moduledoc false
  use JayaChallengeWeb, :controller

  alias JayaChallenge.Accounts
  alias JayaChallenge.Transactions

  @doc "List transactions"
  @spec index(Conn.t(), params :: map()) :: Conn.t()
  def index(conn, %{"accounts_id" => user_id}) do
    with {:ok, user} <- Accounts.get_user(user_id) do
      render(conn, "index.json", transactions: user)
    end
  end

  @doc "List specific transaction"
  @spec show(Conn.t(), params :: map()) :: Conn.t()
  def show(conn, %{"id" => id}) do
    with {:ok, transaction} <- Transactions.get_transaction(id) do
      render(conn, "show.json", transaction: transaction)
    end
  end
end
