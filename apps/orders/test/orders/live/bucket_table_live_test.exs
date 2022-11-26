defmodule Orders.BucketTableLiveTest do
  use Orders.ConnCase

  import Phoenix.LiveViewTest
  import Core.BucketsFixtures

  @create_attrs %{ammount: "some ammount", asset: "some asset", bucket_id: "some bucket_id", hash: "some hash", locked_by: "some locked_by", owner: "some owner", state_locked: "some state_locked", state_spent: "some state_spent"}
  @update_attrs %{ammount: "some updated ammount", asset: "some updated asset", bucket_id: "some updated bucket_id", hash: "some updated hash", locked_by: "some updated locked_by", owner: "some updated owner", state_locked: "some updated state_locked", state_spent: "some updated state_spent"}
  @invalid_attrs %{ammount: nil, asset: nil, bucket_id: nil, hash: nil, locked_by: nil, owner: nil, state_locked: nil, state_spent: nil}

  defp create_bucket_table(_) do
    bucket_table = bucket_table_fixture()
    %{bucket_table: bucket_table}
  end

  describe "Index" do
    setup [:create_bucket_table]

    test "lists all bucket_table", %{conn: conn, bucket_table: bucket_table} do
      {:ok, _index_live, html} = live(conn, Routes.bucket_table_index_path(conn, :index))

      assert html =~ "Listing Bucket table"
      assert html =~ bucket_table.ammount
    end

    test "saves new bucket_table", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_table_index_path(conn, :index))

      assert index_live |> element("a", "New Bucket table") |> render_click() =~
               "New Bucket table"

      assert_patch(index_live, Routes.bucket_table_index_path(conn, :new))

      assert index_live
             |> form("#bucket_table-form", bucket_table: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bucket_table-form", bucket_table: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_table_index_path(conn, :index))

      assert html =~ "Bucket table created successfully"
      assert html =~ "some ammount"
    end

    test "updates bucket_table in listing", %{conn: conn, bucket_table: bucket_table} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_table_index_path(conn, :index))

      assert index_live |> element("#bucket_table-#{bucket_table.id} a", "Edit") |> render_click() =~
               "Edit Bucket table"

      assert_patch(index_live, Routes.bucket_table_index_path(conn, :edit, bucket_table))

      assert index_live
             |> form("#bucket_table-form", bucket_table: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bucket_table-form", bucket_table: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_table_index_path(conn, :index))

      assert html =~ "Bucket table updated successfully"
      assert html =~ "some updated ammount"
    end

    test "deletes bucket_table in listing", %{conn: conn, bucket_table: bucket_table} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_table_index_path(conn, :index))

      assert index_live |> element("#bucket_table-#{bucket_table.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bucket_table-#{bucket_table.id}")
    end
  end

  describe "Show" do
    setup [:create_bucket_table]

    test "displays bucket_table", %{conn: conn, bucket_table: bucket_table} do
      {:ok, _show_live, html} = live(conn, Routes.bucket_table_show_path(conn, :show, bucket_table))

      assert html =~ "Show Bucket table"
      assert html =~ bucket_table.ammount
    end

    test "updates bucket_table within modal", %{conn: conn, bucket_table: bucket_table} do
      {:ok, show_live, _html} = live(conn, Routes.bucket_table_show_path(conn, :show, bucket_table))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bucket table"

      assert_patch(show_live, Routes.bucket_table_show_path(conn, :edit, bucket_table))

      assert show_live
             |> form("#bucket_table-form", bucket_table: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#bucket_table-form", bucket_table: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_table_show_path(conn, :show, bucket_table))

      assert html =~ "Bucket table updated successfully"
      assert html =~ "some updated ammount"
    end
  end
end
