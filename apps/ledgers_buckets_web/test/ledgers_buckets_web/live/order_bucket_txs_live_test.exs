defmodule LedgersBucketsWeb.OrderBucketTxsLiveTest do
  use LedgersBucketsWeb.ConnCase

  import Phoenix.LiveViewTest
  import LedgersBuckets.OrdersFixtures

  @create_attrs %{order_id: "some order_id", reference_id: "some reference_id", reference_type: "some reference_type"}
  @update_attrs %{order_id: "some updated order_id", reference_id: "some updated reference_id", reference_type: "some updated reference_type"}
  @invalid_attrs %{order_id: nil, reference_id: nil, reference_type: nil}

  defp create_order_bucket_txs(_) do
    order_bucket_txs = order_bucket_txs_fixture()
    %{order_bucket_txs: order_bucket_txs}
  end

  describe "Index" do
    setup [:create_order_bucket_txs]

    test "lists all order_bucket_txs", %{conn: conn, order_bucket_txs: order_bucket_txs} do
      {:ok, _index_live, html} = live(conn, Routes.order_bucket_txs_index_path(conn, :index))

      assert html =~ "Listing Order bucket txs"
      assert html =~ order_bucket_txs.order_id
    end

    test "saves new order_bucket_txs", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.order_bucket_txs_index_path(conn, :index))

      assert index_live |> element("a", "New Order bucket txs") |> render_click() =~
               "New Order bucket txs"

      assert_patch(index_live, Routes.order_bucket_txs_index_path(conn, :new))

      assert index_live
             |> form("#order_bucket_txs-form", order_bucket_txs: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#order_bucket_txs-form", order_bucket_txs: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.order_bucket_txs_index_path(conn, :index))

      assert html =~ "Order bucket txs created successfully"
      assert html =~ "some order_id"
    end

    test "updates order_bucket_txs in listing", %{conn: conn, order_bucket_txs: order_bucket_txs} do
      {:ok, index_live, _html} = live(conn, Routes.order_bucket_txs_index_path(conn, :index))

      assert index_live |> element("#order_bucket_txs-#{order_bucket_txs.id} a", "Edit") |> render_click() =~
               "Edit Order bucket txs"

      assert_patch(index_live, Routes.order_bucket_txs_index_path(conn, :edit, order_bucket_txs))

      assert index_live
             |> form("#order_bucket_txs-form", order_bucket_txs: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#order_bucket_txs-form", order_bucket_txs: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.order_bucket_txs_index_path(conn, :index))

      assert html =~ "Order bucket txs updated successfully"
      assert html =~ "some updated order_id"
    end

    test "deletes order_bucket_txs in listing", %{conn: conn, order_bucket_txs: order_bucket_txs} do
      {:ok, index_live, _html} = live(conn, Routes.order_bucket_txs_index_path(conn, :index))

      assert index_live |> element("#order_bucket_txs-#{order_bucket_txs.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#order_bucket_txs-#{order_bucket_txs.id}")
    end
  end

  describe "Show" do
    setup [:create_order_bucket_txs]

    test "displays order_bucket_txs", %{conn: conn, order_bucket_txs: order_bucket_txs} do
      {:ok, _show_live, html} = live(conn, Routes.order_bucket_txs_show_path(conn, :show, order_bucket_txs))

      assert html =~ "Show Order bucket txs"
      assert html =~ order_bucket_txs.order_id
    end

    test "updates order_bucket_txs within modal", %{conn: conn, order_bucket_txs: order_bucket_txs} do
      {:ok, show_live, _html} = live(conn, Routes.order_bucket_txs_show_path(conn, :show, order_bucket_txs))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Order bucket txs"

      assert_patch(show_live, Routes.order_bucket_txs_show_path(conn, :edit, order_bucket_txs))

      assert show_live
             |> form("#order_bucket_txs-form", order_bucket_txs: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#order_bucket_txs-form", order_bucket_txs: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.order_bucket_txs_show_path(conn, :show, order_bucket_txs))

      assert html =~ "Order bucket txs updated successfully"
      assert html =~ "some updated order_id"
    end
  end
end
