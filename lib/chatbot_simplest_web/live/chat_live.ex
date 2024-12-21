defmodule ChatbotSimplestWeb.ChatLive do
  use ChatbotSimplestWeb, :live_view

  alias ChatbotSimplest.OpenAI

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, messages: [], user_input: "", error: nil)}
  end

  @impl true
  def handle_event("send_message", %{"message" => user_text}, socket) do
    user_msg = %{role: "user", content: user_text}
    updated_messages = socket.assigns.messages ++ [user_msg]

    case OpenAI.send_messages(updated_messages) do
      {:ok, bot_msg} ->
        # Aseguramos que bot_msg tiene claves de átomos
        updated_messages = updated_messages ++ [bot_msg]
        {:noreply, assign(socket, messages: updated_messages, user_input: "", error: nil)}

      {:error, reason} ->
        {:noreply, assign(socket, error: reason)}
    end
  end
end
