defmodule JayaChallenge.Transactions.Inputs.CurrencyConverter do
  @moduledoc """
  Input to create a transaction.
  """

  use JayaChallenge.ValueObjectSchema

  @required [:account_id, :amount, :currency_from, :currency_to]
  @valid_symbols ~w{BRL USD EUR JPY}

  embedded_schema do
    field :account_id, :string
    field :amount, :integer
    field :currency_from, :string
    field :currency_to, :string
  end

  @doc false
  def changeset(model, params) do
    model
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_number(:amount, greater_than: 0)
    |> validate_inclusion(:currency_from, @valid_symbols)
    |> validate_inclusion(:currency_to, @valid_symbols)
  end
end
