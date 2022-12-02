defmodule LedgersBucketsWeb.BucketLiveTest do
  use LedgersBucketsWeb.ConnCase

  import Phoenix.LiveViewTest
  import LedgersBuckets.BucketsFixtures

  @create_attrs %{amount: "120.5", asset: "some asset", asset_reference: "some asset_reference", asset_type: "some asset_type", bucket_at: %{day: 1, hour: 20, minute: 37, month: 12, year: 2022}, bucket_id: "some bucket_id", bucket_tx_id: "some bucket_tx_id", is_spent: 42, lock_4_tx: 42, locked_at: %{day: 1, hour: 20, minute: 37, month: 12, year: 2022}, locked_by_tx_id: "some locked_by_tx_id", owner: "some owner", spent_at: %{day: 1, hour: 20, minute: 37, month: 12, year: 2022}, type: "some type", wallet: "some wallet"}
  @update_attrs %{amount: "456.7", asset: "some updated asset", asset_reference: "some updated asset_reference", asset_type: "some updated asset_type", bucket_at: %{day: 2, hour: 20, minute: 37, month: 12, year: 2022}, bucket_id: "some updated bucket_id", bucket_tx_id: "some updated bucket_tx_id", is_spent: 43, lock_4_tx: 43, locked_at: %{day: 2, hour: 20, minute: 37, month: 12, year: 2022}, locked_by_tx_id: "some updated locked_by_tx_id", owner: "some updated owner", spent_at: %{day: 2, hour: 20, minute: 37, month: 12, year: 2022}, type: "some updated type", wallet: "some updated wallet"}
  @invalid_attrs %{amount: nil, asset: nil, asset_reference: nil, asset_type: nil, bucket_at: %{day: 30, hour: 20, minute: 37, month: 2, year: 2022}, bucket_id: nil, bucket_tx_id: nil, is_spent: nil, lock_4_tx: nil, locked_at: %{day: 30, hour: 20, minute: 37, month: 2, year: 2022}, locked_by_tx_id: nil, owner: nil, spent_at: %{day: 30, hour: 20, minute: 37, month: 2, year: 2022}, type: nil, wallet: nil}

  defp create_bucket(_) do
    bucket = bucket_fixture()
    %{bucket: bucket}
  end

  describe "Index" do
    setup [:create_bucket]

    test "lists all buckets", %{conn: conn, bucket: bucket} do
      {:ok, _index_live, html} = live(conn, Routes.bucket_index_path(conn, :index))

      assert html =~ "Listing Buckets"
      assert html =~ bucket.asset
    end

    test "saves new bucket", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_index_path(conn, :index))

      assert index_live |> element("a", "New Bucket") |> render_click() =~
               "New Bucket"

      assert_patch(index_live, Routes.bucket_index_path(conn, :new))

      assert index_live
             |> form("#bucket-form", bucket: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#bucket-form", bucket: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_index_path(conn, :index))

      assert html =~ "Bucket created successfully"
      assert html =~ "some asset"
    end

    test "updates bucket in listing", %{conn: conn, bucket: bucket} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_index_path(conn, :index))

      assert index_live |> element("#bucket-#{bucket.id} a", "Edit") |> render_click() =~
               "Edit Bucket"

      assert_patch(index_live, Routes.bucket_index_path(conn, :edit, bucket))

      assert index_live
             |> form("#bucket-form", bucket: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#bucket-form", bucket: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_index_path(conn, :index))

      assert html =~ "Bucket updated successfully"
      assert html =~ "some updated asset"
    end

    test "deletes bucket in listing", %{conn: conn, bucket: bucket} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_index_path(conn, :index))

      assert index_live |> element("#bucket-#{bucket.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bucket-#{bucket.id}")
    end
  end

  describe "Show" do
    setup [:create_bucket]

    test "displays bucket", %{conn: conn, bucket: bucket} do
      {:ok, _show_live, html} = live(conn, Routes.bucket_show_path(conn, :show, bucket))

      assert html =~ "Show Bucket"
      assert html =~ bucket.asset
    end

    test "updates bucket within modal", %{conn: conn, bucket: bucket} do
      {:ok, show_live, _html} = live(conn, Routes.bucket_show_path(conn, :show, bucket))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bucket"

      assert_patch(show_live, Routes.bucket_show_path(conn, :edit, bucket))

      assert show_live
             |> form("#bucket-form", bucket: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#bucket-form", bucket: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_show_path(conn, :show, bucket))

      assert html =~ "Bucket updated successfully"
      assert html =~ "some updated asset"
    end
  end
end
