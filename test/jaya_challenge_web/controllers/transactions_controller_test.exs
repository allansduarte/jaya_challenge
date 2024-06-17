defmodule JayaChallengeWeb.TransactionsControllerTest do
  @moduledoc false

  use JayaChallengeWeb.ConnCase, async: true

  describe "GET /api/users/:account_id/transactions" do
    test "list all users", ctx do
      user = insert(:account)
      insert(:transaction, account: user)
      insert(:transaction, account: user)

      transactions =
        ctx.conn
        |> get("/api/users/#{user.id}/transactions")
        |> json_response(200)

      assert length(transactions) == 2
    end
  end

  describe "GET /api/users/:account_id/transactions/transaction_id" do
    test "list all users", ctx do
      transaction = insert(:transaction)
      account_id = transaction.account_id
      t_id = transaction.id

      %{} =
        ctx.conn
        |> get("/api/users/#{account_id}/transactions/#{t_id}")
        |> json_response(200)

      # assert length(transactions) == 2
    end
  end
end
