defmodule Orders.UtxioLiveTest do
  use Orders.ConnCase

  import Phoenix.LiveViewTest
  import Core.TransactionsFixtures

  @create_attrs %{assetmedio: "some assetmedio", object_id: "some object_id", size: "120.5", tx_reference_id: "some tx_reference_id"}
  @update_attrs %{assetmedio: "some updated assetmedio", object_id: "some updated object_id", size: "456.7", tx_reference_id: "some updated tx_reference_id"}
  @invalid_attrs %{assetmedio: nil, object_id: nil, size: nil, tx_reference_id: nil}

  defp create_utxio(_) do
    utxio = utxio_fixture()
    %{utxio: utxio}
  end

  describe "Index" do
    setup [:create_utxio]

    test "lists all utxio", %{conn: conn, utxio: utxio} do
      {:ok, _index_live, html} = live(conn, Routes.utxio_index_path(conn, :index))

      assert html =~ "Listing Utxio"
      assert html =~ utxio.assetmedio
    end

    test "saves new utxio", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.utxio_index_path(conn, :index))

      assert index_live |> element("a", "New Utxio") |> render_click() =~
               "New Utxio"

      assert_patch(index_live, Routes.utxio_index_path(conn, :new))

      assert index_live
             |> form("#utxio-form", utxio: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#utxio-form", utxio: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.utxio_index_path(conn, :index))

      assert html =~ "Utxio created successfully"
      assert html =~ "some assetmedio"
    end

    test "updates utxio in listing", %{conn: conn, utxio: utxio} do
      {:ok, index_live, _html} = live(conn, Routes.utxio_index_path(conn, :index))

      assert index_live |> element("#utxio-#{utxio.id} a", "Edit") |> render_click() =~
               "Edit Utxio"

      assert_patch(index_live, Routes.utxio_index_path(conn, :edit, utxio))

      assert index_live
             |> form("#utxio-form", utxio: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#utxio-form", utxio: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.utxio_index_path(conn, :index))

      assert html =~ "Utxio updated successfully"
      assert html =~ "some updated assetmedio"
    end

    test "deletes utxio in listing", %{conn: conn, utxio: utxio} do
      {:ok, index_live, _html} = live(conn, Routes.utxio_index_path(conn, :index))

      assert index_live |> element("#utxio-#{utxio.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#utxio-#{utxio.id}")
    end
  end

  describe "Show" do
    setup [:create_utxio]

    test "displays utxio", %{conn: conn, utxio: utxio} do
      {:ok, _show_live, html} = live(conn, Routes.utxio_show_path(conn, :show, utxio))

      assert html =~ "Show Utxio"
      assert html =~ utxio.assetmedio
    end

    test "updates utxio within modal", %{conn: conn, utxio: utxio} do
      {:ok, show_live, _html} = live(conn, Routes.utxio_show_path(conn, :show, utxio))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Utxio"

      assert_patch(show_live, Routes.utxio_show_path(conn, :edit, utxio))

      assert show_live
             |> form("#utxio-form", utxio: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#utxio-form", utxio: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.utxio_show_path(conn, :show, utxio))

      assert html =~ "Utxio updated successfully"
      assert html =~ "some updated assetmedio"
    end
  end
end
