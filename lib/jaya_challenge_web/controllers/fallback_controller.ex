defmodule JayaChallengeWeb.FallbackController do
  use JayaChallengeWeb, :controller

  alias JayaChallengeWeb.{ChangesetView, ErrorView}

  @urn_params "jrn:error:invalid_params"
  @urn_not_found "jrn:error:not_found"
  @urn_conflict "jrn:error:conflict"

  @validation_errors [:invalid_params]
  @not_found_errors [:not_found]
  @unprocessable_entity [:already_exists]

  def call(conn, {:error, reason}) when reason in @unprocessable_entity do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ErrorView)
    |> render("error.json", %{type: @urn_conflict, reason: reason})
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ChangesetView)
    |> render("changeset_error.json", %{
      type: @urn_params,
      reason: :invalid_params,
      changeset: changeset
    })
  end

  def call(conn, {:error, reason}) when reason in @not_found_errors do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render("error.json", %{type: @urn_not_found})
  end

  def call(conn, {:error, reason}) when reason in @validation_errors do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", %{
      type: @urn_params,
      reason: :validation_error,
      error: reason
    })
  end

  def call(conn, {:error, reason}) do
    conn
    |> put_status(:bad_request)
    |> put_view(JayaChallengeWeb.ErrorView)
    |> render("error.json", %{type: @urn_params, reason: reason})
  end
end
