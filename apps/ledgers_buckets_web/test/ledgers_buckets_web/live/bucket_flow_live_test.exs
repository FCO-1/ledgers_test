defmodule LedgersBucketsWeb.BucketFlowLiveTest do
  use LedgersBucketsWeb.ConnCase

  import Phoenix.LiveViewTest
  import LedgersBuckets.BucketsFixtures

  @create_attrs %{amount: "120.5", bucket_flow_id: "some bucket_flow_id", bucket_in: "some bucket_in", bucket_out: "some bucket_out", bucket_tx_id: "some bucket_tx_id"}
  @update_attrs %{amount: "456.7", bucket_flow_id: "some updated bucket_flow_id", bucket_in: "some updated bucket_in", bucket_out: "some updated bucket_out", bucket_tx_id: "some updated bucket_tx_id"}
  @invalid_attrs %{amount: nil, bucket_flow_id: nil, bucket_in: nil, bucket_out: nil, bucket_tx_id: nil}

  defp create_bucket_flow(_) do
    bucket_flow = bucket_flow_fixture()
    %{bucket_flow: bucket_flow}
  end

  describe "Index" do
    setup [:create_bucket_flow]

    test "lists all bucket_flows", %{conn: conn, bucket_flow: bucket_flow} do
      {:ok, _index_live, html} = live(conn, Routes.bucket_flow_index_path(conn, :index))

      assert html =~ "Listing Bucket flows"
      assert html =~ bucket_flow.bucket_flow_id
    end

    test "saves new bucket_flow", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_flow_index_path(conn, :index))

      assert index_live |> element("a", "New Bucket flow") |> render_click() =~
               "New Bucket flow"

      assert_patch(index_live, Routes.bucket_flow_index_path(conn, :new))

      assert index_live
             |> form("#bucket_flow-form", bucket_flow: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bucket_flow-form", bucket_flow: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_flow_index_path(conn, :index))

      assert html =~ "Bucket flow created successfully"
      assert html =~ "some bucket_flow_id"
    end

    test "updates bucket_flow in listing", %{conn: conn, bucket_flow: bucket_flow} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_flow_index_path(conn, :index))

      assert index_live |> element("#bucket_flow-#{bucket_flow.id} a", "Edit") |> render_click() =~
               "Edit Bucket flow"

      assert_patch(index_live, Routes.bucket_flow_index_path(conn, :edit, bucket_flow))

      assert index_live
             |> form("#bucket_flow-form", bucket_flow: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bucket_flow-form", bucket_flow: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_flow_index_path(conn, :index))

      assert html =~ "Bucket flow updated successfully"
      assert html =~ "some updated bucket_flow_id"
    end

    test "deletes bucket_flow in listing", %{conn: conn, bucket_flow: bucket_flow} do
      {:ok, index_live, _html} = live(conn, Routes.bucket_flow_index_path(conn, :index))

      assert index_live |> element("#bucket_flow-#{bucket_flow.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bucket_flow-#{bucket_flow.id}")
    end
  end

  describe "Show" do
    setup [:create_bucket_flow]

    test "displays bucket_flow", %{conn: conn, bucket_flow: bucket_flow} do
      {:ok, _show_live, html} = live(conn, Routes.bucket_flow_show_path(conn, :show, bucket_flow))

      assert html =~ "Show Bucket flow"
      assert html =~ bucket_flow.bucket_flow_id
    end

    test "updates bucket_flow within modal", %{conn: conn, bucket_flow: bucket_flow} do
      {:ok, show_live, _html} = live(conn, Routes.bucket_flow_show_path(conn, :show, bucket_flow))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bucket flow"

      assert_patch(show_live, Routes.bucket_flow_show_path(conn, :edit, bucket_flow))

      assert show_live
             |> form("#bucket_flow-form", bucket_flow: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#bucket_flow-form", bucket_flow: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bucket_flow_show_path(conn, :show, bucket_flow))

      assert html =~ "Bucket flow updated successfully"
      assert html =~ "some updated bucket_flow_id"
    end
  end
end
