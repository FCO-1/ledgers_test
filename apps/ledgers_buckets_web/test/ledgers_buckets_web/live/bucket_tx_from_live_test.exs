defmodule LedgersBucketsWeb.BucketTxFromLiveTest do
  use LedgersBucketsWeb.ConnCase

  import Phoenix.LiveViewTest
  import LedgersBuckets.BucketsFixtures

  @create_attrs %{amount: "120.5", asset: "some asset", bucket_tx_from_id: "some bucket_tx_from_id", owner: "some owner", type: "some type", wallet: "some wallet", weight: 42}
  @update_attrs %{amount: "456.7", asset: "some updated asset", bucket_tx_from_id: "some updated bucket_tx_from_id", owner: "some updated owner", type: "some updated type", wallet: "some updated wallet", weight: 43}
  @invalid_attrs %{amount: nil, asset: nil, bucket_tx_from_id: nil, owner: nil, type: nil, wallet: nil, weight: nil}

  defp create_bucket_tx_from(_) do
    bucket_tx_from = bucket_tx_from_fixture()
    %{bucket_tx_from: bucket_tx_from}
  end

  describe "Index" do
    setup [:create_bucket_tx_from]

    test "lists all bucket_tx_from", %{conn: conn, bucket_tx_from: bucket_tx_from} do
      {:ok, _index_live, html} = live(conn, Routes.bucket_tx_from_index_path(conn, :index))

      assert html =~ "Listing Bucket tx from"
      assert html =~ bucket_tx_from.asset
    end

    test "saves new bucket_tx_from", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_tx_from_index_path(conn, :index))

      assert index_live |> element("a", "New Bucket tx from") |> render_click() =~
               "New Bucket tx from"

      assert_patch(index_live, Routes.bucket_tx_from_index_path(conn, :new))

      assert index_live
             |> form("#bucket_tx_from-form", bucket_tx_from: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bucket_tx_from-form", bucket_tx_from: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_tx_from_index_path(conn, :index))

      assert html =~ "Bucket tx from created successfully"
      assert html =~ "some asset"
    end

    test "updates bucket_tx_from in listing", %{conn: conn, bucket_tx_from: bucket_tx_from} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_tx_from_index_path(conn, :index))

      assert index_live |> element("#bucket_tx_from-#{bucket_tx_from.id} a", "Edit") |> render_click() =~
               "Edit Bucket tx from"

      assert_patch(index_live, Routes.bucket_tx_from_index_path(conn, :edit, bucket_tx_from))

      assert index_live
             |> form("#bucket_tx_from-form", bucket_tx_from: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bucket_tx_from-form", bucket_tx_from: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_tx_from_index_path(conn, :index))

      assert html =~ "Bucket tx from updated successfully"
      assert html =~ "some updated asset"
    end

    test "deletes bucket_tx_from in listing", %{conn: conn, bucket_tx_from: bucket_tx_from} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_tx_from_index_path(conn, :index))

      assert index_live |> element("#bucket_tx_from-#{bucket_tx_from.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bucket_tx_from-#{bucket_tx_from.id}")
    end
  end

  describe "Show" do
    setup [:create_bucket_tx_from]

    test "displays bucket_tx_from", %{conn: conn, bucket_tx_from: bucket_tx_from} do
      {:ok, _show_live, html} = live(conn, Routes.bucket_tx_from_show_path(conn, :show, bucket_tx_from))

      assert html =~ "Show Bucket tx from"
      assert html =~ bucket_tx_from.asset
    end

    test "updates bucket_tx_from within modal", %{conn: conn, bucket_tx_from: bucket_tx_from} do
      {:ok, show_live, _html} = live(conn, Routes.bucket_tx_from_show_path(conn, :show, bucket_tx_from))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bucket tx from"

      assert_patch(show_live, Routes.bucket_tx_from_show_path(conn, :edit, bucket_tx_from))

      assert show_live
             |> form("#bucket_tx_from-form", bucket_tx_from: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#bucket_tx_from-form", bucket_tx_from: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_tx_from_show_path(conn, :show, bucket_tx_from))

      assert html =~ "Bucket tx from updated successfully"
      assert html =~ "some updated asset"
    end
  end
end
