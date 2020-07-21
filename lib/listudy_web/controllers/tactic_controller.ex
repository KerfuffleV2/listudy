defmodule ListudyWeb.TacticController do
  use ListudyWeb, :controller

  alias Listudy.Motifs
  alias Listudy.Tactics
  alias Listudy.Tactics.Tactic

  def index(conn, _params) do
    tactics = Tactics.list_tactics()
    render(conn, "index.html", tactics: tactics)
  end

  def new(conn, _params) do
    changeset = Tactics.change_tactic(%Tactic{})
    motifs = Motifs.list_motifs()
    render(conn, "new.html", changeset: changeset, motifs: motifs)
  end

  def create(conn, %{"tactic" => tactic_params}) do
    case Tactics.create_tactic(tactic_params) do
      {:ok, tactic} ->
        conn
        |> put_flash(:info, "Tactic created successfully.")
        |> redirect(to: Routes.tactic_path(conn, :show, tactic))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tactic = Tactics.get_tactic!(id)
    motifs = Motifs.list_motifs()
    render(conn, "show.html", tactic: tactic, motifs: motifs)
  end

  def edit(conn, %{"id" => id}) do
    tactic = Tactics.get_tactic!(id)
    motifs = Motifs.list_motifs()
    changeset = Tactics.change_tactic(tactic)
    render(conn, "edit.html", tactic: tactic, changeset: changeset, motifs: motifs)
  end

  def update(conn, %{"id" => id, "tactic" => tactic_params}) do
    tactic = Tactics.get_tactic!(id)

    case Tactics.update_tactic(tactic, tactic_params) do
      {:ok, tactic} ->
        conn
        |> put_flash(:info, "Tactic updated successfully.")
        |> redirect(to: Routes.tactic_path(conn, :show, tactic))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tactic: tactic, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tactic = Tactics.get_tactic!(id)
    {:ok, _tactic} = Tactics.delete_tactic(tactic)

    conn
    |> put_flash(:info, "Tactic deleted successfully.")
    |> redirect(to: Routes.tactic_path(conn, :index))
  end
end
