class RevenueFacade
  def self.total_revenue_across_date_range(start_date, end_date)
    total_revenue = Invoice.joins(:invoice_items, :transactions)
                    .merge(Transaction.success)
                    .where(invoices: {status: 'shipped'}, created_at: Date.parse(start_date.to_s).beginning_of_day..Date.parse(end_date.to_s).end_of_day)
                    .sum("invoice_items.unit_price * invoice_items.quantity")

    Revenue.new(total_revenue)
  end
end
