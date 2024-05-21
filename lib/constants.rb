module Constants
  def self.record
    types = {
      not_found: 'Record not found',
      invalid: 'Record is invalid'
    }

    OpenStruct.new(
      types: OpenStruct.new(values: types.values, **types).freeze,
    ).freeze
  end

  def self.message
    types = {
      created_successfully: 'Created Successfully',
      updated_successfully: 'Updated Successfully',
      deleted_successfully: 'Deleted Successfully'
    }

    OpenStruct.new(
      types: OpenStruct.new(values: types.values, **types).freeze
    ).freeze
  end
end
