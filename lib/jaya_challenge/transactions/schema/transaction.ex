defmodule JayaChallenge.Transactions.Schema.Transaction do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias JayaChallenge.Accounts.Schema.Account

  @typedoc """
  The transaction schema spec type.
  """
  @type t :: %__MODULE__{}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transactions" do
    field :amount, :decimal
    field :amount_to, :decimal, virtual: true
    field :currency_from, :string
    field :currency_to, :string
    field :rate, :decimal
    belongs_to :account, Account
    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:currency_from, :amount, :currency_to, :rate, :account_id])
    |> foreign_key_constraint(:account_id)
    |> validate_required([:currency_from, :amount, :currency_to, :rate, :account_id])
    |> validate_number(:amount, greater_than: 0)
  end
end
