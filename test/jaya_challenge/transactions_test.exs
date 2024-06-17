defmodule JayaChallenge.TransactionsTest do
  @moduledoc false

  use JayaChallenge.DataCase

  alias JayaChallenge.Transactions

  @valid_attrs %{amount: 10, currency_from: "BRL", currency_to: "USD", rate: 1.24232}

  setup do
    Tesla.Mock.mock(fn
      %{method: :get} ->
        %Tesla.Env{
          status: 200,
          body: %{
            "base" => "EUR",
            "date" => "2024-06-17",
            "rates" => %{
              "BRL" => 5.801125,
              "JPY" => 169.227132,
              "USD" => 1.072674,
              "EUR" => 1
            }
          }
        }
    end)

    :ok
  end

  describe "transactions" do
    test "create_transaction/2 return a transaction" do
      user = insert(:account)
      {:ok, transaction} = Transactions.create_transaction(user, @valid_attrs)

      assert transaction.account_id == user.id
      assert transaction.amount == Decimal.new(@valid_attrs.amount)
    end

    test "create_transaction/2 with invalid params" do
      user = insert(:account)

      {:error, _changeset} = Transactions.create_transaction(user, %{amount: 10})
    end

    test "get_transaction/1 with valid user" do
      transaction = insert(:transaction)

      assert Transactions.get_transaction(transaction.id) == {:ok, transaction}
    end

    test "get_transaction/1 with invalid user" do
      assert {:error, :not_found} = Transactions.get_transaction("828470cf-e1e3-45e6-9b80-14bee1321dcb")
    end

    test "currency_converter/1 delegates to command execution" do
      user = insert(:account)
      input = %{
        account_id: user.id,
        amount: 12,
        currency_from: "BRL",
        currency_to: "JPY"
      }

      assert {:ok, transaction} = Transactions.currency_converter(input)
      assert transaction.account_id == user.id
    end
  end
end
