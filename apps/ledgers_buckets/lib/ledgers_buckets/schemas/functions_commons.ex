defmodule LedgersBuckets.Domain.FunctionsCommons do


  def convert_params(params) do
    case :maps.next(:maps.iterator(params)) do
      {key, _, _} when is_atom(key) ->
        for {key, value} <- params, into: %{} do
          if is_atom(key) do
            {Atom.to_string(key), value}
          else
            raise Ecto.CastError, type: :map, value: params,
              message: "expected params to be a map with atoms or string keys, " <>
                         "got a map with mixed keys: #{inspect params}"
          end
        end
      _ ->
        params
    end
  end
end
