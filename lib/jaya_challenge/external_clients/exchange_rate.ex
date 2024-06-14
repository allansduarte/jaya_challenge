defmodule JayaChallenge.ExternalClients.ExchangeRate do
  @moduledoc """
  ExchangeRate client interface module.
  """

  use Tesla

  plug Tesla.Middleware.BaseUrl, "http://api.exchangeratesapi.io"
  plug Tesla.Middleware.JSON

  def latest_rate() do
    get("/latest?base=EUR")
  end
end
