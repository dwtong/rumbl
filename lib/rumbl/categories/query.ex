defmodule Rumbl.Categories.Query do
  import Ecto.Query

  def order_by_alphabetical(queryable) do
    from c in queryable, order_by: c.name
  end

  def select_by_name_and_id(queryable) do
    from c in queryable, select: {c.name, c.id}
  end
end
