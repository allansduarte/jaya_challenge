defmodule JayaChallenge.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: JayaChallenge.Repo

  alias JayaChallenge.Accounts.Schema.Account

  def account_factory do
    %Account{name: "Allan Soares Duarte"}
  end
end
