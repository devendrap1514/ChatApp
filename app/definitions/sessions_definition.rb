RequestParamsValidation.define do
  action :login do
    request do
      required :email, type: :string
      required :password, type: :string
    end
  end
end
