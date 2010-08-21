HoptoadNotifier.configure do |config|
  config.api_key = '34be970cfab2a1f901866f43b8354945'
end

module HoptoadNotifier
  class Notice
    private
    def also_use_rack_params_filters
      if args[:rack_env]
        params_filters = self.params_filters + (rack_request.env["action_dispatch.parameter_filter"] || [])
      end
    end
  end
end