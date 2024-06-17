defmodule JayaChallenge.AccountsTest do
  @moduledoc false

  use JayaChallenge.DataCase

  alias JayaChallenge.Accounts
  alias JayaChallenge.Accounts.Schema.Account

  describe "users" do
    @valid_attrs %{name: "Allan Soares Duarte"}
    @invalid_attrs %{name: nil}

    test "list_users/0 returns all users" do
      user = insert(:account)
      assert Accounts.list_users() == [user]
    end

    test "get_user/1 returns the user with given id" do
      user = insert(:account)
      assert Accounts.get_user(user.id) == {:ok, user}
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %Account{} = user} = Accounts.create_user(@valid_attrs)
      assert user.name == "Allan Soares Duarte"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end
  end
end
