defmodule LedgersBuckets.Domain.BucketsDomain do
  alias LedgersBuckets.Buckets


  def create_new_bucket_transaccion(attrs) do
    Buckets.create_new_bucket_transaccion(Map.merge(attrs, %{"is_spent" => 0, "locket_4_tx" => 0}))
  end

  def create_new_buckets_for_swap(attrs, list_buckets_ids) do
    sum = Buckets.get_sum_buckets_by_list_ids(list_buckets_ids)
    Buckets.create_new_bucket_transaccion_for_swap(Map.merge(attrs, %{"amount" => sum}), list_buckets_ids)
  end

  def create_new_buckets_for_partitions(attrs, amount, list_buckets_ids) do
    sum_from_buckets = Buckets.get_sum_buckets_by_list_ids(list_buckets_ids)
    if amount <= sum_from_buckets do
       remain = sum_from_buckets - amount
      Buckets.create_new_bucket_transaccion_for_new_buckets(attrs, amount, remain, list_buckets_ids)
    else
      {:error, %{"message" => "El monto es superior a lo que tiene en cuenta"} }
    end
  end
end
