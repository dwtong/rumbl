defmodule RumblWeb.UserView do
  use RumblWeb, :view
  
  def first_name(user) do
    user.name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
