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

  describe "GET /api/users/:account_id/transactions/:transaction_id" do
    test "list all users", ctx do
      transaction = insert(:transaction)
      account_id = transaction.account_id
      t_id = transaction.id

      %{
        "amount" => _,
        "amount_to" => nil,
        "created_at" => _,
        "currency_from" => "BRL",
        "currency_to" => "USD",
        "id" => _,
        "rate" => _,
        "user_id" => _
      } =
        ctx.conn
        |> get("/api/users/#{account_id}/transactions/#{t_id}")
        |> json_response(200)
    end

    test "with non-existent transaction", ctx do
      %{"type" => "jrn:error:not_found"} =
        ctx.conn
        |> get("/api/users/cd2f9197-c6de-46dd-8e01-eac5828b5211/transactions/cd2f9197-c6de-46dd-8e01-eac5828b5211")
        |> json_response(404)
    end
  end

  describe "POST /api/users/:account_id/transactions" do
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

    test "with valid user", ctx do
      user = insert(:account)
      account_id = user.id

      input = %{
        account_id: user.id,
        amount: 12,
        currency_from: "BRL",
        currency_to: "JPY"
      }

      %{
        "amount" => _,
        "amount_to" => _,
        "created_at" => _,
        "currency_from" => "BRL",
        "currency_to" => "JPY",
        "id" => _,
        "rate" => _,
        "user_id" => _
      } =
        ctx.conn
        |> post("/api/users/#{account_id}/transactions", input)
        |> json_response(201)
    end

    test "with invalid user", ctx do
      input = %{
        account_id: "cd2f9197-c6de-46dd-8e01-eac5828b5211",
        amount: 12,
        currency_from: "BRL",
        currency_to: "JPY"
      }

      %{"type" => "jrn:error:not_found"} =
        ctx.conn
        |> post("/api/users/cd2f9197-c6de-46dd-8e01-eac5828b5211/transactions", input)
        |> json_response(404)
    end
  end
end
