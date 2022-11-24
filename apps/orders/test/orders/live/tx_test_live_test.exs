defmodule Orders.TxTestLiveTest do
  use Orders.ConnCase

  import Phoenix.LiveViewTest
  import Core.TransaccionsFixtures

  @create_attrs %{ammount: "some ammount", owner: "some owner", reference: "some reference", tx_table: "some tx_table", way: "some way"}
  @update_attrs %{ammount: "some updated ammount", owner: "some updated owner", reference: "some updated reference", tx_table: "some updated tx_table", way: "some updated way"}
  @invalid_attrs %{ammount: nil, owner: nil, reference: nil, tx_table: nil, way: nil}

  defp create_tx_test(_) do
    tx_test = tx_test_fixture()
    %{tx_test: tx_test}
  end

  describe "Index" do
    setup [:create_tx_test]

    test "lists all tx_tests", %{conn: conn, tx_test: tx_test} do
      {:ok, _index_live, html} = live(conn, Routes.tx_test_index_path(conn, :index))

      assert html =~ "Listing Tx tests"
      assert html =~ tx_test.ammount
    end

    test "saves new tx_test", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.tx_test_index_path(conn, :index))

      assert index_live |> element("a", "New Tx test") |> render_click() =~
               "New Tx test"

      assert_patch(index_live, Routes.tx_test_index_path(conn, :new))

      assert index_live
             |> form("#tx_test-form", tx_test: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#tx_test-form", tx_test: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.tx_test_index_path(conn, :index))

      assert html =~ "Tx test created successfully"
      assert html =~ "some ammount"
    end

    test "updates tx_test in listing", %{conn: conn, tx_test: tx_test} do
      {:ok, index_live, _html} = live(conn, Routes.tx_test_index_path(conn, :index))

      assert index_live |> element("#tx_test-#{tx_test.id} a", "Edit") |> render_click() =~
               "Edit Tx test"

      assert_patch(index_live, Routes.tx_test_index_path(conn, :edit, tx_test))

      assert index_live
             |> form("#tx_test-form", tx_test: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#tx_test-form", tx_test: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.tx_test_index_path(conn, :index))

      assert html =~ "Tx test updated successfully"
      assert html =~ "some updated ammount"
    end

    test "deletes tx_test in listing", %{conn: conn, tx_test: tx_test} do
      {:ok, index_live, _html} = live(conn, Routes.tx_test_index_path(conn, :index))

      assert index_live |> element("#tx_test-#{tx_test.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#tx_test-#{tx_test.id}")
    end
  end

  describe "Show" do
    setup [:create_tx_test]

    test "displays tx_test", %{conn: conn, tx_test: tx_test} do
      {:ok, _show_live, html} = live(conn, Routes.tx_test_show_path(conn, :show, tx_test))

      assert html =~ "Show Tx test"
      assert html =~ tx_test.ammount
    end

    test "updates tx_test within modal", %{conn: conn, tx_test: tx_test} do
      {:ok, show_live, _html} = live(conn, Routes.tx_test_show_path(conn, :show, tx_test))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Tx test"

      assert_patch(show_live, Routes.tx_test_show_path(conn, :edit, tx_test))

      assert show_live
             |> form("#tx_test-form", tx_test: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#tx_test-form", tx_test: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.tx_test_show_path(conn, :show, tx_test))

      assert html =~ "Tx test updated successfully"
      assert html =~ "some updated ammount"
    end
  end
end
