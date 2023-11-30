require "test_helper"

class DailyDumpTest < ActiveSupport::TestCase
  test "should not save duplicate file name of one code" do
    existing_daily_dump = daily_dumps(:one)

    duplicate_daily_dump = DailyDump.new(file_name: existing_daily_dump.file_name)
    assert_not duplicate_daily_dump.save, "Saved a DailyDump with a duplicate code"
  end

  test "should not save duplicate file name of one code upcase" do
    existing_daily_dump = daily_dumps(:one)

    duplicate_daily_dump = DailyDump.new(file_name: existing_daily_dump.file_name.upcase)
    assert_not duplicate_daily_dump.save, "Saved a DailyDump with a duplicate code"
  end

  test "should save DailyDump with unique code" do
    unique_daily_dump = DailyDump.new(file_name: 'FOO')

    assert unique_daily_dump.save, "Failed to save a DailyDump with a unique code"
  end
end
