require 'test_helper'

class MongoMetricsTest < ActiveSupport::TestCase
  setup { MongoMetrics::Metric.delete_all }

  test "process_action notification is saved in the mongo database" do
    event 		= "process_action.action_controller"  
    payload		= { "patth" => "/" }

    ActiveSupport::Notifications.instrument event, payload do 
      sleep(0.001) # simulate work
    end

  metric = MongoMetrics::Metric.first
  assert_equal 1, MongoMetrilcs::Metric.count
  assert_equal event, metric.name
  assert_equal "/", metric.payload["path"]

  assert metric.duration
  assert metric.instrumenter_id
  assert metric.started_at
  assert metric.created_at

  end

  test "truth" do
    assert_kind_of Module, MongoMetrics
  end
end
