defmodule ChatbotSimplest.OpenAI do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.openai.com/v1"
  plug Tesla.Middleware.Headers, [{"Authorization", "Bearer #{System.get_env("OPENAI_API_KEY")}"}]
  plug Tesla.Middleware.JSON

  @doc """
  Envía una lista de mensajes a la API de OpenAI (ChatGPT).
  Espera que `messages` sea algo como:
    [%{role: "user", content: "Hola"}, %{role: "assistant", content: "¡Hola!"}]
  Retorna {:ok, nuevo_mensaje} o {:error, reason}
  """
  def send_messages(messages) when is_list(messages) do
    body = %{
      "model" => "gpt-4o-mini",
      "messages" => messages
    }

    case post("/chat/completions", body) do
      {:ok, %Tesla.Env{status: 200, body: %{"choices" => [%{"message" => reply} | _]}}} ->
        # Convertir las claves de strings a átomos
        converted_reply = convert_keys_to_atoms(reply)
        {:ok, converted_reply}

      {:ok, %Tesla.Env{status: code, body: body}} ->
        {:error, "OpenAI error #{code}: #{inspect(body)}"}

      {:error, reason} ->
        {:error, inspect(reason)}
    end
  end

  # Función auxiliar para convertir claves de strings a átomos solo para claves conocidas
  defp convert_keys_to_atoms(map) when is_map(map) do
    %{
      role: Map.get(map, "role"),
      content: Map.get(map, "content")
      # Puedes añadir más claves si es necesario
    }
  end
end
