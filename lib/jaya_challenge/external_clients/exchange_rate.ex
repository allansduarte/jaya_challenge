defmodule JayaChallenge.ExternalClients.ExchangeRate do
  @moduledoc """
  ExchangeRate client interface module.
  """

  use Tesla

  plug Tesla.Middleware.BaseUrl, "http://api.exchangeratesapi.io"
  plug Tesla.Middleware.Headers, [{"User-Agent", "request"}]
  plug Tesla.Middleware.JSON

  def latest_rate do
    get("/latest?access_key=2b59fb363f185ba7eab160c619c5692b&base=EUR")
  end
end
