defmodule JayaChallenge.Accounts do
  @moduledoc """
  Accounts context.
  """

  import Ecto.Query, warn: false

  alias JayaChallenge.Accounts.Schema.Account
  alias JayaChallenge.Repo

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Account
    |> Repo.all()
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user(id) do
    Account
    |> Repo.get_by(id: id)
    |> Repo.preload(:transactions)
    |> case do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  @doc """
  Registers an account.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %Account{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end
end
