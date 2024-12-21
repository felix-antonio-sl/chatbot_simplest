defmodule ChatbotSimplestWeb.ErrorJSONTest do
  use ChatbotSimplestWeb.ConnCase, async: true

  test "renders 404" do
    assert ChatbotSimplestWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert ChatbotSimplestWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
