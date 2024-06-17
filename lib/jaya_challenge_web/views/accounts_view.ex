defmodule JayaChallengeWeb.AccountsView do
  @moduledoc false
  use JayaChallengeWeb, :view

  def render("index.json", %{users: users}) do
    render_many(users, __MODULE__, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, __MODULE__, "user.json")
  end

  def render("user.json", %{accounts: user}) do
    %{
      id: user.id,
      name: user.name,
      created_at: user.inserted_at
    }
  end
end
