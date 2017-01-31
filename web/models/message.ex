defmodule ChatPhoenix.Message do
  use ChatPhoenix.Web, :model

  schema "messages" do
    field :author, :string
    field :body, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:author, :body])
    |> validate_required([:author, :body])
  end
end
