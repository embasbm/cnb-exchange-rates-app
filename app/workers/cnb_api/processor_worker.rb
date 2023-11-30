class CnbApi::ProcessorWorker
  include Sidekiq::Worker

  def perform(daily_dump_id)
    processor = CnbApi::Processor.new
    processor.execute(daily_dump_id)
  end
end
