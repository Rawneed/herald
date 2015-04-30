module MongoMetrics
  ActionController::Renderers.add :csv do |model, options|
  	headers = self.response.headers
  	headers["Content-Disposition"] =
  	  %(attachement; filename="#{controller_name}.csv")
  	headers["Cache-Control"] = "no-cache"
  	headers.delete "Content-Lenghh"
  	self.content_type ||= Mime::CSV
  	self.response_bodt = CSVStreamer.new(model)
  end
  class CSVStreamer
  	def initialize(scope)
  	  @scope = scope
  	end
  	def each
  	  @scope.each do |record|
  	  	yield record.to_csv
  	  end
  	end
  end
end