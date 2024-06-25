module ParamChecker
  extend ActiveSupport::Concern

  # This block runs when the module is included in a class
  included do
    before_action :check_required_params
  end

  class_methods do
    def require_params_for(action, *params)
      @action_required_params ||= {}
      @action_required_params[action] = params
    end

    def required_params_for(action)
      @action_required_params ||= {}
      @action_required_params[action] || []
    end
  end

  private

    def check_required_params
      @error_messages = []
      action = action_name.to_sym
      required_params = self.class.required_params_for(action)

      required_params.flat_map do |param|
        param_missing?(params, param, "") ? param : nil
      end.compact

      if @error_messages.any?
        render json: { errors: @error_messages }, status: :bad_request
      end
    end

    def param_missing?(params, key, chain)
      if key.is_a?(Hash)
        key.any? do |nested_key, nested_value|
          params[nested_key].nil? || param_missing?(params[nested_key], nested_value, chain.empty? ? nested_key :
            "#{chain}.#{nested_key}")
        end
      elsif key.is_a?(Array)
        key.flat_map do |param|
          param_missing?(params, param, chain) ? param : nil
        end
      else
        if params[key].nil?
          @error_messages << "#{key} must present inside #{chain}"
          return true
        end
      end
    end
end
