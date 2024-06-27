module RenderResponse
  extend ActiveSupport::Concern

  def render_created_response(serialize_data, *advance_params)
    serialize_data = add_advance_params(serialize_data, advance_params)
    render_response(:created, serialize_data)
  end

  def render_ok_response(serialize_data, *advance_params)
    serialize_data = add_advance_params(serialize_data, advance_params)
    render_response(:ok, serialize_data)
  end

  def render_unprocessable_response(errors, *advance_params)
    add_params_and_render(errors, advance_params, :unprocessable_entity)
  end

  def render_bad_request_response(errors, *advance_params)
    add_params_and_render(errors, advance_params, :bad_request)
  end

  def render_not_found_response(errors, *advance_params)
    add_params_and_render(errors, advance_params, :not_found)
  end

  def render_unauthorized_response(errors, *advance_params)
    add_params_and_render(errors, advance_params, :unauthorized)
  end

  private
    def add_params_and_render(errors, advance_params, status)
      serialize_data = {}
      serialize_data = serialize_data.merge(errors: errors)
      serialize_data = add_advance_params(serialize_data, advance_params)
      render_response(status, serialize_data)
    end
    def add_advance_params(serialize_data, advance_params)
      advance_params.each do |item|
        serialize_data = serialize_data.to_hash.merge!(item)
      end
      serialize_data
    end

    def render_response(status, data)
      render status: status, json: data
    end
end
