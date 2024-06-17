defmodule JayaChallenge.Transactions.Commands.CurrencyConverterTest do
  @moduledoc false

  use JayaChallenge.DataCase

  alias JayaChallenge.Transactions.Commands.CurrencyConverter

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

  describe "Currency Converter" do
    test "with valid input" do
      user = insert(:account)
      input = %{
        account_id: user.id,
        amount: 12,
        currency_from: "BRL",
        currency_to: "JPY"
      }

      assert {:ok, transaction} = CurrencyConverter.execute(input)
      assert transaction.account_id == user.id
    end

    test "creates account with invalid user" do
      input = %{
        account_id: "b01fb675-52df-424f-a124-e1b2637adec4",
        amount: 12,
        currency_from: "BRL",
        currency_to: "JPY"
      }

      assert {:error, :not_found} = CurrencyConverter.execute(input)
    end
  end
end
