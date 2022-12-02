defmodule LedgersBucketsWeb.BucketTxsLiveTest do
  use LedgersBucketsWeb.ConnCase

  import Phoenix.LiveViewTest
  import LedgersBuckets.BucketsFixtures

  @create_attrs %{amount: "120.5", asset: "some asset", bucket_tx_at: "some bucket_tx_at", bucket_tx_id: "some bucket_tx_id", hash: "some hash", note: "some note", reference_id: "some reference_id", reference_type: "some reference_type", request_id: "some request_id", state: "some state", status: "some status", type: "some type"}
  @update_attrs %{amount: "456.7", asset: "some updated asset", bucket_tx_at: "some updated bucket_tx_at", bucket_tx_id: "some updated bucket_tx_id", hash: "some updated hash", note: "some updated note", reference_id: "some updated reference_id", reference_type: "some updated reference_type", request_id: "some updated request_id", state: "some updated state", status: "some updated status", type: "some updated type"}
  @invalid_attrs %{amount: nil, asset: nil, bucket_tx_at: nil, bucket_tx_id: nil, hash: nil, note: nil, reference_id: nil, reference_type: nil, request_id: nil, state: nil, status: nil, type: nil}

  defp create_bucket_txs(_) do
    bucket_txs = bucket_txs_fixture()
    %{bucket_txs: bucket_txs}
  end

  describe "Index" do
    setup [:create_bucket_txs]

    test "lists all bucket_txs", %{conn: conn, bucket_txs: bucket_txs} do
      {:ok, _index_live, html} = live(conn, Routes.bucket_txs_index_path(conn, :index))

      assert html =~ "Listing Bucket txs"
      assert html =~ bucket_txs.asset
    end

    test "saves new bucket_txs", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_txs_index_path(conn, :index))

      assert index_live |> element("a", "New Bucket txs") |> render_click() =~
               "New Bucket txs"

      assert_patch(index_live, Routes.bucket_txs_index_path(conn, :new))

      assert index_live
             |> form("#bucket_txs-form", bucket_txs: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bucket_txs-form", bucket_txs: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_txs_index_path(conn, :index))

      assert html =~ "Bucket txs created successfully"
      assert html =~ "some asset"
    end

    test "updates bucket_txs in listing", %{conn: conn, bucket_txs: bucket_txs} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_txs_index_path(conn, :index))

      assert index_live |> element("#bucket_txs-#{bucket_txs.id} a", "Edit") |> render_click() =~
               "Edit Bucket txs"

      assert_patch(index_live, Routes.bucket_txs_index_path(conn, :edit, bucket_txs))

      assert index_live
             |> form("#bucket_txs-form", bucket_txs: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bucket_txs-form", bucket_txs: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_txs_index_path(conn, :index))

      assert html =~ "Bucket txs updated successfully"
      assert html =~ "some updated asset"
    end

    test "deletes bucket_txs in listing", %{conn: conn, bucket_txs: bucket_txs} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_txs_index_path(conn, :index))

      assert index_live |> element("#bucket_txs-#{bucket_txs.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bucket_txs-#{bucket_txs.id}")
    end
  end

  describe "Show" do
    setup [:create_bucket_txs]

    test "displays bucket_txs", %{conn: conn, bucket_txs: bucket_txs} do
      {:ok, _show_live, html} = live(conn, Routes.bucket_txs_show_path(conn, :show, bucket_txs))

      assert html =~ "Show Bucket txs"
      assert html =~ bucket_txs.asset
    end

    test "updates bucket_txs within modal", %{conn: conn, bucket_txs: bucket_txs} do
      {:ok, show_live, _html} = live(conn, Routes.bucket_txs_show_path(conn, :show, bucket_txs))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bucket txs"

      assert_patch(show_live, Routes.bucket_txs_show_path(conn, :edit, bucket_txs))

      assert show_live
             |> form("#bucket_txs-form", bucket_txs: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#bucket_txs-form", bucket_txs: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_txs_show_path(conn, :show, bucket_txs))

      assert html =~ "Bucket txs updated successfully"
      assert html =~ "some updated asset"
    end
  end
end
