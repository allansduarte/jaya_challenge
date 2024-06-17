defmodule JayaChallengeWeb.UsersControllerTest do
  @moduledoc false

  use JayaChallengeWeb.ConnCase, async: true

  describe "POST /api/users" do
    test "with valid payload", ctx do
      payload = %{
        user: %{
          name: "Allan Duarte"
        }
      }

      %{
        "created_at" => _,
        "id" => _,
        "name" => "Allan Duarte"
      } =
        ctx.conn
        |> post("/api/users", payload)
        |> json_response(201)
    end

    test "with invalid payload", ctx do
      payload = %{
        user: %{
          id: "Allan Duarte"
        }
      }

      %{
        "errors" => [%{"name" => ["can't be blank"]}],
        "reason" => "invalid_params",
        "type" => "jrn:error:invalid_params"
      } =
        ctx.conn
        |> post("/api/users", payload)
        |> json_response(422)
    end

    test "when name account exists", ctx do
      insert(:account)

      payload = %{
        user: %{
          name: "Allan Soares Duarte"
        }
      }

      %{
        "created_at" => _,
        "id" => _,
        "name" => "Allan Soares Duarte"
      } =
        ctx.conn
        |> post("/api/users", payload)
        |> json_response(201)
    end
  end

  describe "GET /api/users" do
    test "list all users", ctx do
      insert(:account)
      insert(:account)

      users =
        ctx.conn
        |> get("/api/users")
        |> json_response(200)

      assert length(users) == 2
    end
  end

  describe "GET /api/users/:id" do
    test "list an specific users", ctx do
      user = insert(:account)
      id = user.id

      %{
        "created_at" => _,
        "id" => _,
        "name" => "Allan Soares Duarte"
      } =
        ctx.conn
        |> get("/api/users/#{id}")
        |> json_response(200)
    end

    test "with non-existent user", ctx do
      %{"type" => "jrn:error:not_found"} =
        ctx.conn
        |> get("/api/users/828470cf-e1e3-45e6-9b80-14bee1321dcb")
        |> json_response(404)
    end
  end
end
