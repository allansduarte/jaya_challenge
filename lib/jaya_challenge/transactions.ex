defmodule JayaChallenge.Transactions do
  @moduledoc """
  Transaction context.
  """

  import Ecto.Query, warn: false

  alias JayaChallenge.Repo
  alias JayaChallenge.Accounts.Schema.Account
  alias JayaChallenge.Transactions.Schema.Transaction

  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction(id) do
    Transaction
    |> Repo.get(id)
    |> Repo.preload(:account)
    |> case do
      nil -> {:error, :not_found}
      transaction -> {:ok, transaction}
    end
  end

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(%Account{} = user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:transactions, attrs)
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end
end
