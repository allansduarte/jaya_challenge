defmodule JayaChallenge.Transactions.Commands.CurrencyConverter do
  @moduledoc """
  Handles a transaction.

  Fetch the latest rate and commit a transaction with the given params
  """

  require Logger

  alias JayaChallenge.Accounts
  alias JayaChallenge.ExternalClients.ExchangeRate
  alias JayaChallenge.Transactions
  alias JayaChallenge.Transactions.Inputs.CurrencyConverter
  alias JayaChallenge.Transactions.Schema.Transaction
  alias JayaChallenge.Repo

  @type possible_errors :: :not_found | Ecto.Changeset.t()

  @spec execute(input :: CurrencyConverter.t()) :: {:ok, Transaction.t()} | {:error, possible_errors()}
  def execute(input) do
    Repo.transaction(fn ->
      with {:ok, request} <- ExchangeRate.latest_rate,
           {:ok, rate_from} <- fetch_rate(input.currency_from, request),
           {:ok, rate_to} <- fetch_rate(input.currency_to, request),
           {:ok, amount_to} <- calculate_amount_to(input.amount, rate_from, rate_to),
           {:ok, user} <- Accounts.get_user(input.account_id),
           {:ok, transaction} <- create_transaction(user, input, amount_to, rate_from) do
        transaction
      else
        {:error, err} ->
          Logger.error("""
          Error processing Currency Conversion
          error: #{inspect(err)}
          """)

          Repo.rollback(err)

        err ->
          Logger.error("""
          Unexpected error processing Currency Conversion
          error: #{inspect(err)}
          """)

          Repo.rollback(err)
      end
    end)
    |> case do
      {:ok, transaction} -> {:ok, transaction}
      {:error, err} -> {:error, err}
    end
  end

  defp create_transaction(user, input, amount_to, rate_from) do
    Transactions.create_transaction(user, %{
      amount: input.amount,
      currency_from: input.currency_from,
      currency_to: input.currency_to,
      rate: rate_from,
      amount_to: amount_to
      })
  end

  defp fetch_rate(currency, request), do: Map.fetch(request.body["rates"], currency)

  defp calculate_amount_to(amount, rate_from, rate_to), do: {:ok, amount * ((1 / rate_from) * rate_to)}
end
