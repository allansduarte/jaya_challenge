defmodule JayaChallenge.Repo.Migrations.AddTransactions do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS pg_trgm", "DROP EXTENSION pg_trgm"

    create_if_not_exists table(:transactions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :currency_from, :string
      add :amount, :decimal
      add :currency_to, :string
      add :rate, :decimal

      add :account_id, references(:accounts, type: :binary_id, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:transactions, [:account_id])
  end
end
