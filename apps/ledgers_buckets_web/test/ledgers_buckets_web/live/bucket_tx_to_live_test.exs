defmodule LedgersBucketsWeb.BucketTxToLiveTest do
  use LedgersBucketsWeb.ConnCase

  import Phoenix.LiveViewTest
  import LedgersBuckets.BucketsFixtures

  @create_attrs %{amount: "120.5", assets: "some assets", bucket_tx_id: "some bucket_tx_id", onwer: "some onwer", wallet: "some wallet"}
  @update_attrs %{amount: "456.7", assets: "some updated assets", bucket_tx_id: "some updated bucket_tx_id", onwer: "some updated onwer", wallet: "some updated wallet"}
  @invalid_attrs %{amount: nil, assets: nil, bucket_tx_id: nil, onwer: nil, wallet: nil}

  defp create_bucket_tx_to(_) do
    bucket_tx_to = bucket_tx_to_fixture()
    %{bucket_tx_to: bucket_tx_to}
  end

  describe "Index" do
    setup [:create_bucket_tx_to]

    test "lists all bucket_tx_to", %{conn: conn, bucket_tx_to: bucket_tx_to} do
      {:ok, _index_live, html} = live(conn, Routes.bucket_tx_to_index_path(conn, :index))

      assert html =~ "Listing Bucket tx to"
      assert html =~ bucket_tx_to.assets
    end

    test "saves new bucket_tx_to", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_tx_to_index_path(conn, :index))

      assert index_live |> element("a", "New Bucket tx to") |> render_click() =~
               "New Bucket tx to"

      assert_patch(index_live, Routes.bucket_tx_to_index_path(conn, :new))

      assert index_live
             |> form("#bucket_tx_to-form", bucket_tx_to: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bucket_tx_to-form", bucket_tx_to: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_tx_to_index_path(conn, :index))

      assert html =~ "Bucket tx to created successfully"
      assert html =~ "some assets"
    end

    test "updates bucket_tx_to in listing", %{conn: conn, bucket_tx_to: bucket_tx_to} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_tx_to_index_path(conn, :index))

      assert index_live |> element("#bucket_tx_to-#{bucket_tx_to.id} a", "Edit") |> render_click() =~
               "Edit Bucket tx to"

      assert_patch(index_live, Routes.bucket_tx_to_index_path(conn, :edit, bucket_tx_to))

      assert index_live
             |> form("#bucket_tx_to-form", bucket_tx_to: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bucket_tx_to-form", bucket_tx_to: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_tx_to_index_path(conn, :index))

      assert html =~ "Bucket tx to updated successfully"
      assert html =~ "some updated assets"
    end

    test "deletes bucket_tx_to in listing", %{conn: conn, bucket_tx_to: bucket_tx_to} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_tx_to_index_path(conn, :index))

      assert index_live |> element("#bucket_tx_to-#{bucket_tx_to.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bucket_tx_to-#{bucket_tx_to.id}")
    end
  end

  describe "Show" do
    setup [:create_bucket_tx_to]

    test "displays bucket_tx_to", %{conn: conn, bucket_tx_to: bucket_tx_to} do
      {:ok, _show_live, html} = live(conn, Routes.bucket_tx_to_show_path(conn, :show, bucket_tx_to))

      assert html =~ "Show Bucket tx to"
      assert html =~ bucket_tx_to.assets
    end

    test "updates bucket_tx_to within modal", %{conn: conn, bucket_tx_to: bucket_tx_to} do
      {:ok, show_live, _html} = live(conn, Routes.bucket_tx_to_show_path(conn, :show, bucket_tx_to))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bucket tx to"

      assert_patch(show_live, Routes.bucket_tx_to_show_path(conn, :edit, bucket_tx_to))

      assert show_live
             |> form("#bucket_tx_to-form", bucket_tx_to: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#bucket_tx_to-form", bucket_tx_to: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_tx_to_show_path(conn, :show, bucket_tx_to))

      assert html =~ "Bucket tx to updated successfully"
      assert html =~ "some updated assets"
    end
  end
end
