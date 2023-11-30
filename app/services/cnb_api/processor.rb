class CnbApi::Processor
  def execute(daily_dump_id)
    daily_dump = DailyDump.find daily_dump_id
    return unless daily_dump

    ex_rates_data = daily_dump.payload['rates'].map do |entry|
      {
        rate: entry["rate"],
        amount: entry["amount"],
        country: entry["country"],
        currency_name: entry["currency"],
        valid_for: entry["validFor"].to_date,
        currency_code: entry["currencyCode"]
      }
    end

    Currency.upsert_all(ex_rates_data, unique_by: :currency_code)
  rescue ActiveRecord::RecordNotFound => e
    # TODO, think about what to do in the case of missing daily dump
  end
end
