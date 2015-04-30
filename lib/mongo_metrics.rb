require "mongoid"
require "mongo_metrics/engine"
require "jquery-rails"
require "active_support/notifications"
require "mongo_metrics/csv_streamer"

module MongoMetrics
  EVENT = "process_action.action_controller"
  ActiveSupport::Notifications.subscribe EVENT do |*args|
  	MongoMetrics::MOngoMetrics.store!(args) unless mute?
  end

  def self.mute!
  	Thread.current["sql_metrics.mute"] = true
  	yield
  ensure
  	Thread.current["sql_metrics.mute"] = false
  end

  def self.mute?
 	Thread.current["sql_metrics.mute"] || false
  end
end
