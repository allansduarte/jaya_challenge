defmodule JayaChallenge.TransactionsTest do
  @moduledoc false

  use JayaChallenge.DataCase

  alias JayaChallenge.Transactions

  @valid_attrs %{amount: 10, currency_from: "BRL", currency_to: "USD", rate: 1.24232}

  describe "transactions" do
    test "list_transactions/0 return all transactions" do
      transaction = insert(:transaction)

      assert Transactions.list_transactions(transaction.account) == [transaction]
    end

    test "list_transactions/1 return all transactions when passing an user" do
      transaction = insert(:transaction)

      assert Transactions.list_transactions(transaction.account) == [transaction]
    end

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
  end
end
